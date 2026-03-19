FROM ubuntu:24.04

# add git or other tools based on your needs
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

USER ubuntu
WORKDIR /home/ubuntu

RUN curl -fsSL https://claude.ai/install.sh | bash
RUN echo 'export PATH="$HOME/.local/bin:$PATH"'
RUN rm -rf /home/ubuntu/.claude.json

RUN mkdir -p /home/ubuntu/.claude && \
    chown -R ubuntu:ubuntu /home/ubuntu/.claude

VOLUME ["/home/ubuntu/.claude"]

CMD [ "/home/ubuntu/.local/bin/claude" ]
