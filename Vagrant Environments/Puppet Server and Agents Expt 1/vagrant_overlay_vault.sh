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

mkdir -p /var/lib/vault
mkdir -p /etc/vault


sudo useradd -r -d /var/lib/vault -s /bin/nologin vault
sudo install vault /usr/local/bin -o vault -g vault -m 750 
sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault
sudo groupadd pki

sudo gpasswd -a vault pki

echo 127.0.0.1 example.com | sudo tee -a /etc/hosts

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

cat > /etc/vault/server.pem <<VAULT
-----BEGIN CERTIFICATE-----
MIICQTCCAaoCCQDKkLdYLDMVzzANBgkqhkiG9w0BAQsFADBlMQswCQYDVQQGEwJV
SzEPMA0GA1UECAwGTE9ORE9OMQ8wDQYDVQQHDAZMb25kb24xDDAKBgNVBAoMA0lD
VDEQMA4GA1UECwwHVGVjaE9wczEUMBIGA1UEAwwLZXhhbXBsZS5jb20wHhcNMTgx
MTI2MTIyMDM4WhcNMTkxMTI2MTIyMDM4WjBlMQswCQYDVQQGEwJVSzEPMA0GA1UE
CAwGTE9ORE9OMQ8wDQYDVQQHDAZMb25kb24xDDAKBgNVBAoMA0lDVDEQMA4GA1UE
CwwHVGVjaE9wczEUMBIGA1UEAwwLZXhhbXBsZS5jb20wgZ8wDQYJKoZIhvcNAQEB
BQADgY0AMIGJAoGBANKcDVMOzWhcAUnNbcueJHsApi4ucTexe6G4SO00CxyB9U9L
E/Uh1MtYdiNaZBM71FPQz0Qtqmac2C8kBuWyWM3y9OAMEUkge3CQVG/dWpdIqKua
R2qYuO9HiMrz/CtXWwPZ02NZ6Ps/pmeCF3kamnXq03kcEKvk4qOzSQWqNF2XAgMB
AAEwDQYJKoZIhvcNAQELBQADgYEAwwJkmtcfqfiDQXk38DFbcW1SdF8WPQSuwV6g
tkQTu4vG17L2gAE1SWJrW4RIXdbGwoRtshSJM4OnHPOcek3EWlIypuu4xi+CDCnc
sDN1tVQFF4xaQbDlkuFbNQC6B6ammMSGObIep40Uifn8wR5KVVy7BLxnX1ORSjlD
UqUx4Bo=
-----END CERTIFICATE-----
-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQDSnA1TDs1oXAFJzW3LniR7AKYuLnE3sXuhuEjtNAscgfVPSxP1
IdTLWHYjWmQTO9RT0M9ELapmnNgvJAblsljN8vTgDBFJIHtwkFRv3VqXSKirmkdq
mLjvR4jK8/wrV1sD2dNjWej7P6Znghd5Gpp16tN5HBCr5OKjs0kFqjRdlwIDAQAB
AoGBAM910xZHFYXAY7B8gLQ7wnm7yPbi3rnaxgsmygeG5Y8eYTPLpAwrWD86k5z9
lGjx3ZT2ssTZKurLg5TkKzsmtJvZSvADlCkEW3U8kCsPvU5fWQ7g0GFEgvfhQH9/
IIQEXGoHECOF2IYrzDb7pNAnrPBw6Ubi8CgLkVcNsvWognPRAkEA6Mzr2PfeMUBv
+t2Va+YrhQ0MJsFHM6WeOFklnjKHnad1IrxtA3kSOnFmDrmDACIdPOGCTcIMcWYv
OkFdC7emOQJBAOeZAj1GJ2uF2TfmpFKT+VFI/z79/KP6o0pv2yPs8Zeau2Nz81wQ
Ya5RVgLjBCKkgW/2NTzYTPpd4e+aF0AYok8CQQC87HhFxrnBnHqDyskVHGCbBECl
PtsKldA2CFqX7IfUMG7F9sY9OEbLuPVK48/lDspNevDlK6IvcO7Ixvy8opg5AkEA
kZLBr5YrLRDDCro0y5sreYZyujuX09K1VRKeIiTLbsnZw5ecfl/lplaFw+bCMKxK
l/+gUxB6wlzEqYCn4KgbTQJAUct6Sn1u6FeLOqX43xxi3xGY+LOC3QS8EN9XL1Mg
UBeiyHaDFd1auIIu1OTsTuSsfwdrF+EYJ6Bfz0SB/QFm4g==
-----END RSA PRIVATE KEY-----
VAULT

cat > /etc/vault/vault.hcl <<VAULT
backend "file" {
        path = "/var/lib/vault"
}

listener "tcp" {
        tls_disable = 0
        tls_cert_file = "/etc/vault/server.pem"
        tls_key_file = "/etc/vault/server.pem"
}
VAULT

cat >  /etc/systemd/system/vault.service <<VAULTSYSTEMD
[Unit]
Description=a tool for managing secrets
Documentation=https://vaultproject.io/docs/
After=network.target
ConditionFileNotEmpty=/etc/vault/vault.hcl

[Service]
User=vault
Group=vault
ExecStart=/usr/local/bin/vault server -config=/etc/vault/vault.hcl
ExecReload=/usr/local/bin/kill --signal HUP $MAINPID
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
Capabilities=CAP_IPC_LOCK+ep
SecureBits=keep-caps
NoNewPrivileges=yes
KillSignal=SIGINT

[Install]
WantedBy=multi-user.target
VAULTSYSTEMD

sudo chgrp pki /etc/vault/server.pem
sudo chmod g+r /etc/vault/server.pem
sudo chown vault:vault /etc/vault/vault.hcl 
sudo chmod 640 /etc/vault/vault.hcl 
sudo chmod 640 /etc/vault/server.pem 

export VAULT_ADDR=http://127.0.0.1:8200

sudo systemctl daemon-reload
sudo systemctl enable vault
sudo systemctl start vault

sudo systemctl status vault

exit
#cp vault /usr/local/bin/
#vault --version
#vault server -dev &
#sudo vault operator init
vault write secret/hello fooo=worl ter=pio "tert tas"=lkjlk  a=b c=d
vault read -format=json secret/hello
