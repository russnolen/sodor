#!/bin/bash

sudo apt-get update && apt-get upgrade -y 
sudo apt-get install -y build-essential git jq auditd

# Update Golang from 1.2 to 1.7 or compilation of go-audit will fail
wget https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz
tar -xvf go1.7.linux-amd64.tar.gz
sudo mv go /usr/local
mkdir ~/.go
export GOROOT=/usr/local/go
export GOPATH=~/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
sudo update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
sudo update-alternatives --set go /usr/local/go/bin/go

# Download go-audit and its dependencies
go get -u github.com/slackhq/go-audit
go get -u github.com/kardianos/govendor
cd ~/.go/src/github.com/slackhq/go-audit/
make
cp go-audit ~/
cp go-audit.yaml.example ~/go-audit.yaml
sudo systemctl stop auditd
