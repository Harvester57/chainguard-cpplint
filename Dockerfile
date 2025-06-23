# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:1e7504bdd6ef32989a7014b37ef2e8262c4d74feab017dc1da0a25b7d198e149 AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/cpplint/venv/bin:$PATH"

WORKDIR /cpplint
RUN python -m venv /cpplint/venv

# Cf. https://pypi.org/project/cpplint/
RUN pip install cpplint==2.0.2

FROM chainguard/python:latest@sha256:5e1aa298ad3f50f105b9121b1d3a39bdbe33e17a5a28555a1d12a7c91529fc15

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