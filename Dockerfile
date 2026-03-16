# Cf. https://hub.docker.com/r/chainguard/python/
ARG BUILDKIT_SBOM_SCAN_STAGE=true
FROM chainguard/python:latest-dev@sha256:32cb95ea61afbc761ba76561e9762196efabe9c0f59010e03768ba5dba9dce1f AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV TZ="Europe/Paris"

WORKDIR /cpplint
COPY requirements.txt .
RUN python -m venv venv
ENV PATH="/cpplint/venv/bin:$PATH"

# Cf. https://pypi.org/project/cpplint/
RUN pip install -r /cpplint/requirements.txt --no-cache-dir

FROM chainguard/python:latest@sha256:b720e8333748d1977a6b7971fc85c6bd051e7f7863149c3fa03b460166658ed8

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-05-21"
LABEL author="Florian Stosse"
LABEL description="Cpplint v2.0.2, built using Python Chainguard based image"
LABEL license="MIT license"

WORKDIR /venv

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV TZ="Europe/Paris"
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /cpplint/venv /venv

ENTRYPOINT [ "python3", "/venv/bin/cpplint" ]
