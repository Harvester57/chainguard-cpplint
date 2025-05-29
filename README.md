# Cpplint Docker Image (Chainguard-based)

This repository contains a Dockerfile to build a minimal Docker image for `cpplint`, a C++ style checker. It leverages Chainguard's Python base images for a smaller attack surface and improved security.

The image installs `cpplint` version 2.0.2.

## Features

*   **Minimal Base Image**: Uses `chainguard/python:latest` for the final stage, ensuring a small image size.
*   **Secure**: Built on Chainguard images known for their focus on security and minimal components.
*   **Multi-stage Build**: Utilizes a builder stage with `chainguard/python:latest-dev` to compile/install dependencies, keeping the final image lean.
*   **Specific Cpplint Version**: Installs `cpplint==2.0.2`.

## Image Details

*   **Builder Base Image**: `chainguard/python:latest-dev@sha256:8077ffcb2bddcef1dbbe874651507b08439b688d35f8c8967218ae24a322c293`
*   **Final Base Image**: `chainguard/python:latest@sha256:6c48637295791f828deb8056bbcde9b4b252c1191a1c9f23a6cce0a744da4ecf`
*   **Cpplint Version**: 2.0.2
*   **Default Workdir**: `/cpplint`

## Labels

The image includes the following metadata labels:

*   `maintainer`: florian.stosse@gmail.com
*   `lastupdate`: 2025-05-21 (Note: This is the date specified in the Dockerfile)
*   `author`: Florian Stosse
*   `description`: Cpplint v2.0.2, built using Python Chainguard based image (Updated to reflect installed version)
*   `license`: MIT license

## Usage

### Building the Image

To build the image locally, navigate to the directory containing the `Dockerfile` and run:

```bash
docker build -t cpplint-chainguard .
```

You can replace `cpplint-chainguard` with your preferred image name and tag.

### Running Cpplint

To run `cpplint` on your C++ source files, you can mount your project directory into the container.

For example, to lint a file named `myfile.cpp` in your current directory:

```bash
docker run --rm -v "$(pwd):/workdir" -w /workdir cpplint-chainguard cpplint myfile.cpp
```

Or to lint all C++ files in the current directory (adjust filter as needed):

```bash
docker run --rm -v "$(pwd):/workdir" -w /workdir cpplint-chainguard cpplint --recursive .
```

**Explanation of the command:**

*   `docker run --rm`: Runs the container and removes it after execution.
*   `-v "$(pwd):/workdir"`: Mounts the current host directory (`$(pwd)`) to `/workdir` inside the container.
*   `-w /workdir`: Sets the working directory inside the container to `/workdir`.
*   `cpplint-chainguard`: The name of the image you built (or pulled).
*   `cpplint myfile.cpp` or `cpplint --recursive .`: The `cpplint` command and its arguments.

## Environment Variables

The following environment variables are set in the final image:

*   `TZ="Europe/Paris"`: Sets the timezone.
*   `PYTHONUNBUFFERED=1`: Ensures Python output is sent straight to terminal without being first buffered.
*   `PATH="/venv/bin:$PATH"`: Adds the virtual environment's `bin` directory to the `PATH`.

## License

This project is licensed under the MIT License - see the `license` label in the Docker image or consult the `cpplint` project for its specific license.