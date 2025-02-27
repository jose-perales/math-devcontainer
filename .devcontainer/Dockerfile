FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Create vscode user
ARG USERNAME=vscode
RUN useradd -m -s /bin/bash $USERNAME

# Set the working directory
RUN mkdir /workspace
WORKDIR /workspace

# Install Python, pip, git, curl, wget, gnupg, lsb-release, and other required packages
RUN apt-get update && apt-get install -y \
    python3 python3-pip git curl zsh lsb-release unzip gnupg wget software-properties-common shfmt jq gh

# Install pandoc and pdflatex
RUN apt-get install -y pandoc texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra

# Switch to vscode user before installing uv
USER $USERNAME

# Ensure ~/.local/bin exists and is in PATH
RUN mkdir -p /home/$USERNAME/.local/bin
ENV PATH="/home/$USERNAME/.local/bin:$PATH"

# Install UV explicitly as vscode user
RUN curl -fsSL https://astral.sh/uv/install.sh | sh

# Verify UV installation
CMD [ "bin/sh" ]