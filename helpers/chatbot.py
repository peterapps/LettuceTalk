#!/usr/bin/env python3
import string
import random
import urllib.request
import urllib.parse
import json
import sys
import time

def respond(user, name, txt, lastFromUser, lastFromMe):
    txt = txt.lower()
    lastFromUser = lastFromUser.lower()
    #Bot Conv
    if "hello" in txt or "hey" in txt:
        return "Hello I am BotRoccoli"
    if "who are you?" in txt:
        return "I am BotRoccoli, a very complex chatbot made by the OGs."
    if "how are you?" in txt:
        return "Sorry I can not anwser that question as robots like me do not have feelings."
    if "what is the meaning of life?" in txt:
        return "42"
    if "what is love?" in txt:
        return "baby don't hurt me"
    #Bot Commands
    if "!roll a die" in txt:
        return "Can do.\n" + str(random.randint(1, 6))
    if "!date" in txt:
        return time.strftime("%m-%d-%y", time.localtime())
    if "!time" in txt:
        return time.strftime("%H:%M:%S", time.localtime())
    if "!tell me about" in txt:
        index = txt.index("about") + 6
        if "tell me about a " in txt:
            index = txt.index("about a") + 8
        word = txt[index:]
        try:
            raw = getWikipedia(word)
        except:
            raw = None
        if raw:
            return "Here's what I could find:\n" + getWikipedia(word)
        else:
            return "Sorry I could not find information on that."
    if "Here's what I could find:" in lastFromMe and "!tell me more" in txt:
        index = lastFromUser.index("about") + 6
        if "tell me about a " in lastFromUser:
            index = lastFromUser.index("about a") + 8
        word = lastFromUser[index:]
        return "To find more click on this link\nhttps://en.wikipedia.org/wiki/" + word
    if txt == "!joke":
        return "Where does the army hide his armies?"
    if lastFromMe == "Where does the army hide his armies?":
        return "In his Sleevies."
    if "!roll" in txt:
        index = txt.index("roll") + 5
        rollRange = txt[index:]
        return str(random.randint(1, int(rollRange)))
    if "!help" in txt:
        return "\nhi\ntell a joke\nwho are you?\nroll a die\nhow are you?\ntell me about [insert topic] and tell me more (after you ask about a topic)\nroll [number of sides of die]"
    return False

def removePunc(txt):
    return txt.translate(None, string.punctuation)

def getWikipedia(title):
    url = "http://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro=&explaintext=&titles="
    url = url + urllib.parse.quote_plus(title)
    response = urllib.request.urlopen(url).read().decode("utf-8")
    data = json.loads(response)['query']['pages']
    for key, value in data.items():
        text = value['extract']
        return text.split("\n")[0]
    
response = respond(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])
if response:
	print(response)
