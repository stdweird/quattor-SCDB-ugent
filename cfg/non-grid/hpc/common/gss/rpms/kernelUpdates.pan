unique template common/gss/rpms/kernelUpdates;

variable OS_REPOSITORY_LIST = append("gss/kernelUpdates");

# nothing needed?
"/software/packages" = {
    SELF;
};
