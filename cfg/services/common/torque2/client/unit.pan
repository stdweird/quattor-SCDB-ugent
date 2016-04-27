unique template common/torque2/client/unit;


prefix "/software/components/systemd/unit/pbs_mom.service/file";
"only" = true; # chkconfig is still used
"replace" = false;
"config/service" = dict(
    "LimitSTACK", -1,
    );

# crappy el7 rpms
"/software/components/systemd/unit/syslog/type" = "target";
prefix "/software/components/systemd/unit/syslog/file";
"only" = false;
"replace" = true;
"config/unit/Description" = "Dummy Syslog target for compatibility with broken unit files";
# Avoid that we conflict with shutdown.target, so that we can stay
# until the very end and do not cancel shutdown.target if we should
# happen to be activated very late.
"config/unit/DefaultDependencies" = false;
