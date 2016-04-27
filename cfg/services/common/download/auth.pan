@{
    Common parameters for authorised access to a server by ncm-download.
}
structure template common/download/auth;

"cacert" = value("/software/components/ccm/ca_file");
"cert" = value("/software/components/ccm/cert_file");
"key" =  value("/software/components/ccm/key_file");
"group" = "root";
"owner" = "root";
"perm" = "0644";
