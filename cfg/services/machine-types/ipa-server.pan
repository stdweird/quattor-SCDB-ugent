unique template machine-types/ipa-server;

@{
    Machine type representing a mirror of RPM packages.
}

include 'machine-types/core';

include 'common/freeipa/server';

# change the nameserver to this machine first
# can it be installed with itself?
# for now, just disable named component, this is all IPA now 
"/software/components/named/active" = false;
"/software/components/named/servers" = {
    t=merge(list(DB_IP[HOSTNAME]), SELF);
    t;
};

include 'machine-types/post/core';
