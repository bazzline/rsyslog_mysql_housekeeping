# Rsyslog mysql housekeeping script

Free as in freedom rsyslog mysql housekeeping script.

The current change log can be found [here](CHANGELOG.md).

The script removes entries older than `<configured value>` days from the database table `Syslog.SystemEvents`.

The script comes with an [install](install.sh)- and an [uninstall](uninstall.sh) routine.
All configurable values are configured close by.

The script installs a [systemd service file](weekly-rsyslog-housekeeping.service.dist) and a [systemd timer file](weekly-rsyslog-housekeeping.timer) *if* systemd is installed.
