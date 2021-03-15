# clean up previous version nodes
sudo systemctl stop casper-node-launcher.service

sudo rm -rf /etc/casper/1_0_0
sudo rm -rf /var/lib/casper/bin/1_0_0
sudo rm -rf /var/lib/casper/casper-node
sudo rm /etc/casper/casper-node-launcher-state.toml

sudo apt remove -y casper-client casper-node-launcher

cd ~
curl -JLO https://bintray.com/casperlabs/debian/download_file?file_path=casper-client_0.9.3-0_amd64.deb
curl -JLO https://bintray.com/casperlabs/debian/download_file?file_path=casper-node-launcher_0.3.1-0_amd64.deb

sudo apt install -y ./casper-client_0.9.3-0_amd64.deb ./casper-node-launcher_0.3.1-0_amd64.deb

sudo -u casper /etc/casper/pull_casper_node_version.sh 1_0_0 delta-11
sudo -u casper /etc/casper/config_from_example.sh 1_0_0

sudo logrotate -f /etc/logrotate.d/casper-node
cd casper-node
git fetch
git checkout release-0.7.6
make setup-rs && make build-client-contracts -j
cd ~
sudo systemctl start casper-node-launcher; sleep 2
curl -s localhost:8888/status | jq .build_version
systemctl status casper-node-launcher
