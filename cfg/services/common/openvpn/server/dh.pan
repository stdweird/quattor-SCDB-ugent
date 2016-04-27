@{
    Configures the download of the Diffie-Hellman parameters into muk.
}
unique template common/openvpn/server/dh;

# This one is usually the "external name"
final variable OPENVPN_DOWNLOAD_FILENAME ?= format("%s.ugent.be", HOSTNAME);

include 'common/download/service';

prefix "/software/components/download/files";

"{/etc/openvpn/keys/dh-4096.pem}" = create("common/download/auth",
                                           "href", "secure/dh-4096.pem",
                                           "perm", "0600");

"{/etc/openvpn/keys/ta.key}" = create("common/download/auth",
                                      "href", "secure/ta.key",
                                      "perm", "0600");
"{/etc/openvpn/keys/vpn.key}" = create("common/download/auth",
                                          "href",
                                          format("secure/%s.key",
                                                 OPENVPN_DOWNLOAD_FILENAME),
                                          "perm", "0600");
"{/etc/openvpn/keys/vpn.crt}" = create("common/download/auth",
                                       "href",
                                       format("secure/%s.crt",
                                              OPENVPN_DOWNLOAD_FILENAME),
                                       "perm", "0600");
