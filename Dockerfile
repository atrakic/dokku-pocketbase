# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM alpine:3.20

# Build arguments
ARG POCKETBASE_VERSION=0.22.21
ARG TARGETOS=linux
ARG TARGETARCH=amd64

# Environment variables
ENV POCKETBASE_VERSION=${POCKETBASE_VERSION}

# Set working directory
WORKDIR /app

# Hadolint ignore=DL3018
RUN apk add --no-cache unzip ca-certificates && \
    wget -O pocketbase.zip "https://github.com/pocketbase/pocketbase/releases/download/v${POCKETBASE_VERSION}/pocketbase_${POCKETBASE_VERSION}_${TARGETOS}_${TARGETARCH}.zip" && \
    unzip pocketbase.zip && \
    rm pocketbase.zip && \
    chmod +x pocketbase

# uncomment to copy the local pb_migrations dir into the image
# COPY ./pb_migrations /pb/pb_migrations

# uncomment to copy the local pb_hooks dir into the image
# COPY ./pb_hooks /pb/pb_hooks

# Dokku-specific: Use $PORT environment variable
ENV PORT=5000

# Expose port
EXPOSE $PORT

# Start Pocketbase
CMD ["sh", "-c", "/app/pocketbase serve --http=0.0.0.0:$PORT"]
