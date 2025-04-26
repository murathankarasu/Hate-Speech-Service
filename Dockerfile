FROM python:3.9-slim

WORKDIR /app/hate_speech_api

# Gerekli sistem paketlerini yükle
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    unzip \
    awscli \
    && rm -rf /var/lib/apt/lists/*

# Python bağımlılıklarını kopyala ve yükle
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Uygulama kodunu kopyala
COPY app/ ./app/

# Model ve log klasörlerini oluştur
RUN mkdir -p model app/logs && chmod -R 777 app/logs

# Port'u aç
ENV PORT=10000
EXPOSE 10000

# Railway için gerekli ortam değişkenlerini ayarla
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

# Model dosyalarını indir ve uygulamayı çalıştır
CMD ["sh", "-c", "aws s3 cp s3://lori-models/model/ ./model/ --recursive --no-progress && python app/app.py"] 
