FROM python:3.9-slim

WORKDIR /app

# Gerekli sistem paketlerini yükle
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Python bağımlılıklarını kopyala ve yükle
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gdown

# Uygulama kodunu kopyala
COPY src/ ./src/

# Model dosyalarını indirmek için script oluştur
COPY download_models.sh .
RUN chmod +x download_models.sh

# Port'u aç
EXPOSE 10001

# Model dosyalarını indir ve uygulamayı çalıştır
CMD ["./download_models.sh"] 
