# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:1cd33a5007bf8a9e62110ae7345eff5073442869b1aba130ee36ee3f3e0bb6ae

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
COPY requirements.txt .
RUN python -m venv venv
ENV PATH="/cpplint/venv/bin:$PATH"

# Cf. https://pypi.org/project/cpplint/
RUN pip install -r /cpplint/requirements.txt --no-cache-dir

# Test run
RUN cpplint --version

ENTRYPOINT [ "cpplint" ]
