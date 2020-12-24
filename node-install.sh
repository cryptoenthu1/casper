cd ~
sudo apt remove -y casper-client casper-node
sleep 3
curl -JLO https://bintray.com/casperlabs/debian/download_file?file_path=casper-client_0.3.1-3423_amd64.deb
sleep 3
curl -JLO https://bintray.com/casperlabs/debian/download_file?file_path=casper-node_0.3.1-3423_amd64.deb
sleep 3
sudo apt install -y ./casper-node_0.3.1-3423_amd64.deb
sleep 3 
sudo apt install -y ./casper-client_0.3.1-3423_amd64.deb
sleep 3
casper-client keygen /etc/casper/validator_keys/
sleep 3
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
sleep 3
curl -s http://54.67.67.33:8888/status | jq -r .last_added_block_info.hash
sleep 3
sudo logrotate -f /etc/logrotate.d/casper-node
sleep 3
sudo /etc/casper/delete_local_db.sh
sleep 3
sudo -u casper /etc/casper/pull_genesis.sh
sleep 3
sudo systemctl start casper-node
sleep 3
# Wait a few seconds then
sleep 3
systemctl status casper-node
