# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Open]

### To Add

* Try to read `/etc/rsyslog.d/mysql.conf` to automatically configure or generate the config file.
* Add support for server when mysql server is not on host `localhost`

### To Change

* Add a configurable Limit because of [this post](https://forums.mysql.com/read.php?20,264405,264433#msg-264433)
    * This will stop having endless running processes
    * Think about looping multiple times before running the optimize
    * Maybe read the output of the deletion statement like described [here](https://www.pontikis.net/blog/store-mysql-result-to-array-from-bash), or [here](https://www.cloudsavvyit.com/1081/check-a-value-in-a-mysql-database-from-a-linux-bash-script/)

## [Unreleased]

### Added

### Changed

* Add `NUMBER_OF_ENTRIES_TO_DELETE_PER_RUN` to the configuration used as `LIMIT` because of [this post](https://forums.mysql.com/read.php?20,264405,264433#msg-264433)
    * This will stop having endless running processes
    * This will stop running into socket timeouts
* Added `NUMBER_OF_RUNS=10` to configuration to chunk the total process
* moved `local_config.sh.dist` from [data](data) to [source](source)

## [0.9.0](https://github.com/bazzline/rsyslog_mysql_housekeeping/tree/0.9.0) - released at 20210420

### Added

* initial release
