unique template common/gss/rpms/1.5/kernelUpdates;

variable OS_REPOSITORY_LIST = append("gss/kernelUpdates");

# nothing needed?
"/software/packages" = {
    SELF;
};
