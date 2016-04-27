unique template common/shibboleth/packages;

variable OS_REPOSITORY_LIST = {
    append('shibboleth');
};

prefix "/software/packages";

"{curl-openssl}" = dict();
"{libcurl-openssl}" = dict();
"{liblog4shib1}" = dict();


"{opensaml-bin}" = dict();
"{opensaml-schemas}" = dict();

"{shibboleth}" = dict();
"{shibboleth-embedded-ds}" = dict();

"{xml-security-c-bin}" = dict();

"{xmltooling-schemas}" = dict();

include { format('common/shibboleth/packages_el%s', RPM_BASE_FLAVOUR_VERSIONID); };
