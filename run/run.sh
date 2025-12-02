#!/bin/bash
docker run -ti --rm \
--name "$2" \
-v $(pwd)/src:/src \
-v $(pwd)/data:/data \
--net=host \
--env-file $(pwd)/config/config.env \
--entrypoint $(pwd)/src/entrypoint.sh \
"$1" &> "$2".log
