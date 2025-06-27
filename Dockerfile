# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:d447718eb6e6ab2f0f4c9bd41e7559e3f6a67a66536dec6b103239c8beb04ceb AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/cpplint/venv/bin:$PATH"

WORKDIR /cpplint
RUN python -m venv /cpplint/venv

# Cf. https://pypi.org/project/cpplint/
RUN pip install cpplint==2.0.2

FROM chainguard/python:latest@sha256:9ae93505cca87c6ea679ef7b1c61ec33a86e89329067c059d54e8a585313098e

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-05-21"
LABEL author="Florian Stosse"
LABEL description="Cpplint v2.0.2, built using Python Chainguard based image"
LABEL license="MIT license"

ENV TZ="Europe/Paris"

WORKDIR /cpplint

ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /cpplint/venv /venv