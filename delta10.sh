#### delta 10 ####

sudo systemctl stop casper-node
sudo systemctl stop casper-node-launcher

cd ~
sudo apt remove -y casper-node 
sudo apt remove -y casper-client 
sudo apt remove -y casper-node-launcher

# Clean up old genesis file location
sudo rm /etc/casper/config.*
sudo rm /etc/casper/accounts.csv 
sudo rm /etc/casper/chainspec.toml 
sudo rm /etc/casper/validation.md5

curl -JLO https://bintray.com/casperlabs/debian/download_file?file_path=casper-node-launcher_0.2.0-0_amd64.deb
curl -JLO https://bintray.com/casperlabs/debian/download_file?file_path=casper-client_0.7.6-0_amd64.deb
sudo apt install -y ./casper-client_0.7.6-0_amd64.deb ./casper-node-launcher_0.2.0-0_amd64.deb

cd /etc/casper
sudo -u casper ./pull_casper_node_version.sh 1_0_0

# Get trusted_hash into config.toml
curl -s 18.144.176.168:8888/status | jq -r .last_added_block_info.hash
a1="$(curl -s 18.144.176.168:8888/status | jq -r .last_added_block_info.hash)"
sed -i 's/# trusted_hash =/trusted_hash = '"'$a1'"'/' /etc/casper/config.toml
sudo logrotate -f /etc/logrotate.d/casper-node
sudo /etc/casper/delete_local_db.sh; sleep 1
sudo systemctl stop casper-node-launcher
sudo systemctl start casper-node-launcher
sudo systemctl status casper-node-launcher
