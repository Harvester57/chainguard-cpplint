# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:eb677f2d18459e6ac274e441ad6a7c932faafc79c2cd81efd10c1eeaa96ea4c0 AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/cpplint/venv/bin:$PATH"

WORKDIR /cpplint
RUN python -m venv /cpplint/venv

# Cf. https://pypi.org/project/cpplint/
RUN pip install cpplint==2.0.2

FROM chainguard/python:latest@sha256:1e8da8caa7cd3544aa2e5f3e447f99458ae44fc6a12b5bfe8b47c817367cb45e

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