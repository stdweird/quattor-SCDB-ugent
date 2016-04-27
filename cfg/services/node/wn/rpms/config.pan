unique template node/wn/rpms/config;

## any node specific rpms
# +RPM_BASE_FLAVOUR
variable WN_QT4X ?= true;
include {
    if(WN_QT4X) {
	'rpms/qt';
    };
};

variable WN_EXTRAS ?= true;

"/software/packages" = {
    SELF["chrpath"] = dict();
    SELF["sdparm"] = dict();
    SELF;
};
