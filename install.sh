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
        sed -e "s/TEMPLATE_PATH_TO_THE_SCRIPT/${PATH_OF_THE_CURRENT_SCRIPT_BASH}/cleanup_and_maintain_syslog_systemevent.sh/" ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/weekly-rsyslog-housekeeping.sevice.dist > ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/weekly-rsyslog-housekeeping.service

        sudo ln -s ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/weekly-rsyslog-housekeeping.service /usr/lib/systemd/weekly-rsyslog-housekeeping.service
        sudo ln -s ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/weekly-rsyslog-housekeeping.timer /usr/lib/systemd/weekly-rsyslog-housekeeping.timer
        sudo systemctl daemon-reload
        sudo systemctl enable weekly-rsyslog-housekeeping.timer
    fi

    echo "Installed at: $(date)" > ${PATH_OF_THE_CURRENT_SCRIPT_BASH}/.is_installed
}

_install_rsyslog_housekeeping
