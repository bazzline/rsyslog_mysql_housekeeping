# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Open]

### To Add

* Add support for server when mysql server is not on host `localhost`
* Add logging
    * `logger -i -p cron.notice <message>`
    * `logger -i -p cron.info <message>`
    * `logger -i -p cron.crit <message>`
    * available levels are `emerg`, `alert`, `crit`, `err`, `warning`, `notice`, `info` and `debug`
* Try to read `/etc/rsyslog.d/mysql.conf` to automatically configure or generate the config file.

### To Change

* Add a configurable Limit because of [this post](https://forums.mysql.com/read.php?20,264405,264433#msg-264433)
    * Maybe read the output of the deletion statement like described [here](https://www.pontikis.net/blog/store-mysql-result-to-array-from-bash), or [here](https://www.cloudsavvyit.com/1081/check-a-value-in-a-mysql-database-from-a-linux-bash-script/) and loop until deletion is 0 or less than 1000

## [Unreleased]

### Added

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
