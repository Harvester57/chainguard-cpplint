# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:b7d7c6386055883f607b90063cd0fd14cc6cdf6681d02d79f5f71d151ab3ef33 AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/cpplint/venv/bin:$PATH"

WORKDIR /cpplint
RUN python -m venv /cpplint/venv

# Cf. https://pypi.org/project/cpplint/
RUN pip install cpplint==2.0.2 --no-cache-dir

FROM chainguard/python:latest@sha256:f05174c45fa717309a5d504a976c12690eccd650efeac5221d1d53b32ff41e71

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