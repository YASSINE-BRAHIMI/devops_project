# Rapport de Projet : Infrastructure DevOps Complète
**Master DSBD & IA - Cloud Computing & DevOps**

## 1. Introduction & Objectifs
Ce projet a pour but de mettre en place une infrastructure DevOps complète, automatisée de bout en bout, pour le déploiement d'une application Flask conteneurisée sur un cluster Kubernetes (K3s) hébergé sur AWS.

### Objectifs atteints :
- Automatisation de l'infrastructure avec **Terraform**.
- Gestion de la configuration avec **Ansible**.
- Orchestration avec **Kubernetes (K3s)**.
- Pipeline CI/CD avec **GitHub Actions**.
- Monitoring avec **Prometheus & Grafana**.

---

## 2. Architecture du Projet
L'architecture repose sur un environnement multi-tiers :
- **Infrastructure (AWS)**: VPC, Subnets publics, 2 instances EC2 (Master & Worker).
- **Automation**: Terraform pour le provisioning, Ansible pour l'installation logicielle.
- **Application**: Library Management System (Flask + SQLite).
- **Pipeline**: GitHub Actions déclenché par git push.

*(Note: Utilisez le fichier `architecture.md` pour générer votre diagramme Draw.io)*

---

## 3. Détails Techniques

### A. Infrastructure as Code (Terraform)
Localisation : `/terraform`
- `compute.tf` : Définit les instances Master et Worker.
- `network.tf` : Configuration du VPC et de la connectivité réseau.
- `security.tf` : Règles de pare-feu (SGs).

### B. Configuration Management (Ansible)
Localisation : `/ansible`
- `docker.yml` : Installation de Docker CE sur tous les nœuds.
- `k3s-master.yml` : Initialisation du cluster K3s Master.
- `k3s-worker.yml` : Jonction des workers au cluster.
- `monitoring-setup.yml` : Déploiement de Prometheus & Grafana.

### C. Orchestration Kubernetes (K3s)
Localisation : `/k8s`
- `deployment.yml` : Déploiement de l'app avec 2 réplicas.
- `service.yml` : Exposition via NodePort sur le port 30001.

### D. Pipeline CI/CD (GitHub Actions)
Localisation : `.github/workflows/devops-pipeline.yml`
- Étapes : Build Image -> Push to Docker Hub -> Deploy to K3s.

---

## 4. Documentation d'Installation (Guide de Reproduction)

### Prérequis :
1. Clés AWS configurées dans le fichier `cles`.
2. Terraform et Ansible installés localement.

### Étapes d'exécution :
1. **Provisioning** :
   ```bash
   cd terraform
   terraform init && terraform apply -auto-approve
   ```
2. **Configuration** :
   ```bash
   cd ../ansible
   ansible-playbook -i hosts.ini docker.yml
   ansible-playbook -i hosts.ini k3s-master.yml
   ansible-playbook -i hosts.ini k3s-worker.yml
   ansible-playbook -i hosts.ini monitoring-setup.yml
   ```
3. **Accès Application** : `http://<IP_WORKER>:30001`
4. **Accès Monitoring** : `http://<IP_MASTER>:30002` (Grafana)

---

## 5. Conclusion
Le projet démontre une intégration fluide des outils DevOps pour assurer la scalabilité, la répétabilité et la visibilité de l'application déployée.
