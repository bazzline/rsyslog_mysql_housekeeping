# Rsyslog mysql housekeeping script

Free as in freedom rsyslog mysql housekeeping script.

The current change log can be found [here](CHANGELOG.md).

It all started with this question [>>How to automatically delete database contents?<<](https://www.rsyslog.com/article50/).

The script removes entries older than `<configured value>` days from the database table `Syslog.SystemEvents`.

The script comes with an [install](bin/install.sh)- and an [uninstall](bin/uninstall.sh) routine.
All configurable values are configured close by.

# How to install

```
sudo su
mkdir -p /opt/net.bazzline
cd /opt/net.bazzline
git clone https://github.com/bazzline/rsyslog_mysql_housekeeping
cd rsyslog_mysql_housekeeping
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
```

# Troubleshooting

## Long runtime

Execute following statement in your mysql shell.

```
SHOW ENGINE INNODB STATUS \G
```

The last few lines are containing the important messages with `25.21 inserts/s, 0.00 updates/s, 1137.62 deletes/s, 1139.97 reads/s` (as example).
Based on that number, you can do some calculation how long it will take.
