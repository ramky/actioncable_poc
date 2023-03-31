# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Curl commands

curl --include \
--no-buffer \
--header "Connection: Upgrade" \
--header "Upgrade: websocket" \
--header "Host: http://dev.ram-iyer.com" \
--header "Origin: http://dev.ram-iyer.com" \
--header "Sec-WebSocket-Version: 13" \
ws://localhost:3000/cable

- Ruby version

- System dependencies

docker run -d --name local_redis -p 6379:6379 redis:latest

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
