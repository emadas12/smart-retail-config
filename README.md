
# Smart Retail – Infrastructure & CI/CD Configuration

This repository contains the infrastructure, deployment, monitoring, and CI/CD configurations for the [Smart Retail Inventory System](https://github.com/RaniSaed/smart-retail-dev).  
It follows GitOps and DevOps best practices using ArgoCD, Jenkins, Kubernetes, Prometheus, and Terraform.

---

## Repository Structure

```bash
tree -L 2
.
├── ArgoCD/                  # ArgoCD application definitions
│   ├── backend-app.yaml
│   ├── frontend-app.yaml
│   ├── monitoring-app.yaml
│   ├── pgadmin-app.yaml
│   ├── postgres-app.yaml
│   ├── dr-backend-app.yaml
│   └── dr-frontend-app.yaml
├── Jenkins_Backend/         # Jenkinsfile for backend pipeline
│   └── Jenkinsfile
├── Jenkins_Frontend/        # Jenkinsfile for frontend pipeline
│   └── Jenkinsfile
├── jenkins/                 # Jenkins setup inside Docker
│   ├── Dockerfile
│   ├── docker-compose.yml
│   ├── jenkins_data/
│   ├── jenkins_data_backup_*/ 
│   └── kubeconfig           # kubeconfig for kubectl from Jenkins
├── k8s/                     # Kubernetes manifests
│   ├── backend/             # Backend Deployment + Service
│   ├── frontend/            # Frontend Deployment + Service
│   ├── dr-region/           # DR region manifests
│   ├── monitoring/          # Prometheus + Grafana + Alertmanager
│   ├── pgadmin/             # pgAdmin Deployment
│   ├── postgres/            # PostgreSQL Deployment
│   ├── configmap.yaml
│   ├── ingress.yaml
│   ├── pgadmin-secret.yaml
│   └── secret.yaml
├── terraform/               # Terraform IaC to provision infrastructure
│   ├── providers.tf         # AWS provider configuration
│   ├── ec2.tf               # EC2 instance provisioning
│   ├── vpc.tf               # VPC and subnets
│   ├── security_groups.tf   # Firewall rules
│   ├── variables.tf         # Terraform variables
│   ├── outputs.tf           # Exported values
│   ├── data.tf              # Data sources
│   └── terraform.tfstate*   # Terraform state files
└── README.md                # This file
```

---

## ⚙️ Tools & Technologies

| Category        | Tools / Platforms                            |
|----------------|-----------------------------------------------|
| GitOps          | ArgoCD                                        |
| CI/CD           | Jenkins (Dockerized)                          |
| Orchestration   | Kubernetes (Minikube / EC2 / EKS-ready)       |
| Monitoring      | Prometheus · Grafana · Alertmanager           |
| IaC             | Terraform (VPC, EC2, Security Groups)         |
| Secrets         | Kubernetes Secrets + ConfigMaps               |

---

## 🚀 ArgoCD Applications

| App Name           | Path                       | Purpose                       |
|--------------------|----------------------------|-------------------------------|
| backend-app        | `k8s/backend/`             | Backend Flask service         |
| frontend-app       | `k8s/frontend/`            | Frontend React UI             |
| monitoring-app     | `k8s/monitoring/`          | Prometheus, Grafana, Alerts   |
| postgres-app       | `k8s/postgres/`            | PostgreSQL DB                 |
| pgadmin-app        | `k8s/pgadmin/`             | DB management tool            |
| dr-backend-app     | `k8s/dr-region/`           | DR Region - Backend           |
| dr-frontend-app    | `k8s/dr-region/`           | DR Region - Frontend          |

---

## 🧪 CI/CD Pipelines

Both backend and frontend have Jenkins pipelines stored in:

- `Jenkins_Backend/Jenkinsfile`
- `Jenkins_Frontend/Jenkinsfile`

### Pipeline Stages

1. Clone Dev + Config repos  
2. Detect code changes  
3. Docker build & push to Docker Hub  
4. Update deployment.yaml (image tag)  
5. Git commit & push to config repo  
6. ArgoCD auto-syncs the changes  
7. Post-deploy health checks  
8. DR deployment & failover checks (optional)

---

## ☸️ Kubernetes Deployment

```bash
# Deploy core services manually
kubectl apply -f k8s/postgres/
kubectl apply -f k8s/backend/
kubectl apply -f k8s/frontend/
kubectl apply -f k8s/monitoring/
kubectl apply -f k8s/ingress.yaml

# Or use ArgoCD to sync everything from Git
```

---

## 📦 Jenkins in Docker

```bash
cd jenkins/
docker-compose up -d
# Access Jenkins at: http://localhost:8081
```

Make sure to mount Docker and kubeconfig inside the container for full pipeline access.

---

## 🌐 Infrastructure with Terraform (AWS)

Provision EC2 + VPC + security groups:

```bash
cd terraform/
terraform init
terraform apply
```

> 🔐 Remember to update your AWS credentials before applying.

---

## 📊 Monitoring Stack

- **Prometheus**: collects metrics (from Flask, Node Exporter)  
- **Grafana**: visualizes trends and performance  
- **Alertmanager**: sends alerts (email/Slack)  
- **Failover script**: `scripts/failover-check.sh`

---

## 📸 Diagrams & Visuals

> You can insert diagrams under `assets/` here in the future (architecture.png, monitoring-flow.png, etc.)

---

## ✅ Best Practices Followed

- GitOps with ArgoCD auto-sync
- Separate Dev and Config repos
- DR region with automatic failover
- Clean Jenkins pipeline with versioning
- Terraform-managed cloud resources
- Real-time monitoring and alerting

---

## License

MIT © Rani Saed
