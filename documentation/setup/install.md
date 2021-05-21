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

#if you run systemd
# you can to choose between on of the three shipped timers
systemctl enable weekly-rsyslog-housekeeping.timer
#_or
systemctl enable daily-rsyslog-housekeeping.timer
#_or
systemctl enable hourly-rsyslog-housekeeping.timer

#if you want to do housekeeping right away
screen
/opt/net.bazzline/rsyslog_mysql_housekeeping/bin/cleanup_and_maintain_syslog_systemevent.sh
```

The script creates a `systemd service file` and multiple [systemd timer files](source/) *if* systemd is installed.
If you want to create your own timer, please read [this](../knowledge_base/create_your_own_timer.md)
