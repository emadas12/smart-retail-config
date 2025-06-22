FROM jenkins/jenkins:lts

USER root

# התקנת כלים בסיסיים: Docker, Python, Node.js, kubectl
RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    python3 \
    python3-pip \
    nodejs \
    npm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# התקנת kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# התקנת linters מראש
RUN pip3 install flake8 && \
    npm install -g eslint

USER jenkins
