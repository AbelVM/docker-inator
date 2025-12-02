FROM ubuntu:noble
ENV TZ=Europe/Madrid \
    DEBIAN_FRONTEND=noninteractive
COPY config/requirements.txt .
COPY config/packages.txt .
COPY config/package.json .
RUN apt update
RUN xargs -r -a packages.txt apt install -y --no-install-recommends
RUN apt install python3-pip python-is-python3 -y --no-install-recommends \
    && pip install --no-cache-dir -r requirements.txt
RUN apt install nodejs -y --no-install-recommends \
    && npm install -g
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*