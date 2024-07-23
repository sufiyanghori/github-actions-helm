# Use Alpine 3.20
FROM alpine:3.20

# Set environment variables for Helm version and download URL
ENV HELM_VERSION="v3.15.3"
ENV HELM_BASE_URL="https://get.helm.sh"
ENV HELM_TAR_FILE="helm-${HELM_VERSION}-linux-amd64.tar.gz"

# Install necessary packages
RUN apk add --no-cache ca-certificates jq curl bash nodejs npm

# Download and install Helm
RUN curl -fsSL -o /tmp/helm.tar.gz ${HELM_BASE_URL}/${HELM_TAR_FILE} && \
    tar -xzf /tmp/helm.tar.gz -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf /tmp/linux-amd64 /tmp/helm.tar.gz

# Set the Python path environment variable
ENV PYTHONPATH "/usr/lib/python3.8/site-packages/"

# Copy your application code to the container (assuming your application code is in the same directory as your Dockerfile)
COPY . /usr/src/

# Set the entry point for the container to run your application
ENTRYPOINT ["node", "/usr/src/index.js"]

