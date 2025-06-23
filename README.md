# 🛠️ Smart Retail Config
Rani Saed
Emad Asad
This repository contains the infrastructure and DevOps configuration for the **Smart Retail Inventory System** project.

It works alongside the app code in [`smart-retail-dev`](https://github.com/emadas12/smart-retail-dev), and is responsible for deploying and managing the application in Kubernetes.

---

## 📦 Folder Structure

```bash
smart-retail-config/
├── k8s/                # Kubernetes manifests
│   ├── backend/        # Flask API deployment, service, ingress
│   ├── frontend/       # React frontend deployment, service, ingress
│   ├── postgres/       # PostgreSQL + pgAdmin configs
│   └── monitoring/     # Prometheus + Grafana setup
├── jenkins/            # Jenkinsfile and pipeline configs
├── start-dev.sh        # Script to port-forward services locally
└── README.md
