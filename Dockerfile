FROM python:slim

# Avoid Python writing .pyc files and ensure stdout/stderr are unbuffered
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy code to container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -e .

# Run training pipeline (optional — remove if you don’t want it during image build)
RUN python pipeline/training_pipeline.py

EXPOSE 5000

# Start the app
CMD ["python", "app.py"]
