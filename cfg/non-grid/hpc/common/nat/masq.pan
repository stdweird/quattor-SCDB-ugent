unique template common/nat/masq;

include 'components/metaconfig/config';

bind "/software/components/metaconfig/services/{/etc/shorewall/masq}/contents" = string[]{};

prefix "/software/components/metaconfig/services/{/etc/shorewall/masq}";

"module" = "general";
"daemon/0" = "shorewall";
"contents" ?= nlist();

include if_exists('site/nat/masq');
