FROM node:18-alpine

RUN npm install -g @mockoon/cli@8.4.0
WORKDIR /app
COPY . .

# Install curl for healthcheck and tzdata for timezone support.
RUN apk --no-cache add curl tzdata

# Do not run as root.
RUN adduser --shell /bin/sh --disabled-password --gecos "" mockoon
RUN chown -R mockoon /app
USER mockoon

EXPOSE 3001

ENTRYPOINT ["mockoon-cli","start","--disable-log-to-file","--port","3001","--data"]
CMD ["push-receiver.json"]

# Usage: docker run -p <host_port>:<container_port> vpapidokha/mockoon