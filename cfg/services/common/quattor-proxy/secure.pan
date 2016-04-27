unique template common/quattor-proxy/secure;

prefix "/software/components/metaconfig/services/{/etc/nginx/nginx.conf}/contents/http/0";

"server/1/location" = {
    l = dict();
    l["name"] = "/(secure|share)";
    l["proxy"] = create("common/nginx/cache/location");
    l["proxy"]["pass"] = "https://secure";
    l["proxy"]["cache"]["cache"] = "cache";
    l["proxy"]["cache"]["valid"][0]["period"] = 10;
    l["operator"] = "~";
    prepend(l);
};

"upstream/secure/host/0" = format("%s:446", QUATTOR_SERVER);
