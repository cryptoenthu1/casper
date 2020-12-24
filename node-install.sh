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
