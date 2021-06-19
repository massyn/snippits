import json
import urllib.request
import urllib.parse

def slackMe(webHook,message):
    req = urllib.request.Request(
        webHook,
        json.dumps({'text': message}).encode('utf-8'),
        {'Content-Type': 'application/json'}
    )
    resp = urllib.request.urlopen(req)
    response = resp.read()
    
    print(response)
