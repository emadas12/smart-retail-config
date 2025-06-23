#!/bin/bash

echo "🚀 Starting port-forwarding for all services..."

# App services
kubectl port-forward service/backend 5000:5000 &
kubectl port-forward service/frontend 3000:80 &
kubectl port-forward service/pgadmin 8080:80 &

# Monitoring tools (Prometheus & Grafana only)
kubectl port-forward -n prometheus service/prometheus 9090:9090 &
kubectl port-forward -n prometheus service/grafana 3001:3000 &

# Alertmanager is not deployed, so this is disabled
# kubectl port-forward -n prometheus service/alertmanager 9093:9093 &

echo "✅ All services are being forwarded!"
