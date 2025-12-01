#!/bin/bash


# remote machine login credentials
set -a
. ./config/config_remote.env
. ./config/config.env
set +a

# Compile the needed files and folders
rm -rf dist
mkdir dist
cp -r config dist
cp -r src dist
cp -r data dist
cp -r ../build dist

# in case you need to remotely setup Docker runtimes
#      echo '#!/bin/bash
#      for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
#      sudo apt-get update
#      sudo apt-get install ca-certificates curl gnupg tmux -y
#      sudo install -m 0755 -d /etc/apt/keyrings
#      curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --batch --dearmor -o /etc/apt/keyrings/docker.gpg
#      sudo chmod a+rx /etc/apt/keyrings
#      sudo chmod a+r /etc/apt/keyrings/docker.gpg
#      echo \
#        "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
#        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#      sudo apt-get update
#      sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
#      sudo groupadd docker
#      sudo usermod -aG docker $USER
#      newgrp docker
#      sudo chmod 666 /var/run/docker.sock' > dist/install_docker.sh
#      chmod +x dist/install_docker.sh
# END docker install block

# Deploy
scp -r dist $USER@$HOST:
rm -rf dist

# in case you need to remotely setup Docker runtimes
#      ssh $USER@$HOST "echo $PASSWORD | sudo -S ~/dist/install_docker.sh"

# Build remote container
ssh $USER@$HOST "~/dist/build/build.sh $SERVICENAME"

# Run the container in a dettached session
ssh $USER@$HOST "tmux new-session -d -s '$SERVICENAME' ~/dist/run/run.sh $SERVICENAME"
# use 'tmux attach-session -t SeaSession' to connect later if needed
