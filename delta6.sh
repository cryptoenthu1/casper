sudo systemctl stop casper.node

# Config changes are required either backup prior to install 
# or update to match config.toml.new after install
sudo mv /etc/casper/config.toml /etc/casper/config.toml.old

cd ~
sudo apt remove -y casper-client casper-node
curl -JLO https://bintray.com/casperlabs/casper-debian-tests/download_file?file_path=casper-node_0.4.0-3480_amd64.deb
curl -JLO https://bintray.com/casperlabs/casper-debian-tests/download_file?file_path=casper-client_0.4.0-3480_amd64.deb

sudo apt install -y ./casper-node_0.4.0-3480_amd64.deb ./casper-client_0.4.0-3480_amd64.deb 

# Get trusted hash for config.toml
curl -s 18.144.176.168:8888/status | jq -r .last_added_block_info.hash
a1="$(curl -s 18.144.176.168:8888/status | jq -r .last_added_block_info.hash)"
sed -i 's/# trusted_hash =/trusted_hash = '"'$a1'"'/' /etc/casper/config.toml
sudo logrotate -f /etc/logrotate.d/casper-node
sudo /etc/casper/delete_local_db.sh
sudo systemctl stop casper-node
sudo systemctl start casper-node
systemctl status casper-node
ctrl+c
sed -i 's/add_bid/do_bid/g' bond.sh
./bond.sh
