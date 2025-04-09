#!/bin/bash

# Gerekli klasörleri oluştur
echo "📁 Klasörler oluşturuluyor..."
mkdir -p model
mkdir -p logs

# Model dosyalarını Google Drive'dan indir
echo "📥 Model dosyaları Google Drive'dan indiriliyor..."

# Google Drive klasör ID'si
FOLDER_ID="1PHig41O8g3ocLlgrPCno8-65P4-vbbKM"

# Her bir dosyayı ayrı ayrı indir
gdown --folder $FOLDER_ID -O model/

# Model dosyalarının varlığını kontrol et
echo "✅ Model dosyaları kontrol ediliyor..."
ls -la model/

# API'yi başlat
echo "🚀 API başlatılıyor..."
PORT=10000 python app/app.py 
