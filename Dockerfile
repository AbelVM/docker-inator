FROM ubuntu:jammy
ENV TZ=Europe/Madrid \
    DEBIAN_FRONTEND=noninteractive
COPY src/ /src/
RUN find ./src -name "*.sh" -exec chmod +x {} +
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
RUN mkdir ./src/data
WORKDIR /src
ENTRYPOINT ["/src/entrypoint.sh"]
