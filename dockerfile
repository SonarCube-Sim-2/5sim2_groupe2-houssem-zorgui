# Étape 1: Utilisation de l'image Maven officielle avec Java 17
FROM maven:3.8.6-openjdk-17-slim AS builder

# Étape 2: Définir le répertoire de travail
WORKDIR /app

# Étape 3: Copier le fichier pom.xml et le dossier src dans le conteneur
COPY pom.xml .
COPY src ./src

# Étape 4: Construire l'application avec Maven
RUN mvn clean install -DskipTests

# Étape 5: Créer l'image finale en utilisant OpenJDK 17
FROM openjdk:17-jre-slim

# Étape 6: Définir le répertoire de travail
WORKDIR /app

# Étape 7: Copier l'artefact généré par Maven depuis l'étape précédente
COPY --from=builder /app/target/*.jar app.jar

# Étape 8: Exposer le port de l'application
EXPOSE 8080

# Étape 9: Lancer l'application Java
ENTRYPOINT ["java", "-jar", "app.jar"]
