# Utiliser l'image debia officielle comme image parent
FROM debian:latest


RUN apt-get update -yq \
    && apt-get install -y \
      proftpd \
      bash \
      systemctl

COPY ./proftpd.conf /etc/proftpd/proftpd.conf


RUN /etc/init.d/proftpd restart

# Exposer le port 80 ou 1050 à 1055
EXPOSE 21 1050-1055

# Ajouter les utilisateurs
RUN useradd user1 -m
RUN echo "user1:pwd" | chpasswd

# Lancer le service au démarrage du conteneur
RUN systemctl enable proftpd
CMD ["systemctl", "start", "proftpd"]
