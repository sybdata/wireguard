# Как настроить WireGuard на Android
### Пошаговая инструкция по настройке WireGuard на Android для подключения к sybdataVPN:
* 1 Установите WireGuard из магазина приложений Play Маркет (https://play.google.com/store/apps/details?id=com.wireguard.android&hl=ru)
<img width="974" alt="2023-03-25" src="https://user-images.githubusercontent.com/24189833/227725488-571248a5-6f40-437f-bbe5-2db34bbd9877.png">

* 2 Откройте установленное приложение WireGuard. Нажмите кнопку «+» в правом нижнем углу, а затем – «сканировать QR-КОД». 
<img width="320" alt="image_2x66kj" src="https://user-images.githubusercontent.com/24189833/227725540-e2de4299-e434-4a18-8c0e-b446359747e3.png"> <img width="320" alt="Screenshot_20230324-220500" src="https://user-images.githubusercontent.com/24189833/227726059-5766761a-4d36-4240-882d-75a1b47911e7.png">
  
* 3 Назовите соединение для себя(свободный выбор), и нажмите на кнопку "добавитьтоннель" ("Tunnel erstellen")
<img width="320" alt="Screenshot_20230324-221144" src="https://user-images.githubusercontent.com/24189833/227726023-e6956be0-5bef-4e11-9498-6b2c9eaa9b4f.png">

* 4 Включите добавленный VPN-тоннель, переведя переключатель рядом с его названием в положение «Вкл».
<img width="320" alt="Screenshot_20230325-162552" src="https://user-images.githubusercontent.com/24189833/227726720-d22a9f34-1bbe-480c-b8bf-62bfcad4073c.png">
## Готово, вы подключены к быстрому VPN!
После подключения проверьте, изменился ли ваш IP-адрес. Для этого откройте сайт https://www.reg.ru/web-tools/myip и там будет указан ваш новый IP-адрес и локация.
<img width="320" alt="Screenshot_20230325-163455" src="https://user-images.githubusercontent.com/24189833/227727183-47a8b900-3883-461a-aa00-c04202579c9b.png">





# Создать cамостоятельный хостинг Wireguard VPN
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/denisix/wireguard?style=flat-square)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/denisix/wireguard?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/denisix/wireguard?style=flat-square)

# Wireguard VPN

Easy Wireguard server setup using Docker Engine

Information related to Wireguard VPN you can find at official website - [https://www.wireguard.com/](https://www.wireguard.com/)

## Requirements

- GNU/Linux host with a recent kernel (5.x)
- Wireguard module installed using

```sh
sudo apt install wireguard-tools
```

- installed [Docker](https://docs.docker.com/engine/install/) Engine

## Setup

- manual run

```sh
docker run --rm \
  --cap-add sys_module \
  --cap-add net_admin \
  -e PUBLIC_IP=1.2.3.4 \
  -e PORT=55555 \
  -e DNS=8.8.8.8 \
  -e SUBNET=10.88 \
  -e SUBNET_PREFIX=16 \
  -e SUBNET_IP=10.88.0.1/16 \
  -v ./wireguard:/etc/wireguard \
  -p 55555:55555/udp denisix/wireguard
```

- Sample **[docker-compose.yml](https://raw.githubusercontent.com/denisix/wireguard/main/docker-compose.yml)** file:

```docker-compose.yml
version: "3"
services:

  wireguard:
    image: denisix/wireguard
    environment:
      - PUBLIC_IP=1.2.3.4
      - PORT=55555
      - DNS=8.8.8.8
      - SUBNET=10.88
      - SUBNET_PREFIX=16
      - SUBNET_IP=10.88.0.1/16
    volumes:
      - ./wireguard/:/etc/wireguard/
    ports:
      - 55555:55555/udp
    cap_add:
      - SYS_MODULE
      - NET_ADMIN
    restart: unless-stopped
```

To start your instance:

```sh
docker-compose up -d wireguard
```

There will be a **QR code** within the container's logs for the test user:

```sh
docker-compose logs wireguard
```

...as well as simple copy-paste instructions for your desktop clients :)

Adding a **new client** peer is easy:

```sh
docker-compose exec wireguard addclient client1
```

> P.S.: Please give [this repo](https://github.com/denisix/wireguard) a star if you like it :wink:
