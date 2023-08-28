# Use a base image with Java installed
FROM openjdk:11-jdk as builder

ARG APP_VERSION=0.0.1-SNAPSHOT
ARG APP_NAME=aws-flow

# Set the working directory inside the container
WORKDIR /opt/app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw versions:set -DnewVersion=$APP_VERSION
RUN ./mvnw dependency:go-offline
COPY ./src ./src
RUN ./mvnw clean install

FROM openjdk:11-jdk
ARG APP_VERSION=0.0.1-SNAPSHOT
ARG APP_NAME=aws-flow
WORKDIR /opt/app
EXPOSE 8080
COPY --from=builder /opt/app/target/$APP_NAME-$APP_VERSION.jar /opt/app/application.jar
ENTRYPOINT ["java", "-jar", "/opt/app/application.jar"]
