unique template common/quattor-proxy/profiles;

prefix "/software/components/metaconfig/services/{/etc/nginx/nginx.conf}/contents/http/0";

"server/1/location" = {
    l = nlist();
    l["name"] = "/profiles";
    l["proxy"] = create("common/nginx/cache/location");
    l["proxy"]["pass"] = "https://profiles";
    l["proxy"]["cache"]["cache"] = "off";
    l["proxy"]["cache"]["valid"] = null;
    append(l);
    l = nlist();
    # Config for the muk init script
    l["name"] = format("/%s", CLUSTER_NAME);
    l["proxy"] = create("common/nginx/cache/location");
    l["proxy"]["pass"] = "https://profiles";
    # To be removed!!
    l["proxy"]["cache"]["cache"] = "off";
    l["proxy"]["cache"]["valid"] = null;
    append(l);
};

"server/1/ssl/verify_client" = "require";

"upstream/profiles/host/0" = format("%s:444", QUATTOR_SERVER);
