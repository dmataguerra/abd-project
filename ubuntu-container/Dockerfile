FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Paquetes base + PostgreSQL
RUN apt-get update && apt-get install -y \
    tzdata \
    nano bash-completion locales sudo less curl wget git unzip zip tar \
    iputils-ping net-tools iproute2 dnsutils procps htop ca-certificates gnupg \
    lsb-release software-properties-common \
    rsyslog cron \
    postgresql postgresql-contrib postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Crear el cluster de postgresql
RUN service postgresql start && \
    sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"

# Exponer PostgreSQL
EXPOSE 5432

WORKDIR /work

# Arrancar postgres y mantener el contenedor vivo
CMD service postgresql start && bash -lc "sleep infinity"
