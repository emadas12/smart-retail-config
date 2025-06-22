FROM jenkins/jenkins:lts

ENV KUBECTL_VERSION=v1.29.0

USER root

# התקנת kubectl
RUN curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

# התקנת docker ו-pip
RUN apt-get update && \
    apt-get install -y docker.io python3-pip && \
    usermod -aG docker jenkins

# עדכון pip
RUN pip3 install --upgrade pip --break-system-packages

USER jenkins