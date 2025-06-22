FROM jenkins/jenkins:lts

USER root

# התקנת כלים בסיסיים
RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    docker.io \
    python3 \
    python3-pip \
    nodejs \
    npm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# התקנת kubectl (גרסה יציבה)
ENV KUBECTL_VERSION=v1.30.1
RUN curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# ✅ התקנת linters עם תמיכה בדביאן החדש
RUN pip3 install --break-system-packages flake8 && \
    npm install -g eslint

USER jenkins
