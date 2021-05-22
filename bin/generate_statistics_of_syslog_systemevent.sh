#!/bin/bash
####
# Fetchs and prints statistics for database table `Syslog.SystemEvents`
#   * Number of entries in total
#   * Number of possible deleted entries
####
# @since 2021-04-20
# @author stev leibelt <artodeto@bazzline.net>
####

function generate_statistics_of_syslog_systemevent ()
{
    #bo: variable declaration
    local DATABASE_NAME="Syslog"
    local DATABASE_TABLE="SystemEvents"
    local PATH_OF_THE_CURRENT_SCRIPT_BASH=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd)

    #bin: executables, data: dynamic or static data files, source: templates or not executable no data files
    local PATH_TO_THE_LOCAL_CONFIGURATION_FILE="${PATH_OF_THE_CURRENT_SCRIPT_BASH}/../data/local_config.sh"

    if [[ -f "${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}" ]];
    then
        source "${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}"
    else
        echo ":: No configuration file available."
        echo "   No file in path >>${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}<<."

        return 1
    fi
    #eo: variable declaration

    #bo: generate_statistic
    echo ":: Number of entries in total."
    mysql -u ${DATABASE_USER_NAME} -p${DATABASE_USER_PASSWORD} -e "SELECT COUNT(ID) FROM ${DATABASE_TABLE}" ${DATABASE_NAME}

    echo ""
    echo ":: Number of posible deleted entries."
    mysql -u ${DATABASE_USER_NAME} -p${DATABASE_USER_PASSWORD} -e "SELECT COUNT(ID) FROM ${DATABASE_TABLE} WHERE ${DATABASE_TABLE}.DeviceReportedTime < date_add(current_date, interval - ${DAYS_TO_KEEP_IN_THE_PAST} day)" ${DATABASE_NAME}
    #eo: generate_statistic
}

generate_statistics_of_syslog_systemevent
