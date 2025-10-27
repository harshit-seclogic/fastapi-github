FROM python:3.11-slim

# Add metadata label
LABEL maintainer="seclogic-admin@bitbucket.org" \
      repository="https://bitbucket.org/seclogic1/fastapi-fullflow.git" \
      description="FastAPI application for GKE deployment"

WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app /app

EXPOSE 8080
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
