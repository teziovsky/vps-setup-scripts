# vps-setup-scripts

## Usage 🚀

`login as root`

```bash
sudo su -
```

`then run basic setup script`

```bash
source <(curl -s https://raw.githubusercontent.com/teziovsky/vps-setup-scripts/main/basic_setup.sh)
```

`then run security setup script`

```bash
. security_setup.sh
```

`if you want install tools, login to your new account and run`

```bash
cd /opt/vps-setup-scripts && ./tools_setup.sh
```
