# !/bin/bash
sh ./execution/start.sh

sleep 30

sh ./consensus/start.sh
sh ./consensus/dora/start.sh

sleep 30

sh ./scripts/deposit/start.sh

