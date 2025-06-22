FROM jenkins/jenkins:lts

USER root

# התקנת docker
RUN apt-get update && \
    apt-get install -y docker.io curl

# התקנת kubectl
RUN curl -LO "https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# הוספת המשתמש jenkins לקבוצת docker
RUN usermod -aG docker jenkins

# יצירת תיקיית .kube שתכיל את קובץ הקונפיג של מיניקיוב
RUN mkdir -p /var/jenkins_home/.kube
