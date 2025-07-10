# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:a0768dc21374553aba5889053b2a1f45468eed1dc51fe9a1549339693a50ba54

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
RUN pip install cpplint==2.0.2 --no-cache-dir

# Test run
RUN cpplint --version

ENTRYPOINT [ 'cpplint' ]
