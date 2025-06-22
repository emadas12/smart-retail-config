FROM jenkins/jenkins:lts

USER root

# התקנת Docker, Node.js, Python, kubectl, curl ועוד
RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    python3 \
    python3-pip \
    python3-venv \
    nodejs \
    npm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# התקנת kubectl
ENV KUBECTL_VERSION=v1.30.1

RUN curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# התקנת linters עם הרשאה לעקוף PEP 668
RUN pip3 install --break-system-packages flake8 && npm install -g eslint

# הרשאה עבור jenkins להשתמש בכלים
RUN chown -R jenkins:jenkins /usr/local/bin /usr/local/lib /usr/lib

USER jenkins
