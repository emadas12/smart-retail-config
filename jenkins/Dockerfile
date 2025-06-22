FROM jenkins/jenkins:lts

USER root

# התקנת kubectl
RUN curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

# התקנת Docker, pip ו־Python כלים
RUN apt-get update && \
    apt-get install -y docker.io python3-pip && \
    usermod -aG docker jenkins

# שדרוג pip מראש
RUN pip3 install --break-system-packages --upgrade pip

USER jenkins