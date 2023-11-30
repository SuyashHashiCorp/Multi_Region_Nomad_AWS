#!/usr/bin/env bash

#Change Hostname
sudo hostnamectl set-hostname "nomad-server-emea-dc2"

export DEBIAN_FRONTEND=noninteractive

#Pre-reqs
apt-get update
apt-get install -y zip unzip wget apt-transport-https jq tree gnupg-agent net-tools

#Install nomad manually
export NOMAD_SER_VERSION="1.6.3+ent"
curl --silent --remote-name https://releases.hashicorp.com/nomad/${NOMAD_SER_VERSION}/nomad_${NOMAD_SER_VERSION}_linux_amd64.zip
unzip nomad_${NOMAD_SER_VERSION}_linux_amd64.zip
rm -rf TermsOfEvaluation.txt EULA.txt
sudo chown root:root nomad
sudo mv nomad /usr/bin/

#Create directories
mkdir -p /opt/nomad
mkdir -p /etc/nomad.d
chmod 755 /opt/nomad
chmod 755 /etc/nomad.d

##Nomad Service File Configuration
cat <<EOF > /etc/systemd/system/nomad.service
[Unit]
Description=Nomad
Documentation=https://nomadproject.io/docs/
Wants=network-online.target
After=network-online.target

[Service]
ExecReload=/bin/kill -s HUP \$MAINPID
ExecStart=/usr/bin/nomad agent -config /etc/nomad.d/ -bind=0.0.0.0
KillMode=process
KillSignal=SIGINT
LimitNOFILE=infinity
LimitNPROC=infinity
Restart=on-failure
RestartSec=2
StartLimitBurst=3
StartLimitIntervalSec=10
TasksMax=infinity

[Install]
WantedBy=multi-user.target
EOF

#Nomad Configuration
cat <<EOF > /etc/nomad.d/server.hcl
name = "emea-nomad-server"
region = "emea"
datacenter = "dc2"
data_dir = "/opt/nomad"
enable_debug = true

server {
    enabled = true
    bootstrap_expect = 1
    license_path = "/etc/nomad.d/license.hclic"
    authoritative_region = "ind"
    server_join {
      retry_join = ["10.0.1.34", "10.0.1.24:4648"]
    }
    raft_protocol = 3
}

addresses {
    http = "{{ GetDefaultInterfaces | attr \"address\" }}"  rpc  = "{{ GetAllInterfaces | include \"network\" \"10.0.1.0/24\" | attr \"address\" }}"  serf = "{{ GetAllInterfaces | include \"network\" \"10.0.1.0/24\" | attr \"address\" }}"
}

ports {
    http = 4646
    rpc = 4647
    serf = 4648
}

acl {
  enabled = true
  replication_token = "<put replication token from authoritative region>"
}

EOF


#Writing License File
cat <<EOF > /etc/nomad.d/license.hclic
<put your license here>
EOF

sudo systemctl enable nomad
sudo systemctl start nomad

#Environment Variable Set
cat <<EOF > /etc/profile.d/nomad-bash-env.sh
export NOMAD_ADDR=http://10.0.1.34:4646
nomad -autocomplete-install
complete -C /usr/bin/nomad nomad
EOF
