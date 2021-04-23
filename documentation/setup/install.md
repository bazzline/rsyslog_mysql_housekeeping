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
