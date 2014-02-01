unique template common/torque2/server_name;

'/software/components/filecopy/services' =
  npush(escape(TORQUE_HOME_SPOOL+"/server_name"),
        nlist('config',CE_SERVER_NAME,
              'owner','root:root',
              'perms', '0644'));


