unique template common/torque2/torque_cfg;

variable TORQUE_USE_QSUBSLEEP ?= true;
variable TORQUE_SUBMITFILTER ?= "/usr/bin/submitfilter";

variable TORQUECFG_CONTENT = {
    txt='';
    txt=txt+"SERVERHOST "+CE_SERVER_NAME+"\n";
    txt=txt+"QSUBHOST "+HOSTNAME+TORQUE_DOMAIN+"\n";
    if (TORQUE_USE_QSUBSLEEP) {
        txt=txt+"QSUBSLEEP 1\n";
    };
    txt=txt+"SUBMITFILTER "+TORQUE_SUBMITFILTER+"\n";
    txt;
};
'/software/components/filecopy/services' =
  npush(escape(TORQUE_HOME_SPOOL+"/torque.cfg"),
        nlist('config',TORQUECFG_CONTENT,
              'owner','root:root',
              'perms', '0644'));


