/interface/bridge/add name=dockers
/ip/address/add address=172.17.0.254/24 interface=dockers

/interface/veth/add name=veth3 address=172.17.0.3/24 gateway=172.17.0.254
/interface/bridge/port add bridge=dockers interface=veth3

/container/config/set registry-url=https://registry-1.docker.io tmpdir=disk1/pull

/container/add dns=172.17.0.254 remote-image=elicro/ipcalc:latest interface=veth3 root-dir=disk1/ipcalc  start-on-boot=yes
