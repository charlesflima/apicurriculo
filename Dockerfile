# Usa a imagem base do OpenJDK para Java 11
FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y

COPY . .

RUN apt-get install  maven -y
RUN mvn clean install

FROM openjdk:17-jdk-slim

EXPOSE 8080



# Copia o arquivo JAR da sua aplicação para o contêiner
COPY --from=build /target/curriculo-api-0.0.1-SNAPSHOT.jar app.jar

# Comando a ser executado quando o contêiner for iniciado
ENTRYPOINT [ "java", "-jar", "app.jar"]
