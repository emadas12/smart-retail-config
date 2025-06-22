pipeline {
  agent any

  environment {
    IMAGE_NAME = 'rani19/backend'
    TAG = "build-${env.BUILD_NUMBER}"
    DOCKER_CREDENTIALS_ID = 'docker-hub-creds'
    DEV_REPO_URL = 'https://github.com/RaniSaed/smart-retail-dev.git'
    CONFIG_REPO_URL = 'https://github.com/RaniSaed/smart-retail-config.git'
    PRIMARY_NS = 'default'
    KUBECONFIG = '/var/jenkins_home/kubeconfig-static/config'
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    skipDefaultCheckout()
    timeout(time: 30, unit: 'MINUTES')
  }

  stages {

    stage('👋 Start') {
      steps {
        echo "🚀 Pipeline started for Docker image: ${IMAGE_NAME}:${TAG}"
      }
    }

    stage('📥 Clone Dev Repo') {
      steps {
        dir('dev') {
          git url: "${DEV_REPO_URL}", branch: 'main'
        }
      }
    }

    stage('📥 Clone Config Repo') {
      steps {
        dir('config') {
          git url: "${CONFIG_REPO_URL}", branch: 'main'
        }
      }
    }

    stage('🐍 Lint Flask Backend') {
      steps {
        dir('dev/backend') {
          sh '''
            echo "🔍 Installing flake8 and linting code..."
            pip install --break-system-packages flake8 > /dev/null || true
            flake8 . || echo "⚠️ Lint warnings found, but continuing pipeline."
          '''
        }
      }
    }

    stage('🧪 Run Flask Tests') {
      steps {
        dir('dev/backend') {
          sh '''
            echo "🧪 Installing requirements and checking for tests..."
            pip install --break-system-packages -r requirements.txt > /dev/null || true
            if [ -d tests ]; then
              python3 -m unittest discover -s tests || true
            else
              echo "ℹ️ No tests directory found, skipping tests."
            fi
          '''
        }
      }
    }

    stage('🐳 Build & Push Docker Image') {
      steps {
        dir('dev/backend') {
          withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh '''
              echo "🐳 Logging in to Docker Hub..."
              echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

              echo "📦 Building Docker image..."
              docker build -t $IMAGE_NAME:$TAG .

              echo "🚀 Pushing Docker image..."
              docker push $IMAGE_NAME:$TAG
            '''
          }
        }
      }
    }

    stage('🚀 Deploy to Primary') {
      steps {
        dir('config') {
          script {
            echo "📦 Deploying backend with tag: $TAG to namespace: $PRIMARY_NS"

            sh """
              sed 's|rani19/backend:latest|rani19/backend:$TAG|' k8s/backend/deployment.yaml > k8s/backend/deployment-temp.yaml

              kubectl apply -n $PRIMARY_NS -f k8s/backend/deployment-temp.yaml
              kubectl apply -n $PRIMARY_NS -f k8s/backend/service.yaml
            """
          }
        }
      }
    }

  }

  post {
    success {
      echo '✅ Pipeline completed successfully!'
    }
    failure {
      echo '❌ Pipeline failed. Check logs for errors.'
    }
  }
}
