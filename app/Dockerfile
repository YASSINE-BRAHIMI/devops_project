# Utilisation d'une image de base Python légère
FROM python:3.9-slim

# Définition du répertoire de travail dans le conteneur
WORKDIR /app

# Copie des fichiers de dépendances
COPY requirements.txt .

# Installation des dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Copie du code source de l'application
COPY . .

# Exposition du port sur lequel l'application s'exécute
EXPOSE 5000

# Commande pour démarrer l'application
CMD ["python", "app.py"]
