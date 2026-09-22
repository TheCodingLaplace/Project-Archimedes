#!/bin/bash

# This is simply and example that u can easily exec to see the structure and logs for ur self in ur own machine
# I do recomend to execute it in the scripts/ directory, yet futher in time I'll make sure it works on anywere.

echo "Initing a homolog version of ambient
"
echo "Activating the virtual enviroment
"
source venv/bin/activate &&
pip install requiriments.txt &&
chmod +x ../API/main.py
echo "Initiating the redirect, you can acess it in browser at http://127.0.0.1/8080

"
python3 ../API/api.py
