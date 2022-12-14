# Tasmockup

Automated backups for tasmota devices.

> *Tasmo*ta + Ba*ckup* = Tasmockup

**Tasmockup backs up your tasmota devices regularily and fully automated.** It relies on tasmota's [decode-config utility](https://github.com/tasmota/decode-config) to do so.
## Installation
Tasmockup is available as docker container. To run it, execute this command:

`docker run -t -i -e DEVICES="192.168.0.3;secret 192.168.0.4;secret2" gorootde/tasmockup` 

## Configuration
Config options for the docker container
### Environment variables
| Variable | Example | Description |
| -------- | ------- | ------- |
| `DEVICES` | `DEVICES="192.168.0.3;secret 192.168.0.4;secret2"` | Space separated list of devices to be backed up. Each device entry is in the format `<IP address>;<password>` |
| `CRON_EXPRESSION` | `CRON_EXPRESSION="0 0 * * *"` | Cron expression to trigger backups. Default is `0 0 * * *` which will backup your devices once a day. |

### Volumes
- `/data` - The volume where backups will be stored

## Backup format
Tasmockup backs up your tasmota devices using the `*.dmp` format. This will enable to directly restore a backup by uploading it to your tasmota device. Tasmockup will place all backups in a folder structure named based on the IP address of the device and the unix timestamp of the backup (e.g. `192.168.0.3/1669844709.dmp`).