#!/bin/env sh
docker stop `cat lastest.id`
docker rm  `cat lastest.id`
