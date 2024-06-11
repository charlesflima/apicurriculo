# Usa a imagem base do OpenJDK para Java 22
FROM bardiir/jdk22-ant AS build

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia todos os arquivos do projeto para o contêiner
COPY . .

# Dá permissão de execução ao Maven Wrapper
RUN chmod +x ./mvnw

# Usa o Maven Wrapper para compilar o projeto e gerar o JAR, ignorando os testes
RUN ./mvnw package -DskipTests

# Usa uma imagem base mais leve para a execução
FROM bardiir/jdk22-ant

# Define o diretório de trabalho dentro do contêiner de execução
WORKDIR /app

# Copia o JAR gerado na etapa de construção para o contêiner de execução
COPY --from=build /app/target/curriculo-api-0.0.1-SNAPSHOT.jar /app/app.jar

# Expõe a porta 8080
EXPOSE 8080

# Comando a ser executado quando o contêiner for iniciado
CMD ["java", "-jar", "app.jar"]
