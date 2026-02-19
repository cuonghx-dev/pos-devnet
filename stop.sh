#!/bin/bash
sh ./execution/clean.sh

docker stop cl-beacon-node-1 && docker rm cl-beacon-node-1
docker stop cl-beacon-node-2 && docker rm cl-beacon-node-2
docker stop cl-beacon-node-3 && docker rm cl-beacon-node-3

docker stop cl-validator-1 && docker rm cl-validator-1
docker stop cl-validator-2 && docker rm cl-validator-2
docker stop cl-validator-3 && docker rm cl-validator-3

docker stop cl-boot-node && docker rm cl-boot-node

docker stop cl-dora && docker rm cl-dora
