#!/bin/env sh
docker build -t gp6-sae203 .
echo Running docker !!!!!!
docker run --name gp6 -t -d -p 2121:21 -p 1050-1055:1050-1055 gp6-sae203 > lastest.id
cat lastest.id
