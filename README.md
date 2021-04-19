# Rsyslog mysql housekeeping script

Free as in freedom rsyslog mysql housekeeping script.

The current change log can be found [here](CHANGELOG.md).

The script removes entries older than `<configured value>` days from the database table `Syslog.SystemEvents`.

The script comes with an [install](install.sh)- and an [uninstall](uninstall.sh) routine.
All configurable values are configured close by.

# How to install

```
sudo su
mkdir -p /opt/net.bazzline/rsyslog_mysql_housekeeping
cd /opt/net.bazzline/rsyslog_mysql_housekeeping
git clone https://github.com/bazzline/rsyslog_mysql_housekeeping .
bash install.sh

#add user name, password and days
vim local_config.sh

systemctl enable weekly-rsyslog-housekeeping.timer

#if you want to do housekeeping right away
screen
systemctl start weekly-rsyslog-housekeeping.service
```

The script installs a [systemd service file](weekly-rsyslog-housekeeping.service.dist) and a [systemd timer file](weekly-rsyslog-housekeeping.timer) *if* systemd is installed.
