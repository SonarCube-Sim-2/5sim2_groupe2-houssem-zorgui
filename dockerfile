# Étape 1: Utilisation de l'image OpenJDK 17 officielle
FROM openjdk:17-jdk-slim AS builder

# Étape 2: Installer Maven 3.6.3 dans le conteneur
RUN apt-get update && apt-get install -y maven=3.6.3-1

# Étape 3: Définir le répertoire de travail
WORKDIR /app

# Étape 4: Copier le fichier pom.xml et le dossier src dans le conteneur
COPY pom.xml .
COPY src ./src

# Étape 5: Construire l'application avec Maven
RUN mvn clean install -DskipTests

# Étape 6: Créer l'image finale en utilisant OpenJDK 17
FROM openjdk:17-jre-slim

# Étape 7: Définir le répertoire de travail
WORKDIR /app

# Étape 8: Copier l'artefact généré par Maven depuis l'étape précédente
COPY --from=builder /app/target/*.jar app.jar

# Étape 9: Exposer le port de l'application
EXPOSE 8080

# Étape 10: Lancer l'application Java
ENTRYPOINT ["java", "-jar", "app.jar"]
