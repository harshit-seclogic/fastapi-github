FROM python:3.11-slim

# Accept build arguments - OCI standard
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG REPO_URL
ARG REPO_NAME

# Accept Checkmarx scan metadata
ARG CX_SCAN_ID
ARG CX_PROJECT_ID
ARG CX_PROJECT_NAME
ARG CX_SCAN_STATUS
ARG CX_CREATED_AT
ARG CX_BRANCH
ARG CX_SCAN_TYPE
ARG CX_INITIATOR
ARG CX_ORIGIN
ARG CX_ENGINES

# Add metadata labels - OCI Standard
LABEL maintainer="seclogic-admin@bitbucket.org" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.url="${REPO_URL}" \
      org.opencontainers.image.source="${REPO_URL}.git" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.title="${REPO_NAME}" \
      org.opencontainers.image.description="FastAPI application for GKE deployment"

# Add Checkmarx security scan metadata labels
LABEL checkmarx.scan.id="${CX_SCAN_ID}" \
      checkmarx.project.id="${CX_PROJECT_ID}" \
      checkmarx.project.name="${CX_PROJECT_NAME}" \
      checkmarx.scan.status="${CX_SCAN_STATUS}" \
      checkmarx.scan.created="${CX_CREATED_AT}" \
      checkmarx.scan.branch="${CX_BRANCH}" \
      checkmarx.scan.type="${CX_SCAN_TYPE}" \
      checkmarx.scan.initiator="${CX_INITIATOR}" \
      checkmarx.scan.origin="${CX_ORIGIN}" \
      checkmarx.scan.engines="${CX_ENGINES}"

WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app /app

EXPOSE 8080
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]