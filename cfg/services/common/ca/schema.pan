declaration template common/ca/schema;

type openssl_section_string = string with
    exists("/software/components/metaconfig/services/{/etc/sindes/ca.config}/contents/" +
	SELF);

type global_ca_section = {
    "default_ca" : openssl_section_string
};

type ca_section = {
    "dir" : string
    "certs": string
    "new_certs_dir" : string
    "database" : string
    "serial" : string
    "RANDFILE" : string
    "certificate" : string
    "private_key" : string
    "default_days" : long
    "default_crl_hours" : long = 1
    "default_md" : string
    "preserve" : string = "no" with match(SELF, "^(yes|no)$")
    "policy" : openssl_section_string
};

type ca_policy = {
    "organizationName" : string
    "organizationalUnitName" : string
    "commonName" : string = "supplied"
};

type req_section = {
    "default_bits" : long
    "distinguished_name" : string
    "attributes" : string
    "dirstring_type" : string = "nobmp"
    "prompt" : string = "no"
};

type openssl_file = extensible {
    "ca" : global_ca_section
    "req" : req_section
};

type ca_req_dn = {
    "O" : string
    "OU" : string
    "CN" : string
};

type ca_req_attrs = {
    "challengePassword" : string = "A challenge password"
};

type ca_gen_attrs = {
    "subjectKeyIdentifier" : string = "hash"
    "authorityKeyIdentifier" ? string
    "basicConstraints" : string = " CA:true"
};

type openssl_sindes_file = {
    include openssl_file
    "cluster_ca" : ca_section
    "policy_anything" : ca_policy
    "req_distinguished_name" : ca_req_dn
    "v3_ca" : ca_gen_attrs = dict()
    "req_attributes" : ca_req_attrs = dict()
};

bind "/software/components/metaconfig/services/{/etc/sindes/ca.config}/contents" = openssl_file;
