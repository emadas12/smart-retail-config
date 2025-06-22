FROM jenkins/jenkins:lts

USER root

# התקנת כלים
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

# ניצור סביבה לכלים עבור Jenkins וניתן גישה
RUN mkdir -p /tools && \
    pip3 install --break-system-packages --target=/tools flake8 && \
    npm install -g eslint && \
    ln -s /tools/flake8 /usr/local/bin/flake8

ENV PATH="/tools:$PATH"

USER jenkins
