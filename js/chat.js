var currentChat;
var latestMsg = false;
var latestChats = false;

window.addEventListener("load", function(){
	resize();
	window.addEventListener("resize", resize, false);
	getChats(function(){
		var row = document.getElementsByClassName("chatName")[0];
		focusChat(row.dataset.id);
	});
	document.getElementById("send").addEventListener("submit", function(event){
		event.preventDefault();
		send(document.getElementById("message").value);
	});
	setInterval(refresh, 2000);
	document.getElementById("newchat").addEventListener("click", newChat, false);
});

function sendForm(url, data, callback){
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			callback(JSON.parse(this.responseText));
		}
	};
	xhr.open("POST", url, true);
	xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	var txt = [];
	for (var i in data){
		txt.push(encodeURIComponent(i) + "=" + encodeURIComponent(data[i]));
	}
	xhr.send(txt.join("&"));
}

function send(txt){
	document.getElementById("message").value = "";
	sendForm("/helpers/send_message.php", {
		"chat_id": currentChat,
		"text": txt
	}, refresh);
}

function getChats(callback){
	var selected = document.querySelector(".chatName.selected");
	var select = false;
	if (selected) select = selected.dataset.id;
	sendForm("/helpers/fetch_chats.php", {}, function(chats){
		//Returns an array of JSON objects with keys "id", "name", "latest", and "members" in order from most recently active to least
		var newChats = JSON.stringify(chats);
		if (newChats != latestChats){
			latestChats = newChats;
			var tbody = document.querySelector(".chat tbody");
			tbody.innerHTML = "";
			for (var i = 0; i < chats.length; i++){
				var id = chats[i].id;
				var name = chats[i].name;
				var members = chats[i].members.join(", ");
				var latest = chats[i].latest;
				var tr = document.createElement("tr");
				var td = document.createElement("td");
				td.className = "chatName";
				td.innerHTML = '<p class="name">' + name + '</p><p class="latest">' + latest.time + ' - ' + latest.from + ': ' + latest.text + '</p>';
				td.dataset.id = id;
				td.dataset.members = members;
				if (select && id == select) td.className += " selected";
				td.addEventListener("click", function(){
					focusChat(this.dataset.id);
				});
				tr.appendChild(td);
				tbody.appendChild(tr);
				if (callback && typeof callback == "function") callback();
			}
		}
	});
}

function focusChat(id){
	var focused = document.querySelector(".chatName.selected");
	if (focused) focused.className = "chatName";
	var el = document.querySelector(".chatName[data-id=\"" + id + "\"]");
	el.className = "chatName selected";
	currentChat = id;
	document.getElementById("members").innerHTML = "<button id=\"addmember\" onclick=\"addMember()\">Add member</button>&nbsp;&nbsp;Chat members: " + el.dataset.members;
	//Fetch texts from that chat
	fetchMsg();
	document.getElementById("message").focus();
}

function fetchMsg(callback){
	sendForm("/helpers/fetch_messages.php", {"chat": currentChat}, function(messages){
		//Returns an array of JSON objects with keys "text", "time", "from", and "fullname" in order oldest to newest
		var newMsg = JSON.stringify(messages);
		if (newMsg != latestMsg){
			latestMsg = newMsg;
			var tbody = document.getElementById("msgbodybody");
			tbody.innerHTML = "";
			for (var i = 0; i < messages.length; i++){
				var from = messages[i].from;
				var text = messages[i].text;
				var name = messages[i].fullname;
				var tr = document.createElement("tr");
				var td = document.createElement("td");
				td.className = "message";
				if (from == username) {
					td.className += " fromMe";
					name = "Me";
				}
				td.innerHTML = '<p class="text">' + text.replace(/\n/g, "<br/>") + '</p><p class="from">' + name + ' - ' + messages[i].time + '</p>';
				tr.appendChild(td);
				tbody.appendChild(tr);
			}
			var table = document.getElementById("msgbody");
			table.scrollTop = table.scrollHeight;
			if (callback && typeof callback == "function") callback();
		}
	});
}

function refresh(callback){
	getChats(function(){
		if (callback && typeof callback == "function") fetchMsg(callback);
		else fetchMsg();
	});
}

function resize(){
	var height = window.innerHeight - document.getElementsByClassName("everything")[0].offsetHeight;
	height -= 120;
	document.getElementById("table").style.height = height + "px";
	document.getElementById("table").style.maxHeight = height + "px";
	var sendHeight = document.getElementById("msgfoot").offsetHeight;
	var bodyHeight = height - sendHeight - 8;
	document.getElementById("msgbody").style.height = bodyHeight + "px";
	document.getElementById("msgbody").style.maxHeight = bodyHeight + "px";
	var rightHeight = document.getElementsByClassName("messages")[0].parentElement.offsetHeight;
	rightHeight -= 10;
	document.getElementsByClassName("chat")[0].style.height = rightHeight + "px";
	document.getElementsByClassName("chat")[0].style.maxHeight = rightHeight + "px";
}

function newChat(){
	var display = document.getElementById("members");
	display.innerHTML = "";
	var title = document.createElement("input");
	title.type = "text";
	title.className = "normal";
	title.value = "Untitled Chat";
	display.appendChild(title);
	title.addEventListener("focus", title.select, false);
	title.focus();
	display.appendChild(document.createElement("br"));
	var span = document.createElement("span");
	span.innerHTML = "Enter usernames: ";
	display.appendChild(span);
	var input = document.createElement("input");
	input.type = "text";
	input.className = "normal";
	input.placeholder = "friend";
	var members = [];
	input.addEventListener("keypress", function(event){
		if (event.keyCode == 13){
			members.push(input.value);
			span.innerHTML += input.value + ", ";
			input.value = "";
		}
	});
	display.appendChild(input);
	var button = document.createElement("button");
	button.id = "createchat";
	button.innerHTML = "Create chat";
	button.addEventListener("click", function(){
		if (input.value.length > 0) members.push(input.value);
		sendForm("/helpers/create_chat.php", {
			"members": JSON.stringify(members),
			"name": title.value
		}, function(){
			refresh(function(){
				focusChat(document.getElementsByClassName("chatName")[0].dataset.id);
			});
		});
	});
	display.appendChild(button);
	var p = document.createElement("p");
	p.innerHTML = "(Hint: add the username BotRoccoli to speak with a chatbot)";
	display.append(p);
}

function addMember(){
	var input = document.createElement("input");
	input.type = "text";
	input.className = "normal";
	input.placeholder = "friend";
	input.addEventListener("focus", input.select, false);
	var submit = document.createElement("input");
	submit.type = "submit";
	submit.id = "addsubmit";
	submit.value = "Add user";
	var form = document.createElement("form");
	form.action = "";
	form.method = "post";
	form.style.display = "inline";
	form.addEventListener("submit", function(event){
		event.preventDefault();
		sendForm("/helpers/add_member.php", {
			"member": input.value,
			"chat_id": currentChat
		}, function(){
			refresh(function(){
				focusChat(document.getElementsByClassName("chatName")[0].dataset.id);
			});
		});
	}, false);
	form.appendChild(input);
	form.appendChild(submit);
	var display = document.getElementById("members");
	display.innerHTML = "Enter username: ";
	display.appendChild(form);
	input.focus();
}