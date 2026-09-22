#!/usr/bin/env python3

from flask import Flask, redirect, url_for, render_template, request, Response, jsonify
import requests
import os

app = Flask(__name__)

@app.route("/comming-soon/")
def preview_page():
    return render_template("comming-soon.html")

@app.route("/")
def web_root():
    return redirect(url_for('preview_page'))

@app.route("/docs/", defaults={"path": ""})
@app.route("/docs/<path:path>")
def go_to_docs(path):
    
    running_container = (
            os.path.exists('/.dockerenv') or 
            os.path.exists('/run/.containerenv') or 
            os.getenv("RUNNING_IN_CONTAINER") == "true"
            )

    if not running_container:
        mkdocs_url = 'http://localhost:8000'
    else: 
        mkdocs_url = 'http://docs:8000'

    url = f"{mkdocs_url}/{path}"
    
    try:
        res = requests.get(url, params=request.args, stream=True)
        headers = [
            (name, value)
            for name, value in res.raw.headers.items()
            if name.lower() != "transfer-encoding"
        ]
        
        return Response(res.content, status=res.status_code, headers=headers)
    
    except requests.exceptions.ConnectionError:
        return Response(f"It wasn't possible to connect to MkDocs using: {url}", status=502)


# ------------------------- Read the comments to understand this section ---------------------- #

# While I look thru the log from flask I notice varsity of bot scrapers checking on my site, so I build this to learn
# from that and checkout if I can scrap the pattern and info from the bots and futher decide what I'll do
# about it.

# @app.route("/robots.txt")
# def bot_trap():
#     return jsonify(...)

# @app.route("/.env")
# def honey_pot():
#     # I'll start to put a honay pot to robots 'cause I've been analysing the acess logs of the preview page and notice
#     # that those routes have been requested a bunch of times, so I'll explore it and try to make a learn from that.
#     bots_trap = { 
#         ...
#     }
#     return ...
    

# @app.route("/bot-logs")
# def invasion_panel():
#     # To each of you guys who wanna see the logs and info from the robots that I manage to capture, U can check
#     # this panel in real time or see for ur self or, for a more detaled info, wait for me to prepare an 
#     # old-scraping-logs directory with proper documentation. 
#     bots_log = {
#         ...
#     }

# ------------------------------------------------------------------------------------------------------------------------- #

if __name__ == "__main__":
    app.run(host = "0.0.0.0", port = 8080)
