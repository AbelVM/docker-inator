FROM ubuntu:noble
ENV TZ=Europe/Madrid \
    DEBIAN_FRONTEND=noninteractive
COPY config/requirements.txt .
COPY config/packages.txt .
COPY config/package.json .
RUN apt update \
    && xargs -r -a packages.txt apt install -y \
    && apt clean
RUN apt install python3-pip python-is-python3 -y \
    && pip install --no-cache-dir -r requirements.txt
RUN apt install nodejs -y \
    && npm install -g
ENTRYPOINT ["/src/entrypoint.sh"]
