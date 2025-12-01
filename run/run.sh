#!/bin/bash
docker run -ti --rm \
-v $(pwd)/src:/src \
-v $(pwd)/data:/data \
--net=host \
--env-file $(pwd)/config/config.env \
"$1" &> "$1".log
