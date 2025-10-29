FROM python:3.11-slim

# Accept build arguments
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG REPO_URL
ARG REPO_NAME

# Add metadata labels
LABEL maintainer="seclogic-admin@bitbucket.org" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.url="${REPO_URL}" \
      org.opencontainers.image.source="${REPO_URL}.git" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.title="${REPO_NAME}" \
      org.opencontainers.image.description="FastAPI application for GKE deployment"

WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app /app

EXPOSE 8080
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]