# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:50c95e552d7a74f678005fd0d579e4f7fe71c8f371ffe61a651a4648d1da38a7

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-05-21"
LABEL author="Florian Stosse"
LABEL description="Cpplint v2.0.2, built using Python Chainguard based image"
LABEL license="MIT license"

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV TZ="Europe/Paris"

WORKDIR /cpplint
RUN python -m venv venv
ENV PATH="/cpplint/venv/bin:$PATH"

# Cf. https://pypi.org/project/cpplint/
RUN pip install -r requirements.txt --no-cache-dir

# Test run
RUN cpplint --version

ENTRYPOINT [ "cpplint" ]
