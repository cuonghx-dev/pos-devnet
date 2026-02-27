JWT_SECRET=0xfad2709d0bb03bf0e8ba3c99bea194575d3e98863133d1af638ed056d1d59345
POA_BOOT_NODE_KEY=31640af736ec4dfef9d776189b3ca4e6d7732d853b815ece7408c9d3c4e10433
BOOT_NODE_KEY=31640af736ec4dfef9d776189b3ca4e6d7732d853b815ece7408c9d3c4e10435
BOOT_NODE=enode://0c284ba5ce93c5879aa2f0f6132fe19e0278d32b38c4eef8b3da8e3bdba743e02732bf542e5cb282b857dc2ae278cac5c383fc37d66b014f1ae1e183045a41ea@10.7.1.4:30303
POS_EL_BOOT_NODE=enode://0cb28090170a3e1f219817c344762241a02a4171ccb963ddaac10e9adc5e8f71f12de2d58d8efe12ddb94fd54efad951063c5cc37c21a4dd22bec2becb2ca48f@10.7.1.5:30303
DOCKER_NETWORK_NAME=pos-network
BEACON_BOOT_NODE=enr:-MK4QElQE6zwCxTPtNLA0RVyRRBP1oXlRE58S-Z0n5IuL_c_Bq14JTawt6MRN0JKkD1nL0QJvLG06sWPCWMoowL2EsOGAZf0AmXuh2F0dG5ldHOIAAAAAAAAAACEZXRoMpCNTrbFAQAAhAEAAAAAAAAAgmlkgnY0gmlwhAoHAAKJc2VjcDI1NmsxoQJZJFLCdVOkj35zGdm8bpM_AN2a8g_a4GWoXwTHOBP_XYhzeW5jbmV0cwCDdGNwgjLIg3VkcIIu4A
NORMAL_NODES=2
VALIDATOR_NODES=3
BOOT_NODES=2

MINER_NODES=(
    '{"public_key":"23081455D3FEaf17426176dfc5Ee7A3ce519aD33","private_key":"3c88fc7d33772dfa81e3c44347a3f9fc1df5946b70e3ba4f8a601e23e94d9072"}'
    '{"public_key":"d1d38fdc2669a694bf045b972a68654227143bd6","private_key":"f04e42bede52b46cf4c30b68eb56f96b87fcdae0d713861d72f9dfedaf0620aa"}'
    '{"public_key":"Cbba703129cC993b8c02Ce0AfB4Cd85E26ABa56c","private_key":"a4d13521428735961755d278f8d8f48e7cc35a14d07d29d8de8df9a7908bd590"}'
)

BEACON_VALIDATORS=(
    '{"crypto": {"kdf": {"function": "scrypt", "params": {"dklen": 32, "n": 262144, "r": 8, "p": 1, "salt": "f6173941737b62bb6dc610422e8768338d899f058350f5ad1d0edd18e7b20153"}, "message": ""}, "checksum": {"function": "sha256", "params": {}, "message": "187561cecafd390a3d8c8810d96954784f7f4c999266b655731552896f230476"}, "cipher": {"function": "aes-128-ctr", "params": {"iv": "af029f5a12fa4f118f699ff4c56862d7"}, "message": "749c2955cc6b166f38f113964d96a0aefb70d2e0de3e1f9c83cd99e3fecc6b3d"}}, "description": "", "pubkey": "a0a0d26e11706345ce9bebf2b3330017818e0e06a88224b80b97414777b55e1d3788f4458b8279fd4138e7249f00bb2e", "path": "m/12381/3600/0/0/0", "uuid": "63666742-ad5e-455e-abff-ce6b88cc48ea", "version": 4}'

    '{"crypto": {"kdf": {"function": "scrypt", "params": {"dklen": 32, "n": 262144, "r": 8, "p": 1, "salt": "aedfb4c1c4a338cbc8a7792df6e2620919dc0463ed55b7e7f37a7c18f4827e52"}, "message": ""}, "checksum": {"function": "sha256", "params": {}, "message": "a3317606a97111d445c24b38ea48bb4e0aff714d1eb2a47dd25cf56b03f286a4"}, "cipher": {"function": "aes-128-ctr", "params": {"iv": "edc188573625d16cf931809c03bcd893"}, "message": "7685299af9a74fc8975003f1af58b2e7d02d63b85043e077531586ef775484d5"}}, "description": "", "pubkey": "8dd17aaa942fd050dbba43f512d33377fb14c930d4d6d6b817e0e625ea7d38e25e4eebb8d99297837c8418a15afe77f3", "path": "m/12381/3600/1/0/0", "uuid": "ca25143e-1adb-4bcd-81a4-73614d91e1c1", "version": 4}'

    '{"crypto": {"kdf": {"function": "scrypt", "params": {"dklen": 32, "n": 262144, "r": 8, "p": 1, "salt": "9d85e4fe4d679cc986c772ddafc86a94b3bfe4d6ae29d63c56bf7cc482392362"}, "message": ""}, "checksum": {"function": "sha256", "params": {}, "message": "28aed2416439c61b617d58a9755966a2718aad5c1b55692f2c940671dcdc84e6"}, "cipher": {"function": "aes-128-ctr", "params": {"iv": "9d22be8866d7a67d439f02922fd330ff"}, "message": "2f1098d899e71478f77f0dba5811e8b615e00a9357202ca168882803e8a860fb"}}, "description": "", "pubkey": "8ce82847a221be6e601ee5b9651fcaf2e68ffc53a5c8162c9eaf76801c48ea7351959e5e91a9334e445e22018fc4db10", "path": "m/12381/3600/2/0/0", "uuid": "07ff0bf2-a59a-4295-9048-de93e205340d", "version": 4}'
)
