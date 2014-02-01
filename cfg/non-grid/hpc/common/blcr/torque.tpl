unique template common/blcr/torque;

## contains torque specific settings to support blcr
variable BLCR_CHECKPOINT_SCRIPT = TORQUE_HOME_SPOOL+"/mom_priv/blcr_checkpoint_script";
variable BLCR_RESTART_SCRIPT = TORQUE_HOME_SPOOL+"/mom_priv/blcr_restart_script";
variable BLCR_CHECKPOINT_RUN_EXE = "/usr/bin/cr_run";
## interval (in minutes)
variable BLCR_CHECKPOINT_INTERVAL = 24*60;
variable BLCR_CHECKPOINT_DIR ?= null;

# needed in mon_priv/config
prefix "/software/components/pbsclient";
"checkpoint_script" = BLCR_CHECKPOINT_SCRIPT;
"restart_script" = BLCR_RESTART_SCRIPT;
"checkpoint_run_exe" = BLCR_CHECKPOINT_RUN_EXE;
"checkpoint_interval" = BLCR_CHECKPOINT_INTERVAL;
"remote_checkpoint_dirs" = BLCR_CHECKPOINT_DIR;


include { 'components/filecopy/config' };

#
# scripts taken from torque checkpoint wiki
#
"/software/packages"=pkg_repl("blcr-scripts-ugent","0.1-1",PKG_ARCH_DEFAULT);
