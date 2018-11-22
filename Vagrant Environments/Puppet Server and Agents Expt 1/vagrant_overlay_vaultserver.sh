
sudo wget https://apt.puppetlabs.com/puppet-release-xenial.deb
sudo dpkg -i puppet-release-xenial.deb
sudo apt-get update
sudo apt-get -y install puppet
sudo puppet agent --enable

sudo apt update
sudo apt -y install ruby-dev unzip libvirt-dev libssl-dev libxml2-dev libssl-dev consul
sudo apt -y autoremove

echo "Installing Vault"

#sudo gem update --conservative
#sudo gem install beaker nokogiri-tools nokogiri

wget https://releases.hashicorp.com/vault/0.9.5/vault_0.9.5_linux_amd64.zip
wget https://releases.hashicorp.com/vault/0.9.5/vault_0.9.5_SHA256SUMS
grep linux_amd64 vault_*_SHA256SUMS | sha256sum -c -
grep linux_amd64 vault_*_SHA256SUMS | sha256sum -c -
unzip -o vault_0.9.5_linux_amd64.zip
mv -f vault /usr/local/bin/ 
vault --version

export VAULT_ADDR=http://127.0.0.1:8200

sudo systemctl daemon-reload
sudo systemctl start consul
sudo systemctl enable consul
sudo systemctl start vault
sudo systemctl enable vault

sudo consul agent -dev
vault server -dev &

sudo vault operator init

vault write secret/hello fooo=worl ter=pio "tert tas"=lkjlk  a=b c=d
vault read -format=json secret/hello


cat > /etc/systemd/system/consul.service <<CONSULSYSTEMD
[Unit]
Description=Consul
Documentation=https://www.consul.io/

[Service]
ExecStart=/usr/bin/consul agent -server -ui -data-dir=/tmp/consul -bootstrap-expect=1 -node=vault -bind=10.0.0.17 -config-dir=/etc/consul.d/
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

