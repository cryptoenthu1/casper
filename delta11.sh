sudo systemctl stop casper-node-launcher
sudo rm -rf /etc/casper/1_0_0
sudo rm -rf /var/lib/casper/bin/1_0_0

cd /etc/casper
sudo -u casper ./pull_casper_node_version.sh 1_0_0

sudo sed -i "/trusted_hash =/c\trusted_hash = '$(curl -s 13.57.181.239:8888/status | jq -r .last_added_block_info.hash | tr -d '\n')'" /etc/casper/1_0_0/config.toml

sudo logrotate -f /etc/logrotate.d/casper-node
sudo /etc/casper/delete_local_db.sh; sleep 1
sudo systemctl start casper-node-launcher
systemctl status casper-node-launcher
