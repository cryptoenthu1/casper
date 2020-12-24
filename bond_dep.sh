sudo apt install jq
sudo apt-get update && sudo apt-get install make
sudo apt install git
curl https://sh.rustup.rs -sSf | sh
sudo apt install build-essential
curl -JLO https://raw.githubusercontent.com/matsuro-hadouken/casper-tools/master/balance_check.sh
curl -JLO https://raw.githubusercontent.com/matsuro-hadouken/casper-tools/master/bond.sh
chmod 755 balance_check.sh
chmod 755 bond.sh
./balance_check.sh $(cat /etc/casper/validator_keys/public_key_hex)
source $HOME/.cargo/env
git clone https://github.com/CasperLabs/casper-node
cd ~/casper-node
git checkout v0.2.1
make setup-rs
make build-client-contracts -j
make build-system-contracts -j
