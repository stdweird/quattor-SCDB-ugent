unique template common/sudo/config;

include { 'components/sudo/config' };

variable SUDO_USE_STD_CMND_ALIASES ?= false;
variable SUDO_REQUIRETTY ?= false;

## based on SL5.3 config
"/software/components/sudo" = {
    ca=nlist();
    ## command aliases
    ## Networking
    if (SUDO_USE_STD_CMND_ALIASES){
        ca['NETWORKING'] = list("/sbin/route", "/sbin/ifconfig", "/bin/ping", 
                                "/sbin/dhclient", "/usr/bin/net", "/sbin/iptables",
                                "/usr/bin/rfcomm", "/usr/bin/wvdial", "/sbin/iwconfig",
                                "/sbin/mii-tool",
                               );
        ## Installation and management of software
        ca['SOFTWARE'] = list("/bin/rpm", "/usr/bin/up2date", "/usr/bin/yum");
        ## Services
        ca['SERVICES'] = list("/sbin/service", "/sbin/chkconfig");
        ## Updating the locate database
        ca['LOCATE'] = list("/usr/sbin/updatedb");
        ## Storage
        ca['STORAGE'] = list("/sbin/fdisk", "/sbin/sfdisk", "/sbin/parted", 
                             "/sbin/partprobe", "/bin/mount", "/bin/umount",
                             );
        ## Delegating permissions
        ca['DELEGATING'] = list("/usr/sbin/visudo", "/bin/chown", "/bin/chmod", "/bin/chgrp"); 
        ## Processes
        ca['PROCESSES'] = list("/bin/nice", "/bin/kill", "/usr/bin/kill", "/usr/bin/killall");
        ## Drivers
        ca['DRIVERS'] = list("/sbin/modprobe");
    };
    ## generaloptions
    go=list();
    go[length(go)] = nlist("options",nlist("env_reset",true));
    if (SUDO_REQUIRETTY) {
        go[length(go)] = nlist("options",nlist("requiretty",SUDO_REQUIRETTY));
    };
    go[length(go)] = nlist("options",nlist("env_keep",
                                "\"COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR "+
                                "LS_COLORS MAIL PS1 PS2 QTDIR USERNAME "+
                                "LANG LC_ADDRESS LC_CTYPE LC_COLLATE LC_IDENTIFICATION "+
                                "LC_MEASUREMENT LC_MESSAGES LC_MONETARY LC_NAME LC_NUMERIC "+
                                "LC_PAPER LC_TELEPHONE LC_TIME LC_ALL LANGUAGE LINGUAS "+
                                "_XKB_CHARSET XAUTHORITY\""));

    
    ## priviliges
    p = nlist(
            "user","root",
            "run_as","ALL",
            "host","ALL",
            "cmd","ALL",
            #"options", "NOPASSWD:"
            );

    

    SELF["general_options"] = go;
    SELF["cmd_aliases"] = ca;
    SELF["privilege_lines"] = append(SELF["privilege_lines"], p);
    SELF;
};