unique template common/nagios/checks/hw-inventory;

variable CHECK_NAME = "check_hw_inventory";
variable SCRIPT_NAME = "check_hardware_inventory.py";

variable HW_BIOS_VERSION ?= value("/hardware/bios/version");
variable HW_BIOS_RELEASE_DATE ?= value("/hardware/bios/releasedate");
variable HW_DIMM_AMOUNT ?= to_string(length(value("/hardware/ram")));
variable HW_DIMM_SIZE ?= to_string(value("/hardware/ram/0/size"));
variable HW_CPU_CORES_PER_SOCKET ?= to_string(value("/hardware/cpu/0/cores"));
variable HW_CPU_SOCKETS ?= to_string(length(value("/hardware/cpu")));

'/software/components/nrpe/options/command' = npush(CHECK_NAME,"sudo " + CHECKS_LOCATION+"restricted/"+CHECK_NAME + " --biosversion=" + HW_BIOS_VERSION  + " -r " +  HW_BIOS_RELEASE_DATE + " -i " + HW_DIMM_AMOUNT + " -s " +  HW_DIMM_SIZE  + " -c " +  HW_CPU_CORES_PER_SOCKET  + " -S " + HW_CPU_SOCKETS  );

"/software/components/symlink/links" =
        push(dict(
                "name", CHECKS_LOCATION+"restricted/"+CHECK_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", dict("all","yes"),
                )
        );
