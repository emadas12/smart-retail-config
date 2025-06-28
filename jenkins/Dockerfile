FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    lsb-release \
    gnupg \
    apt-transport-https \
    ca-certificates \
    unzip \
    python3-pip && \
    pip3 install --no-cache-dir flake8 --break-system-packages && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ✅ התקנת kubectl (גרסה יציבה)
RUN curl -LO "https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# ✅ התקנת ArgoCD CLI
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 && \
    chmod +x /usr/local/bin/argocd

ENV PATH="/usr/local/bin:${PATH}"

USER jenkins
