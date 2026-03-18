# Project Architecture Description

This document describes the technical architecture of the DevOps project. You can use this information to create your diagram on [Draw.io](https://app.diagrams.net/).

## 1. Infrastructure Layer (managed by Terraform)
- **Cloud Provider**: AWS (Free Tier).
- **VPC**: 10.0.0.0/16.
- **Subnet**: Public Subnet (10.0.1.0/24).
- **Instances**:
    - **Master Node**: EC2 `t3.micro` (Ubuntu 22.04) - Runs the K3s Control Plane.
    - **Worker Node**: EC2 `t3.micro` (Ubuntu 22.04) - Runs the application workloads.
- **Security Group**: Allows SSH (22), HTTP (80), K3s API (6443), and NodePort (30001).

## 2. Configuration & Orchestration Layer (managed by Ansible & K3s)
- **Ansible**: Runs from your local machine to configure EC2 instances.
    - Installs Docker CE.
    - Installs K3s Master on the first node.
    - Connects K3s Worker to the Master.
- **K3s Cluster**: Lightweight Kubernetes managing the application lifecycle.

## 3. Application Layer
- **App**: Library Management System (Flask-based).
- **Container**: Docker image hosted on Docker Hub.
- **Deployment**:
    - **Pods**: 2 replicas of the Flask container.
    - **Service**: NodePort service exposing the app on port 30001.

## 4. CI/CD Pipeline (managed by GitHub Actions)
- **Trigger**: Push to `main` branch.
- **Steps**:
    1. **Checkout**: Get latest code.
    2. **Build**: Build Docker image.
    3. **Push**: Push image to Docker Hub.
    4. **Deploy**: Update the K3s cluster using `kubectl` (requires `KUBECONFIG` secret).

## 5. Monitoring Layer (Optional)
- **Prometheus**: Collects metrics from nodes and pods.
- **Grafana**: Visualizes metrics through dashboards.

---

### Suggested Diagram Elements:
- Boxes for: **Local PC**, **GitHub**, **Docker Hub**, **AWS Cloud**.
- Inside **AWS Cloud**: **VPC** boundary, inside it **Master VM** and **Worker VM**.
- Connectors: 
    - **Local PC** -> **GitHub** (Git Push)
    - **GitHub Actions** -> **Docker Hub** (Push Image)
    - **GitHub Actions** -> **Master VM** (Deploy Manifests)
    - **Local PC** -> **Master/Worker VM** (Ansible SSH)
    - **Internet User** -> **Worker VM:30001** (Access App)
