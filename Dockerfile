FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install wget gpg xdg-utils apt-transport-https ca-certificates -y
RUN wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
RUN cat signal-desktop-keyring.gpg | tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
RUN echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | tee -a /etc/apt/sources.list.d/signal-xenial.list
RUN apt-get update
RUN apt-get install signal-desktop -y
RUN useradd signal -d /home/signal -m
USER signal
ENV HOME /home/signal
RUN mkdir /home/signal/.config
RUN chmod 0700 /home/signal/.config
RUN mkdir /home/signal/.config/Signal
CMD signal-desktop --no-sandbox
