docker pull ubuntu:16.04
docker run -it -d --name bitcoind ubuntu:16.04 bash
docker cp . bitcoind:/gcpshell
docker exec -it bitcoind bash
