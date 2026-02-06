FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository multiverse \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections \
    && apt-get install -y lib32gcc-s1 steamcmd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create steam user
RUN useradd -m -s /bin/bash steam

# Switch to steam user
USER steam
WORKDIR /home/steam

# Install Valheim server with retry and timeout handling
RUN ln -s /usr/games/steamcmd steamcmd \
    && ./steamcmd +quit \
    && sleep 5 \
    && (timeout 300 ./steamcmd +force_install_dir /home/steam/valheim +login anonymous +app_update 896660 validate +quit || \
        (sleep 10 && timeout 300 ./steamcmd +force_install_dir /home/steam/valheim +login anonymous +app_update 896660 validate +quit) || \
        (sleep 20 && timeout 300 ./steamcmd +force_install_dir /home/steam/valheim +login anonymous +app_update 896660 validate +quit))

WORKDIR /home/steam/valheim

# Expose ports
EXPOSE 2456-2458/udp

# Start script
COPY --chown=steam:steam start_server.sh .
RUN chmod +x start_server.sh

CMD ["./start_server.sh"]
