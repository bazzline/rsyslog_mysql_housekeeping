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

## [Unreleased]

### Added

### Changed
