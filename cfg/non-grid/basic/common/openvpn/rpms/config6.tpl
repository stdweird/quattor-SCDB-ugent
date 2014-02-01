unique template common/openvpn/rpms/config6;

variable PKG_ARCH_OPENVPN ?= PKG_ARCH_DEFAULT;

"/software/packages"=pkg_repl("openvpn","2.2.2-1.el6",PKG_ARCH_OPENVPN);
"/software/packages"=pkg_repl("pkcs11-helper","1.07-5.el6", PKG_ARCH_OPENVPN);
"/software/packages"=pkg_repl("lzo", "2.06-1.el6.rfx",PKG_ARCH_OPENVPN);
