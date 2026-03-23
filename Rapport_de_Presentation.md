# Rapport de Présentation et Guide de Préparation : Projet DevOps

*Ce document contient toutes les informations nécessaires à inclure dans votre présentation (slides/rapport) ainsi que la liste exacte des éléments à préparer avant de passer devant le jury.*

---

## PARTIE 1 : Contenu du Rapport de Présentation

### 1. Introduction et Objectifs (Slide 1-2)
- **Contexte** : Dans un monde où la vitesse de développement est cruciale, la livraison de code (Delivery) doit être fiabilisée et accélérée. 
- **Objectif** : Mettre en place une chaîne d'intégration et de livraison continues (CI/CD) vers une infrastructure Cloud (AWS) 100% automatisée (Infrastructure as Code) hébergeant un cluster Kubernetes (K3s).
- **Application cible** : Une application de gestion de bibliothèque basée sur Flask (Python).

### 2. Architecture et Choix Technologiques (Slide 3)
*Rappel : Présentez le schéma Draw.io expliquant les interactions.*
- **Cloud Provider (AWS)** : Choisi pour sa flexibilité et son modèle "Pay as you go" (Free Tier). L'infrastructure contient 1 Master Node et 1 Worker Node dans un sous-réseau public du VPC.
- **Terraform (IaC)** : Utilisé pour ne plus créer d'instances à la main. Il garantit la répétabilité parfaite (idempotence) de l'infrastructure réseau et sécurité (Security Group avec les ports 22, 80, 6443, 30001 ouverts).
- **Ansible** : Le gestionnaire de configuration. Utilisé pour transformer des machines Ubuntu vierges en nœuds Kubernetes (Installation de Docker et distribution K3s) automatiquement par SSH.
- **K3s (Kubernetes allégé)** : L'orchestrateur de conteneurs idéal pour les environnements Cloud avec peu de ressources. Assure la haute disponibilité (2 réplicas) et gère la tolérance aux pannes.

### 3. Pipeline CI/CD (Slide 4)
*Explication du fichier `devops-pipeline.yml` et de la philosophie DevOps.*
1. **Intégration Continue (CI)** : À chaque `push` sur la branche `main` de GitHub, le code est récupéré. Docker build l'image de l'application Flask et s'authentifie sur Docker Hub pour la publier (`build-and-push`).
2. **Livraison Continue (CD)** : GitHub Actions utilise le fichier `KUBECONFIG` stocké en secret pour s'authentifier à distance sur l'API Server du Master AWS (port 6443).
3. **Déploiement Kubernetes** : Le runner applique les manifests (`deployment.yml`, `service.yml`) et force le redémarrage (Rollout) des conteneurs avec la nouvelle version de l'image Docker Hub reçue.

### 4. Monitoring et Résolution de Problèmes (Slide 5)
- **Monitoring (Prometheus/Grafana)** : La supervision de la santé du cluster.
- **Troubleshooting (Problème rencontré)** : "Lors du projet, nous avons été confrontés à un timeout persistant (`dial tcp: i/o timeout`) lors de l'exécution du Github Actions. La raison : avec un compte AWS basique, éteindre/allumer les machines change leurs adresses IP publiques. Il a fallu reconstruire le cluster avec Ansible et mettre à jour le `KUBECONFIG` distant avec la nouvelle IP pour rétablir la CI/CD." Cela prouve votre compréhension du réseau Cloud et de la sécurité des certificats TLS.

### 5. Conclusion (Slide 6)
- Bilan positif : Le code en local arrive en production de façon modulaire et automatisée.
- Améliorations futures (Perspectives) : Ajouter un nom de domaine via route53, utiliser des IP fixes (Elastic IPs), ajouter de l'auto-scaling matériel (ASG).

---

## PARTIE 2 : Checklist Avant de Présenter (Ce que vous devez préparer)

**(Attention : Lisez ceci le jour même de la soutenance avant de passer !)**

- [ ] **Démarrez vos instances EC2 sur AWS** (Allez sur AWS Console -> EC2 -> Start). Laissez-les s'allumer pendant 2 minutes.
- [ ] **Mettez à jour les IPs** : Puisque les IPs ont changé, vous devez récupérer la nouvelle IP de votre Master. 
- [ ] **Mettez à jour le fichier Kubeconfig (Secret GitHub)** : Récupérez le nouveau `#Kubeconfig` avec la nouvelle IP générée par Ansible, puis allez dans **GitHub -> Settings -> Secrets and variables -> Actions** et mettez à jour la valeur de `KUBECONFIG`.
- [ ] **Exécutez un test** : Poussez un petit changement ("Test") dans `README.md` et vérifiez que le pipeline GitHub Actions aboutit à un succès vert (sans le Timeout).
- [ ] **Vérifiez l'application** : Ouvrez un navigateur web à l'adresse de votre Node Worker sur le port exposé par Kube (ex: `http://<IP_WORKER>:30001`). Le site Flask doit s'afficher.
- [ ] **Préparez vos outils visuels** :
  - Gardez l'onglet AWS EC2 ouvert pour montrer vos instances.
  - Gardez l'onglet GitHub Actions ouvert pour prouver que le pipeline a tourné avec succès de manière automatisée.
  - Gardez votre Schéma d'architecture (Draw.io) en grand écran ou imprimé, c'est ce qui explique le mieux la logique.

---
*Astuce PDF : Si vous utilisez VS Code, installez l'extension "Markdown PDF" puis faites un clic droit sur ce fichier -> "Export to PDF", ou copiez ce texte dans un document Word -> "Sauvegarder en PDF".*
