echo "Starting beacon node 1..."

docker run -d \
  --name cl-beacon-node-1 \
  -v "$(pwd)/consensus/config.yml:/config.yml" \
  -v "$(pwd)/consensus/jwtsecret:/jwtsecret" \
  -p 4001:4000 \
  -p 3501:3500 \
  gcr.io/prysmaticlabs/prysm/beacon-chain:v3.1.2 \
  --min-sync-peers=0 \
  --chain-config-file=/config.yml \
  --chain-id=1337 \
  --network-id=1337 \
  --contract-deployment-block=0 \
  --deposit-contract=0x4242424242424242424242424242424242424242 \
  --grpc-gateway-host=0.0.0.0 \
  --http-web3provider=http://host.docker.internal:8552 \
  --accept-terms-of-use \
  --enable-debug-rpc-endpoints \
  --rpc-host=0.0.0.0 \
  --rpc-port=4000 \
  --jwt-secret=/jwtsecret \
  --bootstrap-node=enr:-MK4QE6JmYUl5FDk6R4iACb_05nv8ZTDALUnWDDA2VMaq5WZIqVPowQsHWt67FcywA_gMrvHqbPE_EbIfgx0Zi5vvtmGAZgcluvbh2F0dG5ldHOIAAAAAAAAAACEZXRoMpCdNFFfAgAAhP__________gmlkgnY0gmlwhKwRAAKJc2VjcDI1NmsxoQJZJFLCdVOkj35zGdm8bpM_AN2a8g_a4GWoXwTHOBP_XYhzeW5jbmV0cwCDdGNwgjLIg3VkcIIu4A

echo "Importing validator 1 keys..."

docker run --rm \
  -v "$(pwd)/consensus/beacon-node-1/wallet:/wallet" \
  -v "$(pwd)/consensus/beacon-node-1/validator_keys:/validator_keys" \
  gcr.io/prysmaticlabs/prysm/validator:v3.1.2 \
  accounts import \
  --wallet-dir=/wallet \
  --wallet-password-file=/wallet/password.txt \
  --keys-dir=/validator_keys \
  --account-password-file=/validator_keys/password.txt \
  --accept-terms-of-use

sleep 10

echo "Starting validator 1..."

docker run -d \
  --name cl-validator-1 \
  -v "$(pwd)/consensus/config.yml:/config.yml" \
  -v "$(pwd)/consensus/beacon-node-1/wallet:/wallet" \
  gcr.io/prysmaticlabs/prysm/validator:v3.1.2 \
  --beacon-rpc-provider=host.docker.internal:4001 \
  --beacon-rpc-gateway-provider=http://host.docker.internal:3501 \
  --accept-terms-of-use \
  --chain-config-file=/config.yml \
  --force-clear-db \
  --wallet-dir=/wallet \
  --wallet-password-file=/wallet/password.txt \
  --graffiti=validator-1