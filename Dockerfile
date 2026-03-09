# Cf. https://hub.docker.com/r/chainguard/python/
ARG BUILDKIT_SBOM_SCAN_STAGE=true
FROM chainguard/python:latest-dev@sha256:4b05460cc186cfd85deab1bfa1013788c982f9b9a23f52388bfb820f34bea874 AS builder

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

FROM chainguard/python:latest@sha256:e1d518a526adce156f88af1adba65428a352fbb8f753020a0cba899399662036

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
