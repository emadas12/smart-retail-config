FROM jenkins/jenkins:lts

USER root

# התקנת kubectl
RUN curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl && \
    chmod +x kubectl && mv kubectl /usr/local/bin/kubectl

# התקנת Docker CLI, pip, flake8
RUN apt-get update && \
    apt-get install -y docker.io python3-pip && \
    usermod -aG docker jenkins && \
    pip3 install --break-system-packages flake8

USER jenkins