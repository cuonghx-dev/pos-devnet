#!/bin/bash
source $(pwd)/config.sh

MINER_NODES=(
    '{"public_key":"23081455D3FEaf17426176dfc5Ee7A3ce519aD33","private_key":"3c88fc7d33772dfa81e3c44347a3f9fc1df5946b70e3ba4f8a601e23e94d9072"}' # define this address as the miner in genesis.json
    '{"public_key":"d1d38fdc2669a694bf045b972a68654227143bd6","private_key":"f04e42bede52b46cf4c30b68eb56f96b87fcdae0d713861d72f9dfedaf0620aa"}'
    '{"public_key":"Cbba703129cC993b8c02Ce0AfB4Cd85E26ABa56c","private_key":"a4d13521428735961755d278f8d8f48e7cc35a14d07d29d8de8df9a7908bd590"}'
)

RELAY_NODES=1
SUBNET=10.7.0.0/16

# Create docker network if not exists
if ! docker network inspect $DOCKER_NETWORK_NAME >/dev/null 2>&1; then
  docker network create $DOCKER_NETWORK_NAME --driver bridge --subnet $SUBNET
fi

# Run miner node
echo "Initializing Ethereum node..."

# Start additional nodes dynamically
NUM_NODES=${#MINER_NODES[@]}
for (( i=0; i<$NUM_NODES; i++ )); do
  NODE_IP="10.7.0.$((i+2))"
  NODE_NAME="el-geth-node-$i"
  NODE_PRIVATE_KEY=$(echo ${MINER_NODES[$i]} | jq -r .private_key)
  NODE_PUBLIC_KEY=$(echo ${MINER_NODES[$i]} | jq -r .public_key)

  # Create keystore
  mkdir -p $(pwd)/execution/.ethereum-$i

  echo $NODE_PRIVATE_KEY > $(pwd)/execution/.ethereum-$i/private.key
  echo "password" > $(pwd)/execution/.ethereum-$i/password.txt
  echo $JWT_SECRET > $(pwd)/execution/.ethereum-$i/jwtsecret


  
  if [ $i == 0 ]; then
    echo $BOOT_NODE_KEY > $(pwd)/execution/.ethereum-$i/boot.key
  fi

  docker run --rm \
    -v $(pwd)/execution/.ethereum-$i:/.ethereum \
    ethereum/client-go:v1.11.6 \
    account import --datadir /.ethereum --password /.ethereum/password.txt /.ethereum/private.key

  # Init node
  docker run --rm \
    -v $(pwd)/execution/.ethereum-$i:/.ethereum \
    -v $(pwd)/execution/genesis.json:/.genesis.json \
    ethereum/client-go:v1.11.6 \
    --datadir /.ethereum init /.genesis.json
  
  # $NOKEY_CMD = $i == 0 ? "--nodekey /.ethereum/boot.key" : ""

  # Run node
  docker run -d \
    --name $NODE_NAME \
    --network $DOCKER_NETWORK_NAME \
    -v $(pwd)/execution/.ethereum-$i:/.ethereum \
    -p $((8552 + i)):8551 \
    ethereum/client-go:v1.11.6 \
    --nat=extip:$NODE_IP \
    --http \
    --bootnodes=$BOOT_NODE \
    --http.api=eth,net,web3,debug,trace \
    --http.addr=0.0.0.0 \
    --http.corsdomain=* \
    --http.vhosts=* \
    --datadir=/.ethereum \
    --allow-insecure-unlock \
    --unlock=$NODE_PUBLIC_KEY \
    --networkid=1337 \
    --mine \
    --miner.etherbase=$NODE_PUBLIC_KEY \
    --authrpc.vhosts=* \
    --authrpc.addr=0.0.0.0 \
    --authrpc.jwtsecret=/.ethereum/jwtsecret \
    --syncmode=full \
    --password=/.ethereum/password.txt \

    $([ "$i" -eq 0 ] && echo "--nodekey /.ethereum/boot.key" || echo "")
done

# Vote for the miner
for (( i=0; i<$NUM_NODES; i++ )); do
  NODE_PUBLIC_KEY=$(echo ${MINER_NODES[$i]} | jq -r .public_key)
  # Vote for other nodes as the miner
  for (( j=0; j<$NUM_NODES; j++ )); do
    if [ $i != $j ]; then
      docker exec -it el-geth-node-$j sh -c "geth attach --exec \"clique.propose('\"0x$NODE_PUBLIC_KEY\"', true)\" /.ethereum/geth.ipc"
    fi
  done
done
sleep 5

# Run relay node
NODE_IP="10.7.0.$((NUM_NODES+2))"
docker run --rm \
    -v $(pwd)/execution/.ethereum-relay:/.ethereum \
    -v $(pwd)/execution/genesis.json:/.genesis.json \
    ethereum/client-go:v1.11.6 \
    --datadir /.ethereum init /.genesis.json

echo $JWT_SECRET > $(pwd)/execution/.ethereum-relay/jwtsecret

docker run -d \
  --name el-geth-relay-node \
  --network $DOCKER_NETWORK_NAME \
  -v $(pwd)/execution/.ethereum-relay:/.ethereum \
  -p 8551:8551 \
  -p 8545:8545 \
  ethereum/client-go:v1.11.6 \
  --nat=extip:$NODE_IP \
  --http \
  --http.api=eth,net,web3,debug,trace \
  --http.addr=0.0.0.0 \
  --http.corsdomain=* \
  --http.vhosts=* \
  --datadir=/.ethereum \
  --syncmode=full \
  --authrpc.vhosts=* \
  --authrpc.addr=0.0.0.0 \
  --authrpc.jwtsecret=/.ethereum/jwtsecret \
  --bootnodes=$BOOT_NODE \
  --networkid=1337 \


