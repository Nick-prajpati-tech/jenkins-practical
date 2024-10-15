# Base image
FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy the jar file generated by Maven to the Docker container
COPY target/myapp.jar /app/myapp.jar

# Command to run the application
CMD ["java", "-jar", "/app/myapp.jar"]
