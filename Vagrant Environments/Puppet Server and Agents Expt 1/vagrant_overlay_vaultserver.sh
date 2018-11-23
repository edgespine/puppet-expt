
sudo curl -s -o puppet-release-xenial.deb https://apt.puppetlabs.com/puppet-release-xenial.deb
sudo dpkg -i puppet-release-xenial.deb
sudo apt-get -qq update
sudo apt-get -y -qq install puppet
sudo puppet agent --enable

sudo apt-get -qq update
sudo apt-get -qq -y install ruby-dev unzip libvirt-dev libssl-dev libxml2-dev libssl-dev 
sudo apt-get -y -qq autoremove

echo "Installing Vault"

#sudo gem update --conservative
#sudo gem install beaker nokogiri-tools nokogiri
curl -s -o consul_0.8.5_linux_amd64.zip https://releases.hashicorp.com/consul/0.8.5/consul_0.8.5_linux_amd64.zip
curl -s -o vault_0.9.5_linux_amd64.zip https://releases.hashicorp.com/vault/0.9.5/vault_0.9.5_linux_amd64.zip
curl -s -o vault_0.9.5_SHA256SUMS  https://releases.hashicorp.com/vault/0.9.5/vault_0.9.5_SHA256SUMS
grep linux_amd64 vault_*_SHA256SUMS | sha256sum -c -
unzip -o vault_0.9.5_linux_amd64.zip
unzip -o consul_0.8.5_linux_amd64.zip

mv -f vault consul /usr/local/bin/ 

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

mkdir -p /etc/vault
cat > /etc/vault/config.hcl <<VAULT
storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault/"
}

listener "tcp" {
 address     = 127.0.0.1:8200"
 tls_disable = 1
}

ui = true
VAULT

cat >  /etc/systemd/system/vault.service <<VAULTSYSTEMD
[Unit]
Description=Vault
Documentation=https://www.vault.io/

[Service]
ExecStart=/usr/local/bin/vault server -config=/etc/vault/config.hcl
ExecReload=/bin/kill -HUP $MAINPID
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
VAULTSYSTEMD




sudo systemctl daemon-reload
sudo systemctl enable consul
sudo systemctl enable vault
sudo systemctl start consul
sudo systemctl start vault

sudo systemctl status consul
sudo systemctl status vault


export VAULT_ADDR=http://127.0.0.1:8200

vault --version
sudo consul agent -dev &
vault server -dev &
sudo vault operator init
vault write secret/hello fooo=worl ter=pio "tert tas"=lkjlk  a=b c=d
vault read -format=json secret/hello
