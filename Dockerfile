FROM python:3.11-slim

# Test with hardcoded labels first
LABEL test.label="this-is-a-test" \
      test.number="12345"

# Accept build arguments
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG BITBUCKET_REPO_NAME
ARG BITBUCKET_PROJECT_ID
ARG BITBUCKET_REPO_OWNER
ARG BITBUCKET_REPO_FULL_NAME
ARG BITBUCKET_BRANCH
ARG BITBUCKET_COMMIT
ARG BITBUCKET_BUILD_NUMBER
ARG BITBUCKET_TRIGGERER

# Add Bitbucket repository metadata labels
LABEL bitbucket.repo.name="${BITBUCKET_REPO_NAME}" \
      bitbucket.project.id="${BITBUCKET_PROJECT_ID}" \
      bitbucket.repo.owner="${BITBUCKET_REPO_OWNER}" \
      bitbucket.repo.full_name="${BITBUCKET_REPO_FULL_NAME}" \
      bitbucket.branch="${BITBUCKET_BRANCH}" \
      bitbucket.commit="${BITBUCKET_COMMIT}" \
      bitbucket.build.number="${BITBUCKET_BUILD_NUMBER}" \
      bitbucket.triggered.by="${BITBUCKET_TRIGGERER}" \
      bitbucket.repo.url="https://bitbucket.org/${BITBUCKET_REPO_FULL_NAME}"

# Add OCI standard labels
LABEL maintainer="seclogic-admin@bitbucket.org" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.source="https://bitbucket.org/${BITBUCKET_REPO_FULL_NAME}.git" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.title="${BITBUCKET_REPO_NAME}" \
      org.opencontainers.image.description="FastAPI application for GKE deployment"

WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app /app

EXPOSE 8080
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]