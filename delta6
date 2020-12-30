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
