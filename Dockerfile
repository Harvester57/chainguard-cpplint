# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:4cd06b43fca46f24925373e09356ab6028005a0225a54c6e4867921289477cc0 as builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/cpplint/venv/bin:$PATH"

WORKDIR /cpplint
RUN python -m venv /cpplint/venv

# Cf. https://pypi.org/project/cpplint/
RUN pip install cpplint==2.0.2

FROM chainguard/python:latest@sha256:92c3483c8ac7eda088e51952b744cce1f3087fe7560a5da672d918b7c57a65fc

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-04-27"
LABEL author="Florian Stosse"
LABEL description="cpplint.py v0.7.4, built using Python Chainguard based image"
LABEL license="MIT license"

ENV TZ="Europe/Paris"

WORKDIR /cpplint

ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /cpplint/venv /venv