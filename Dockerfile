# RecargaPay Platform Devcontainer Image
#
# Base image used by every service repo's `.devcontainer/`. Installs the platform's
# pinned toolchain so engineers don't manage versions locally.
#
# Built nightly by GitHub Actions and pushed to ghcr.io/recargapay/platform-devcontainer.

FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ARG BUN_VERSION=1.3.10
ARG PULUMI_VERSION=3.142.0
ARG KIND_VERSION=0.24.0
ARG KUBECTL_VERSION=1.30.0
ARG TILT_VERSION=0.33.18
ARG OPA_VERSION=1.16.1
ARG NODE_VERSION=24

RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Bun
RUN curl -fsSL https://bun.sh/install | bash -s "bun-v${BUN_VERSION}" \
    && mv /root/.bun /usr/local/bun
ENV PATH="/usr/local/bun/bin:${PATH}"

# Pulumi
RUN curl -fsSL https://get.pulumi.com | sh -s -- --version ${PULUMI_VERSION} \
    && mv /root/.pulumi /usr/local/pulumi
ENV PATH="/usr/local/pulumi/bin:${PATH}"

# kind
RUN curl -fsSL -o /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v${KIND_VERSION}/kind-linux-amd64 \
    && chmod +x /usr/local/bin/kind

# kubectl
RUN curl -fsSL -o /usr/local/bin/kubectl https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

# tilt
RUN curl -fsSL https://github.com/tilt-dev/tilt/releases/download/v${TILT_VERSION}/tilt.${TILT_VERSION}.linux.x86_64.tar.gz \
        | tar -xz -C /usr/local/bin tilt

# opa
RUN curl -fsSL -o /usr/local/bin/opa https://openpolicyagent.org/downloads/v${OPA_VERSION}/opa_linux_amd64 \
    && chmod +x /usr/local/bin/opa

USER vscode
WORKDIR /workspace
