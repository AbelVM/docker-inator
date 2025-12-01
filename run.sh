#!/bin/bash
docker run -ti --rm -v $(pwd)/data:/src/data --net=host --env-file $(pwd)/config/config.env "$1" &> "$1".log
