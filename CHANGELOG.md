# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Open]

### To Add

* Add support for server when mysql server is not on host `localhost`
* Try to read `/etc/rsyslog.d/mysql.conf` to automatically configure or generate the config file.

### To Change

* Refactore systemd timers or service file to pass in the current used configuration?
    * This way we could run a simple "every 15 minutes" cleanup job
    * And a once per week "optimize table" job
    * Think about if it even makes more sense to have two seperate services and timers?
* Add a configurable Limit because of [this post](https://forums.mysql.com/read.php?20,264405,264433#msg-264433)
    * Maybe read the output of the deletion statement like described [here](https://www.pontikis.net/blog/store-mysql-result-to-array-from-bash), or [here](https://www.cloudsavvyit.com/1081/check-a-value-in-a-mysql-database-from-a-linux-bash-script/) and loop until deletion is 0 or less than 1000

## [Unreleased]

### Added

### Changed

## [1.0.1](https://github.com/bazzline/rsyslog_mysql_housekeeping/tree/1.0.1) - released at 20210521

### Changed

* updated timers to use unit `rsyslog-housekeeping.service`
* renamed installed service file from `weekly-rsyslog-housekeeping.service` to `rsyslog-housekeeping.service`
* fixed systemd detection in install and uninstall scripts

## [1.0.0](https://github.com/bazzline/rsyslog_mysql_housekeeping/tree/1.0.0) - released at 20210426

### Added

* Added two different timers plus extended installation script
* Started [documentation](documentation) section
* Added logging
* Added `sleep 10` for every deletion round
* Added configuration values `CONFIGURATION_VERSION`, `EXECUTE_DATABASE_CHECK`, `EXECUTE_DATABASE_OPTIMIZE` and `EXECUTE_DATABASE_ANALYZE`
    * First value is used to handle different configuration versions
    * Other three values are used to fine control database table maintenance

### Changed

* Fixed major issue in `mysqlcheck` section
* Add `NUMBER_OF_ENTRIES_TO_DELETE_PER_RUN` to the configuration used as `LIMIT` because of [this post](https://forums.mysql.com/read.php?20,264405,264433#msg-264433)
    * This will stop having endless running processes
    * This will stop running into socket timeouts
* Added `NUMBER_OF_RUNS=10` to configuration to chunk the total process
* Moved `local_config.sh.dist` from [data](data) to [source](source)
* Changed usage of `mysqlcheck`, it now is working only on `Syslog`.`SystemEvents`, before it was working on the whole database `Syslog`

## [0.9.0](https://github.com/bazzline/rsyslog_mysql_housekeeping/tree/0.9.0) - released at 20210420

### Added

* initial release
