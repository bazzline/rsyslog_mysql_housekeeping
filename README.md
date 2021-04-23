# Rsyslog mysql housekeeping script

Free as in freedom rsyslog mysql housekeeping script.

The current change log can be found [here](CHANGELOG.md).

The current documentation can be found [here](documentation).

It all started with this question [>>How to automatically delete database contents?<<](https://www.rsyslog.com/article50/).

The script removes entries older than `<configured value>` days from the database table `Syslog.SystemEvents`.

The script comes with an [install](bin/install.sh)- and an [uninstall](bin/uninstall.sh) routine.
All configurable values are configured in `project_path/data/local_configuration.sh`.
