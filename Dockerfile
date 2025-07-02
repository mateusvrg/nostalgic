# Use uma imagem oficial do Python como imagem base.
# python:3.10-slim é uma boa escolha por ser leve.
FROM python:3.10-slim

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, esta camada não será reconstruída.
COPY requirements.txt .

# Instala as dependências do projeto.
# A flag --no-cache-dir reduz o tamanho final da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner.
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar.
# Usamos 0.0.0.0 para que o servidor seja acessível externamente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]