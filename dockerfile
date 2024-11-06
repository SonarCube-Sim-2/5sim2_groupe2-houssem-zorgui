# Utilisation de l'image officielle Maven comme image de base
FROM maven:3.8.6-openjdk-11 AS build

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Cloner le dépôt Git (tu peux aussi ajouter des clés SSH ou un token si nécessaire)
RUN git clone https://github.com/SonarCube-Sim-2/5sim2_groupe2-houssem-zorgui.git

# Se déplacer dans le répertoire du projet
WORKDIR /app/5sim2_groupe2-houssem_zorgui

# Installer les dépendances Maven
RUN mvn clean install

# Utilisation de l'image OpenJDK pour l'exécution
FROM openjdk:11-jre-slim

# Définir le répertoire de travail pour l'exécution
WORKDIR /app

# Copier les fichiers construits depuis l'étape de build
COPY --from=build /app/5sim2_groupe2-houssem_zorgui/target/*.jar /app/app.jar

# Exposer le port sur lequel l'application écoute
EXPOSE 8080

# Commande pour démarrer l'application (si c'est un service Spring Boot par exemple)
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
