#!/bin/bash
####
# Installs housekeeping scripts
####
# @since 2021-04-21
# @author stev leibelt <artodeto@bazzline.net>
####

function _install_rsyslog_housekeeping ()
{
    local PATH_OF_THE_CURRENT_SCRIPT_BASH=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd)

    if [[ -f ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/.is_installed ]];
    then
        echo ":: Installation already done."
        echo "   Please run >>${PATH_OF_THE_CURRENT_SCRIPT_BASH}/uninstall.sh<< if needed."

        return 1
    fi

    cp ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/local_config.sh.dist ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/local_config.sh

    echo ":: Please configure following file."
    echo "   >>${PATH_OF_THE_CURRENT_SCRIPT_BASH}/local.config.sh<<"
    echo ""

    if [[ -f /usr/bin/systemd ]];
    then
        local TEMPLATE_PATH_TO_THE_SCRIPT="${PATH_OF_THE_CURRENT_SCRIPT_BASH}/cleanup_and_maintain_syslog_systemevent.sh"

        cat > ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/weekly-rsyslog-housekeeping.service <<DELIM
[Unit]
Description=Weekly rsyslog mysql housekeeping
ConditionACPower=true
After=rsyslog.service

[Service]
Type=oneshot
ExecStart=${TEMPLATE_PATH_TO_THE_SCRIPT}
KillMode=process
TimeoutStopSec=21600
DELIM

        sudo cp ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/weekly-rsyslog-housekeeping.service /etc/systemd/system/weekly-rsyslog-housekeeping.service
        sudo cp ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/weekly-rsyslog-housekeeping.timer /etc/systemd/system/weekly-rsyslog-housekeeping.timer
        sudo systemctl daemon-reload

        echo ":: Please enable the time on your own."
        echo "   systemctl enable weekly-rsyslog-housekeeping.timer"
    fi

    echo "Installed at: $(date)" > ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/.is_installed
}

_install_rsyslog_housekeeping
