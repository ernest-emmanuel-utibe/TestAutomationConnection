# Stage 1: Build the application
FROM maven:3.8.7 AS build
WORKDIR /app
COPY . .
RUN mvn -B clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar deploymentApp.jar
ENTRYPOINT ["java", "-jar", "-Dserver.port=8080", "deploymentApp.jar"]
