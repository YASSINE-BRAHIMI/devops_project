FROM python:3.9-slim

WORKDIR /app

# Copie des fichiers de dépendances
COPY requirements.txt .

# Installation des dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Copie du reste du code
COPY . .

# Port sur lequel l'application Flask tourne (défini dans app.py)
EXPOSE 8000

# Commande de démarrage
CMD ["python", "app.py"]
