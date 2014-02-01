unique template common/nat/hosts;

include 'components/metaconfig/config';

bind "/software/components/metaconfig/services/{/etc/shorewall/hosts}/contents" = string[]{};

prefix "/software/components/metaconfig/services/{/etc/shorewall/hosts}";

"module" = "general";
"daemon/0" = "shorewall";
"contents" ?= nlist();

include if_exists('site/nat/hosts');
