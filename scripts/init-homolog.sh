#!/bin/bash
echo "Initing homolog eviroment"

mkdir -p ../logs/current

rm -f ../logs/current/mkdocs.log
rm -f ../logs/current/flask.log
rm -f ../logs/current/cloudflared.log
nohup cloudflared tunnel run flask-homolog > ../logs/current/cloudflared.log 2>&1 & 
# Think I dont need to say, but that is the name of the tunnel

if [ -d ../venv ]; then
    source ../venv/bin/activate
else
    python3 -m venv ../venv
    source ../venv/bin/activate
fi

if [ -r ../requiriments.txt ]; then 
    pip install -q -r ../requiriments.txt
else 
    echo "Dependencies not found, fetch/pull the repo"
    exit 1
fi

nohup python3 ../API/main.py &>../logs/current/flask.log &

if [ -r ../mkdocs.yml ]; then
    mkdocs build -f ../mkdocs.yml
    nohup mkdocs serve -f ../mkdocs.yml -a 0.0.0.0:8000 > ../logs/current/mkdocs.log 2>&1 &
else
    echo "Dependencies not found, fetch/pull the repo"
fi

