FROM python:3.9-slim

WORKDIR /app

# Installation des dépendances système si nécessaire
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copie des fichiers de dépendances
COPY requirements.text .

# Installation des dépendances Python
RUN pip install --no-cache-dir -r requirements.text

# Copie du reste du code
COPY . .

# Création du dossier instance pour la base de données SQLite si nécessaire
RUN mkdir -p instance

# Port sur lequel l'application Flask tourne (défini dans app.py)
EXPOSE 8000

# Commande de démarrage
CMD ["python", "app.py"]
