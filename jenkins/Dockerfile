FROM jenkins/jenkins:lts

USER root

# התקנת Docker, curl, kubectl וכלים נוספים
RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    unzip \
    python3-pip && \
    pip3 install --no-cache-dir flake8 && \
    apt-get clean

# התקנת kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Jenkins plugin CLI קיים בגרסה החדשה
USER jenkins
