# Cf. https://hub.docker.com/r/chainguard/python/
ARG BUILDKIT_SBOM_SCAN_STAGE=true
FROM chainguard/python:latest-dev@sha256:09265da08fb023a0d4e4155298dab3aa514bdd0746b79b11d4252ef806792127 AS builder

ENV LANG=C.UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TZ="Europe/Paris"

WORKDIR /cpplint
COPY requirements.txt .
RUN python -m venv venv
ENV PATH="/cpplint/venv/bin:$PATH"

# Cf. https://pypi.org/project/cpplint/
RUN pip install -r /cpplint/requirements.txt --no-cache-dir

FROM chainguard/python:latest@sha256:7e7c7716d8eebd4756a0237b8a1a3857344d45bc21b7a052a334ffafc2928119

LABEL org.opencontainers.image.authors="Florian Stosse <florian.stosse@gmail.com>"
LABEL org.opencontainers.image.created="2026-06-01"
LABEL org.opencontainers.image.description="Cpplint v2.0.2, built using Python Chainguard based image"
LABEL org.opencontainers.image.licenses="MIT license"

WORKDIR /venv

ENV LANG=C.UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TZ="Europe/Paris" \
    PATH="/venv/bin:$PATH"

COPY --from=builder /cpplint/venv /venv

ENTRYPOINT [ "python3", "/venv/bin/cpplint" ]
