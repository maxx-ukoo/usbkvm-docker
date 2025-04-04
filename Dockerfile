FROM node:23-alpine3.20

RUN apk add --no-cache wget git
RUN wget -qO /bin/pnpm "https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64" && chmod +x /bin/pnpm

RUN git clone https://github.com/sipeed/NanoKVM-USB.git /app && \
    cd /app/browser && \
    pnpm install && \
    pnpm build

FROM nginx:1.27.4-alpine    

COPY --from=0 /app/browser/dist /usr/share/nginx/html

