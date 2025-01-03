# Use lscr.io/linuxserver/webtop:ubuntu-kde as the base image
FROM lscr.io/linuxserver/webtop:ubuntu-kde

# Install dependencies and tools
RUN apt-get update && apt-get install -y \
    software-properties-common \
    nano \
    curl \
    sudo \
    gnupg \
    unzip \
    wget \
    keepassxc \
    git \
    wget \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Homebrew
RUN apt-get update && apt-get install -y \
    build-essential \
    procps \
    file
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN sudo -u kasm-user /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
USER kasm-user
RUN echo >> /home/kasm-user/.bashrc \
    && echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/kasm-user/.bashrc \
    && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
USER root
RUN sudo -u kasm-user /home/linuxbrew/.linuxbrew/bin/brew install gcc

# Install Chromium ungoogled
RUN add-apt-repository ppa:xtradeb/apps \
    && apt-get update \
    && apt-get install -y ungoogled-chromium

# Install VS Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/ \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list \
    && apt-get update \
    && apt-get install -y code \
    && rm -f microsoft.gpg

# Install VS Code extensions
RUN sudo -u kasm-user /bin/bash -c "code --install-extension damms005.devdb \
    && code --install-extension eamodio.gitlens \
    && code --install-extension editorconfig.editorconfig \
    && code --install-extension esbenp.prettier-vscode \
    && code --install-extension l13rary.l13-diff \
    && code --install-extension mhutchie.git-graph \
    && code --install-extension redhat.vscode-yaml \
    && code --install-extension visualstudioexptteam.intellicode-api-usage-examples \
    && code --install-extension visualstudioexptteam.vscodeintellicode \
    && code --install-extension yzhang.markdown-all-in-one"

# Move VS Code extensions to /usr/share to make them available systemwide
RUN rm /home/kasm-user/.vscode/extensions/extensions.json
RUN mv /home/kasm-user/.vscode/extensions/* /usr/share/code/resources/app/extensions/

# Install Termius
RUN wget -q https://www.termius.com/download/linux/Termius.deb -O termius.deb \
    && apt-get install -y ./termius.deb \
    && rm termius.deb

# Uninstall Firefox
RUN apt purge firefox -y \
    && apt autoremove -y

# Install GitHub Desktop
RUN wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
RUN /bin/bash -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
RUN apt update && apt install github-desktop -y