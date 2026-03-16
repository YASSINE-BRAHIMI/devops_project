# Présentation du Projet : 10 Minutes Chrono

Voici un guide pour structurer voter présentation orale de 10 minutes.

## 1. Introduction (1 min)
- Présentez-vous.
- Enjeu : Pourquoi le DevOps ? (Rapidité, automatisation, fiabilité).
- Objectif du projet : Prouver qu'on peut déployer sur le Cloud en un clic.

## 2. Architecture & Choix Technologiques (2 min)
- Montrez votre diagramme Draw.io.
- Expliquez pourquoi ces outils :
    - **Terraform** : Idempotence et rapidité de création d'infrastructure.
    - **Ansible** : Flexibilité pour configurer les serveurs sans intervention manuelle.
    - **K3s (Kubernetes)** : Orchestration moderne et légère pour le Cloud.

## 3. Démonstration du Pipeline (3 min)
- Montrez votre fichier `.github/workflows/devops-pipeline.yml`.
- Expliquez le cycle : **Code -> GitHub -> Docker Hub -> Cluster AWS**.
- (Optionnel) Montrez un succès sur l'onglet "Actions" de GitHub.

## 4. Orchestration & Monitoring (2 min)
- Montrez vos manifests Kubernetes.
- Parlez de la haute disponibilité (2 réplicas).
- Mentionnez Prometheus/Grafana pour surveiller la santé du cluster.

## 5. Conclusion & Questions (2 min)
- Récapitulez les bénéfices de votre solution.
- Ouvrez sur les perspectives (Auto-scaling, Sécurité renforcée).
- Préparez-vous aux questions sur les coûts AWS (Free Tier) et la gestion des secrets.

---

### Conseils pour réussir :
- Ne lisez pas vos slides.
- Focalisez sur la **valeur ajoutée** de chaque outil.
- Soyez prêt à montrer l'application qui tourne sur l'IP AWS.
