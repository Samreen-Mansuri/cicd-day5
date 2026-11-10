FROM python:3.13-slim

# Fix 1: patch the OS packages (clears the zlib CVEs)
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

# Fix 2: upgrade the flagged Python packages, then install app deps
RUN pip install --no-cache-dir --upgrade pip setuptools urllib3 msgpack && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "app.py"]
