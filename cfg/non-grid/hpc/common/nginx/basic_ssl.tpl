structure template common/nginx/basic_ssl;

"options" = list("-OptRenegotiate", "+StrictRequire", "+StdEnvVars");
"active" = true;
"ciphersuite" = list("TLSv1");
"certificate" = value("/software/components/ccm/cert_file");
"key" = value("/software/components/ccm/key_file");
"ca" = value("/software/components/ccm/ca_file");
