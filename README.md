# Rsyslog mysql housekeeping script

Free as in freedom rsyslog mysql housekeeping script.

The current change log can be found [here](CHANGELOG.md).

The script removes entries older than `<configured value>` days from the database table `Syslog.SystemEvents`.

The script comes with an [install](bin/install.sh)- and an [uninstall](bin/uninstall.sh) routine.
All configurable values are configured close by.

# How to install

```
sudo su
mkdir -p /opt/net.bazzline/rsyslog_mysql_housekeeping
cd /opt/net.bazzline/rsyslog_mysql_housekeeping
git clone https://github.com/bazzline/rsyslog_mysql_housekeeping .
bash bin/install.sh

#add user name, password and days
vim data/local_config.sh

systemctl enable weekly-rsyslog-housekeeping.timer

#if you want to do housekeeping right away
screen
systemctl start weekly-rsyslog-housekeeping.service
```

The script creates a `systemd service file` and a [systemd timer file](source/weekly-rsyslog-housekeeping.timer) *if* systemd is installed.

# Usage

```
cd /opt/net.bazzline/rsyslog_mysql_housekeeping

#if you just want to know the amount of entries in the table
#   plus the amount of entries that would be deleted.
bash bin/generate_statistics_of_syslog_systemevent.sh

#if you want to execute the housekeeping skript
bash bin/cleanup_and_maintain_syslog_systemevent.sh
