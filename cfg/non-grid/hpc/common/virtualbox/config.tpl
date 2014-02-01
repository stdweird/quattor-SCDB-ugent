unique template common/virtualbox/config;

## disable the module. must be loaded through prologue/epilogue script
"/software/components/chkconfig/service/vboxdrv/off" = "";
"/software/components/chkconfig/service/vboxdrv/startstop" = true;

