#!/bin/bash

CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'

echo -e "${CYAN}${BOLD}*     Rivalz One Click Setup With Docker by       *${NC}"
echo -e "${CYAN}${BOLD}*                   Fadhil Ahmad                  *${NC}"
echo -e "${CYAN}${BOLD}        for Google Cloud (vm) Ubuntu:22.04        *${NC}"
echo ""
echo -e "${YELLOW}${BOLD}Please wait...${NC}"

# Step 1: Run the Ubuntu container and leave it in interactive mode
sudo docker run -itd --name ubuntu-1 ubuntu:22.04 /bin/bash

# Step 2: Start the container
sudo docker container start ubuntu-1

# Step 3: Execute commands inside the container to update, upgrade, and install necessary tools (including nvm)
sudo docker container exec -it ubuntu-1 /bin/bash -c "
    apt update && apt upgrade -y && apt install curl -y && apt install tmux -y && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
"

# Step 4: Restart the container to refresh the environment
sudo docker container restart ubuntu-1

# Step 5: Install Node.js and rivalz-node-cli using nvm after loading the nvm environment
sudo docker container exec -it ubuntu-1  /bin/bash -c "
    export NVM_DIR=\"\$HOME/.nvm\" && \
    [ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\" && \
    [ -s \"\$NVM_DIR/bash_completion\" ] && . \"\$NVM_DIR/bash_completion\" && \
    nvm install node && \
    npm i -g rivalz-node-cli@2.6.2
"