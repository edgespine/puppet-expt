sudo apt-get -qq update
sudo apt-get -qq -y install ruby-dev unzip libvirt-dev libssl-dev libxml2-dev libssl-dev 
sudo apt-get -y -qq autoremove

echo "Installing Vault"

#sudo gem update --conservative
#sudo gem install beaker nokogiri-tools nokogiri
curl -s -o vault_0.9.5_linux_amd64.zip https://releases.hashicorp.com/vault/0.9.5/vault_0.9.5_linux_amd64.zip
curl -s -o vault_0.9.5_SHA256SUMS  https://releases.hashicorp.com/vault/0.9.5/vault_0.9.5_SHA256SUMS
grep linux_amd64 vault_*_SHA256SUMS | sha256sum -c -
unzip -o vault_0.9.5_linux_amd64.zip


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
sudo systemctl enable vault
sudo systemctl start vault

sudo systemctl status vault

export VAULT_ADDR=http://127.0.0.1:8200

cp vault /usr/local/bin/
vault --version
vault server -dev &
sudo vault operator init
vault write secret/hello fooo=worl ter=pio "tert tas"=lkjlk  a=b c=d
vault read -format=json secret/hello
