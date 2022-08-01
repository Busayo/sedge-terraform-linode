#!/bin/bash
sudo apt update
sudo apt upgrade
sudo apt install golang-go
go install github.com/NethermindEth/sedge/cmd/sedge@latest

