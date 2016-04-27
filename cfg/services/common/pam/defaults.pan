unique template common/pam/defaults;

## defined all pam services that are supposed to be defined

## this is a very extensive list from SL5.4
variable PAM_DEFAULT_SERVICES ?= list(
    "atd","authconfig","authconfig-gtk","authconfig-tui",
    "chfn","chsh","config-util","crond","cups","cvs",
    "dateconfig","eject","ekshell","gdm","gdm-autologin",
    "gdmsetup","gssftp","halt","hwbrowser","kbdrate",
    "kcheckpass","kdm","kdm-np","kscreensaver","kshell",
    "ksu","login","neat","newrole","other","passwd",
    "pirut","pm-hibernate","pm-powersave","pm-suspend",
    "pm-suspend-hybrid","poweroff","ppp","pup","quagga",
    "radiusd","reboot","remote","run_init","runuser",
    "runuser-l","screen","serviceconf","setup","smtp",
    "smtp.postfix","smtp.sendmail","sshd","su","sudo",
    "sudo-i","su-l","system-auth","system-auth-ac",
    "system-cdinstall-helper","system-config-authentication",
    "system-config-date","system-config-display",
    "system-config-keyboard","system-config-language",
    "system-config-network","system-config-network-cmd",
    "system-config-printer","system-config-securitylevel",
    "system-config-selinux","system-config-services",
    "system-config-soundcard","system-config-time",
    "system-config-users","system-install-packages",
    "vlock","wbem","wireshark","xdm","xserver"
);

# declare what services we expect to already exist
"/software/components/pam" = {
    if(!is_defined(SELF['services'])) {
        SELF['services'] = dict();
    };
    foreach(i;n;PAM_DEFAULT_SERVICES) { 
        SELF['services'][n] = dict("predefined", true);
    };
    SELF;
};
