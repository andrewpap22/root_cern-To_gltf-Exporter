#!/bin/bash
python -m SimpleHTTPServer &
echo "Started SimpleHTTPServer, running: firefox http://localhost:8000/export.html"
firefox http://localhost:8000/export.html




