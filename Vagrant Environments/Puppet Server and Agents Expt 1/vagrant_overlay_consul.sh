
#ifubuntu1804
sudo apt-get -qq update
sudo apt-get -qq -y install ruby-dev unzip libvirt-dev libssl-dev libxml2-dev libssl-dev 
sudo apt-get -y -qq autoremove
#else
sudo yum install -y 

echo "Installing Consul"

#sudo gem update --conservative
#sudo gem install beaker nokogiri-tools nokogiri
curl -s -o consul_0.8.5_linux_amd64.zip https://releases.hashicorp.com/consul/0.8.5/consul_0.8.5_linux_amd64.zip
unzip -o consul_0.8.5_linux_amd64.zip

mv -f consul /usr/local/bin/ 

cat > /etc/systemd/system/consul.service <<CONSULSYSTEMD
[Unit]
Description=Consul
Documentation=https://www.consul.io/

[Service]
ExecStart=/usr/local/bin/consul agent -server -ui -data-dir=/tmp/consul -bootstrap-expect=1 -node=vault -bind=10.0.0.17 -config-dir=/etc/consul.d/
ExecReload=/bin/kill -HUP $MAINPID
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
CONSULSYSTEMD

mkdir -p /etc/consul.d
cat > /etc/consul.d/ui.json <<CONSULCONIFG
{
  "addresses": {
    "http": "0.0.0.0"
  }
}
CONSULCONIFG
sudo systemctl daemon-reload
sudo systemctl enable consul
sudo systemctl start consul

sudo systemctl status consul


sudo consul agent -dev &
