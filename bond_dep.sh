sudo apt install jq
sleep 3
sudo apt-get update && sudo apt-get install make
sleep 3
curl https://sh.rustup.rs -sSf | sh
sleep 3
sudo apt install build-essential
sleep 3
curl -JLO https://raw.githubusercontent.com/matsuro-hadouken/casper-tools/master/balance_check.sh
sleep 3
curl -JLO https://raw.githubusercontent.com/matsuro-hadouken/casper-tools/master/bond.sh
sleep 3
chmod 755 balance_check.sh
sleep 3
chmod 755 bond.sh
sleep 3
./balance_check.sh $(cat /etc/casper/validator_keys/public_key_hex)
sleep 3
source $HOME/.cargo/env
sleep 3
git clone https://github.com/CasperLabs/casper-node
sleep 3
cd casper-node
sleep 3
git checkout v0.2.1
sleep 3
make setup-rs
sleep 3
make build-client-contracts -j
sleep 3
make build-system-contracts -j
