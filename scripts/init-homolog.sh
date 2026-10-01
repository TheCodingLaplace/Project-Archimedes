#!/bin/bash
echo "Initing homolog eviroment..."

set -euo pipefail

echo "Critical warning: for this to work U need to clone the original repo in your home directory without U rename it!"
echo "Before continue, anwser: Are U the dev of this project or not [y/n]?" && read -r anwser

if [ "$anwser" = "n" ]; then
    WORK_DIRECTORY="$HOME/Project-Archimedes/"
elif [ "$anwser" = "y" ]; then
    WORK_DIRECTORY="$HOME/projects/infra/"
elif [ "$anwser" != "n" ] && [ "$anwser" != "y" ]; then
    echo "Warning: Unexpected confirmation at the begining, U must anwser propely, quiting scritp!"
    exit 1
fi

echo "Thanks for clarify, now to the process itself..."

mkdir -p "$WORK_DIRECTORY/logs/current"
mkdir -p "$WORK_DIRECTORY/logs/old"

echo "Building the logs placement"
logs_origin="$WORK_DIRECTORY/logs/current/"
logs_destination="$WORK_DIRECTORY/logs/old/"
log_files=("flask" "mkdocs" "cloudflared")
path_way=""

echo "Checking the existence of log directories"
if [ -d "$logs_origin" ] && [ -d "$logs_destination" ]; then
    path_way="true"
else
    path_way="false"
fi

echo "Moving stoped logs to the old-logs directory"

if [ "$path_way" = "true" ]; then
    for log in "${log_files[@]}"; do

        if [ -f "${logs_origin}${log}.log" ]; then
            mv "${logs_origin}${log}.log" "${logs_destination}${log}_$(date +%Y-%m-%d-%H-%M-%S).log"
            echo "The ${log}.log was sucessfuly moved to the old logs directory!"
        else
            echo "Warning! : The ${log}.log wasn't found on the directory"
        fi

    done
elif [ "$path_way" = "false" ]; then
    echo "Critical warning! : The origin or destination of log are broken!"
    exit 1
fi

echo "Cleaning the current log aplication enviroment"
rm -f "$WORK_DIRECTORY/logs/current/mkdocs.log"
rm -f "$WORK_DIRECTORY/logs/current/flask.log"
rm -f "$WORK_DIRECTORY/logs/current/cloudflared.log"
echo "Done!"

echo "Observing HTTP tunnel enviroment"

if pgrep -x cloudflared > /dev/null; then
    echo "..."
else
    echo "HTTP tunnel is not runing, starting again..."
    nohup cloudflared tunnel run flask-homolog \
        > "$WORK_DIRECTORY/logs/current/cloudflared.log" 2>&1 &
    echo "..."
fi
TUNNEL_PID=$(pgrep -x cloudflared)
echo "Tunnel exists, and the process id is ""$TUNNEL_PID"" "

echo "Looking at the python virtual enviroment"

if [ -d "$WORK_DIRECTORY/venv" ]; then
    echo "Activating..."
    source "$WORK_DIRECTORY/venv/bin/activate"
else
    echo "Python virtual enviroment does not exist, creating one..."
    python3 -m venv "$WORK_DIRECTORY/venv"
    echo "Activating..."
    source "$WORK_DIRECTORY/venv/bin/activate"
fi

echo "working on python eviroment and dependencies..."
if [ -r "$WORK_DIRECTORY/requirements.txt" ] && [ -r "$WORK_DIRECTORY/mkdocs.yml" ]; then 
    
    echo "Attempting to install dependencies"
    pip install -q -r "$WORK_DIRECTORY/requirements.txt"
    echo "Done!"
    
    echo "Iniciating API"
    nohup python3 "$WORK_DIRECTORY/API/main.py" \
        > "$WORK_DIRECTORY/logs/current/flask.log" 2>&1 &
    echo "..."
    API_PID=$(pgrep -f "${WORK_DIRECTORY}API/main.py")
    echo "Done!"

    echo "Building the documentation website"
    mkdocs build -f "$WORK_DIRECTORY/mkdocs.yml"
    echo "..."
    CURRENT_DIRECTORY=$(pwd) 
    cd "$WORK_DIRECTORY"
    nohup mkdocs serve -f mkdocs.yml -a 0.0.0.0:8000 \
        > "$WORK_DIRECTORY/logs/current/mkdocs.log" 2>&1 &
    echo "..."
    cd "$CURRENT_DIRECTORY"
    echo "Done!"

    echo "Homologation script has been sucessfuly executed!"
else
    echo "Dependencies not found, try fetch/pull the repo."
    exit 1
fi

echo "Now checking the eviroment:..."

DOMAIN_STATUS=$(curl -sS -o /dev/null -w "%{http_code}" thecodinglaplace.com.br )
DOC_STATUS=$(curl -sS -o /dev/null -w "%{http_code}" thecodinglaplace.com.br/docs )

if nc -zv thecodinglaplace.com.br 8080; then
    DOMAIN_PORT="reacheble"
else
    DOMAIN_PORT="unreacheble"
fi

echo "While attempting to reach the domain, anwser was: ..."
echo " $DOMAIN_PORT "

echo "The domain http status is ""$DOMAIN_STATUS"" "
echo "And the documentation http status is ""$DOC_STATUS"" "

if pgrep -x cloudflared > /dev/null && pgrep -f "${WORK_DIRECTORY}mkdocs" > /dev/null && pgrep -f "${WORK_DIRECTORY}API/main.py" > /dev/null; then
    echo "Seems like every attempted service is now running"
else
    echo "Seems like not every service is corectly running, u'd might want to check it out..."
    exit 1
fi