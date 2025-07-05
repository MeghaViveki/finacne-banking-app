# Use an official OpenJDK 11 runtime as the base image
FROM openjdk:11
# This ensures your application runs on a stable, well-supported Java version.

# Define a build-time variable for the path to the JAR file
ARG JAR_FILE=target/*.jar
# This allows flexibility in specifying the JAR during the build, useful when filename includes version/build number.

# Copy the JAR file from the host build context to the image and rename it as app.jar
COPY ${JAR_FILE} app.jar
# Copies the compiled JAR into the container’s working directory.
# Suggestion: You could add `COPY --chown=appuser:appuser` if running with a non-root user.

# Define the command to run the application when the container starts
ENTRYPOINT ["java", "-jar", "/app.jar"]
# Starts the Java application using the copied JAR.
# Suggestion: You could add JVM options here if needed for tuning (e.g., memory limits).
