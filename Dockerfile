# Etapa de construção
FROM ubuntu:latest AS build

# Atualiza a lista de pacotes e instala o OpenJDK 22
RUN apt-get update && apt-get install openjdk-22-jdk -y

# Instala Maven
RUN apt-get install maven -y

# Copia todos os arquivos do projeto para o contêiner
COPY . .

# Dá permissão de execução ao Maven Wrapper
RUN chmod +x ./mvnw

# Usa o Maven Wrapper para compilar o projeto e gerar o JAR, ignorando os testes
RUN ./mvnw package -DskipTests

# Etapa de execução
FROM openjdk:22-jdk-slim

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Expõe a porta 8080
EXPOSE 8080

# Copia o JAR gerado na etapa de construção para o contêiner de execução
COPY --from=build /target/curriculo-api-0.0.1-SNAPSHOT.jar /app/app.jar

# Comando a ser executado quando o contêiner for iniciado
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
