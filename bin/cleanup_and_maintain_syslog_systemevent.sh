#!/bin/bash
####
# Deletes entries older than x days
# Optimize table afterwards.
####
# @since 2021-04-21
# @author stev leibelt <artodeto@bazzline.net>
####

function cleanup_and_maintain_syslog_systemevent ()
{
    #bo: variable declaration
    local DATABASE_NAME="Syslog"
    local DATABASE_TABLE="SystemEvents"
    local EXPECTED_CONFIGURATION_VERSION=1
    local PATH_OF_THE_CURRENT_SCRIPT_BASH=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd)

    #bin: executables, data: dynamic or static data files, source: templates or not executable no data files
    local PATH_TO_THE_LOCAL_CONFIGURATION_FILE="${PATH_OF_THE_CURRENT_SCRIPT_BASH}/../data/local_config.sh"

    if [[ -f "${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}" ]];
    then
        logger -i -p cron.debug ":: Sourcing configuration file >>${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}<<."
        source "${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}"

        if [[ ${CONFIGURATION_VERSION} -ne ${EXPECTED_CONFIGURATION_VERSION} ]];
        then
            logger -i -p cron.crit ":: Configuration version is wrong."
            logger -i -p cron.crit "   Expected >>${EXPECTED_CONFIGURATION_VERSION}<<, found >>${CONFIGURATION_VERSION}<<."

            echo ":: Configuration version is wrong."
            echo "   Expected >>${EXPECTED_CONFIGURATION_VERSION}<<, found >>${CONFIGURATION_VERSION}<<."

            return 2
        fi
    else
        logger -i -p cron.crit ":: Configuration file not found >>${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}<<!"

        echo ":: No configuration file available."
        echo "   No file in path >>${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}<<."

        return 1
    fi
    #eo: variable declaration

    #bo: cleanup
    logger -i -p cron.debug "bo: cleanup."
    logger -i -p cron.debug "   Using deletion limit of >>${NUMBER_OF_ENTRIES_TO_DELETE_PER_RUN}<<."

    local CURRENT_RUN_ITERATOR=1
    while [[ ${CURRENT_RUN_ITERATOR} -le ${NUMBER_OF_RUNS} ]];
    do
        logger -i -p cron.info "   Run ${CURRENT_RUN_ITERATOR} / ${NUMBER_OF_RUNS} started."
        mysql -u ${DATABASE_USER_NAME} -p${DATABASE_USER_PASSWORD} -e "DELETE FROM ${DATABASE_TABLE} WHERE ${DATABASE_TABLE}.DeviceReportedTime < date_add(current_date, interval - ${DAYS_TO_KEEP_IN_THE_PAST} day) LIMIT ${NUMBER_OF_ENTRIES_TO_DELETE_PER_RUN}" ${DATABASE_NAME}
        logger -i -p cron.info "   Run ${CURRENT_RUN_ITERATOR} / ${NUMBER_OF_RUNS} finished."
        ((++CURRENT_RUN_ITERATOR))
        sleep 10 #a few seconds does not harm us but helps the dbms to fetch some fresh air
    done
    logger -i -p cron.debug "eo: cleanup."
    #eo: cleanup

    #bo: maintenance
    logger -i -p cron.debug "bo: maintenance."
    #   check table health
    if [[ ${EXECUTE_DATABASE_CHECK} -eq 1 ]];
    then
        logger -i -p cron.notice "   Starting >>check<< for database >>${DATABASE_NAME} ${DATABASE_TABLE}<<"
        mysqlcheck -u ${DATABASE_USER_NAME} -p${DATABASE_USER_PASSWORD} --check --auto-repair ${DATABASE_NAME} ${DATABASE_TABLE}
    else
        logger -i -p cron.debug "   Skipping >>check<< for database."
    fi

    if [[ ${EXECUTE_DATABASE_OPTIMIZE} -eq 1 ]];
    then
        #   reclaim unused disk space
        logger -i -p cron.notice "   Starting >>optimize<< for database >>${DATABASE_NAME} ${DATABASE_TABLE}<<"
        mysqlcheck -u ${DATABASE_USER_NAME} -p${DATABASE_USER_PASSWORD} --optimize ${DATABASE_NAME} ${DATABASE_TABLE}
    else
        logger -i -p cron.debug "   Skipping >>optimize<< for database."
    fi

    if [[ ${EXECUTE_DATABASE_ANALYZE} -eq 1 ]];
    then
        #   rebuild and optimize indexes
        logger -i -p cron.notice "   Starting >>analyze<< for database >>${DATABASE_NAME} ${DATABASE_TABLE}<<"
        mysqlcheck -u ${DATABASE_USER_NAME} -p${DATABASE_USER_PASSWORD} --analyze ${DATABASE_NAME} ${DATABASE_TABLE}
    else
        logger -i -p cron.debug "   Skipping >>analyze<< for database."
    fi
    logger -i -p cron.debug "eo: maintenance."
    #eo: maintenance
}

cleanup_and_maintain_syslog_systemevent
