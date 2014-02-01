structure template common/ca/ca;

"ca/default_ca" = "cluster_ca";
"cluster_ca/dir" = "/var/sindes/CA/ca";
"cluster_ca/certs" = "/var/sindes/CA/ca";
"cluster_ca/new_certs_dir" = "/var/sindes/CA/ca/ca.db.certs";
"cluster_ca/database" = "/var/sindes/CA/ca/ca.db.index";
"cluster_ca/serial" = "/var/sindes/CA/ca/ca.db.serial";
"cluster_ca/RANDFILE" = "/var/sindes/CA/ca/ca.db.rand";
"cluster_ca/certificate" = "/etc/sindes/certs/ca.crt";
"cluster_ca/private_key" = "/etc/sindes/keys/ca.key";
"cluster_ca/default_days" = 3650;
"cluster_ca/default_crl_hours" = 1;
"cluster_ca/default_md" = "sha1";
"cluster_ca/preserve" = "no";
"cluster_ca/policy" = "policy_anything";


"policy_anything/organizationName" = "match";
"policy_anything/organizationalUnitName" = "match";
"policy_anything/commonName" = "supplied";

"req/default_bits" = 4096;
"req/distinguished_name" = "req_distinguished_name";
"req/attributes" = "req_attributes";
