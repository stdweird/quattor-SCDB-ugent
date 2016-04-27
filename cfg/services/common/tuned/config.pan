unique template common/tuned/config;

variable TUNED_PROFILE ?= undef;

"/software/components/symlink/links" = append(dict(
        "name", "/etc/tuned.conf",
        "target", format("/usr/lib/tuned/%s/tuned.conf", TUNED_PROFILE),
        "exists", false,
        "replace", dict("all","yes"),
));
