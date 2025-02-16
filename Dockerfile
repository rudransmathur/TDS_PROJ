FROM python:3.13-slim-bookworm

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download and install uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Install FastAPI and Uvicorn
RUN pip install fastapi uvicorn

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin:$PATH"

# Set working directory
WORKDIR /app

# Typically, you would use `COPY . .` to copy files from the host machine,
# but here we're just using a simple script.
COPY app.py /app

# Run the script
CMD ["/root/.local/bin/uv", "run", "app.py"]