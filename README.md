Dockerfile to run [NanoKVM-USB](https://github.com/sipeed/NanoKVM-USB/tree/main/browser) in docker locally.

Published to [Docker HUB](https://hub.docker.com/r/maxx380/nanokvm-usb)


Portainer stack (or docker-compose) config example:

```yaml
services:
  kvm:
    image: maxx380/nanokvm-usb
    restart: always
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - path/site.conf:/etc/nginx/conf.d/site.conf
      - path/site.crt:/etc/nginx/certs/site.crt
      - path/site.key:/etc/nginx/certs/site.key
    networks:
       service-network:
           ipv4_address: IP
    dns:
      - IP

networks:
  service-network:
    name: service-network
    external: true
```


Nginx site.conf file:
```txt
 server {
        listen 80;
        server_name site;

        location / {
            return 301 https://\$host\$request_uri;
        }
    }

    server {
        listen 443 ssl;
        server_name site;
        ssl_certificate /etc/nginx/certs/site.crt;
        ssl_certificate_key /etc/nginx/certs/site.key;

        location / {
           root /usr/share/nginx/html;
           try_files $uri /index.html;
        }
    }
```
