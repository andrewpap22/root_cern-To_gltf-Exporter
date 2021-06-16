#!/bin/bash
python -m SimpleHTTPServer &
echo "Started SimpleHTTPServer, running: brave http://localhost:8000/export.html"

# replace brave with your own browser
brave http://localhost:8000/export.html
