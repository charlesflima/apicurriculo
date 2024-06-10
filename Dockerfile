# Usa a imagem base do OpenJDK para Java 11
FROM openjdk:11-jre-slim

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo JAR da sua aplicação para o contêiner
COPY target/curriculo-api-0.0.1-SNAPSHOT.jar /app/app.jar

# Expõe a porta 8080 para o exterior do contêiner
EXPOSE 8080

# Comando a ser executado quando o contêiner for iniciado
CMD ["java", "-jar", "app.jar"]
