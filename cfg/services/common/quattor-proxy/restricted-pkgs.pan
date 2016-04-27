unique template common/quattor-proxy/restricted-pkgs;

variable RESTRICTED_SOFTWARE_SERVER ?= SOFTWARE_SERVER;

prefix "/software/components/metaconfig/services/{/etc/nginx/nginx.conf}/contents/http/0";

"server" = {
    s = dict();
    s["name"] = list(FULL_HOSTNAME);

    s["listen"]["addr"] = format("%s:8443", FULL_HOSTNAME);

    s["location"][0]["name"] = '^/\d+/.*repodata';
    s["location"][0]["operator"] = "~";
    s["location"][0]["proxy"] = create("common/quattor-proxy/pkg-cache",
        "pass", "https://restricted-packages");

    s["location"][1]["name"] = "repodata";
    s["location"][1]["operator"] = "~";
    s["location"][1]["proxy"] = create("common/quattor-proxy/pkg-cache",
        "pass", "https://restricted-packages",
        "cache", null);
    s["location"][2]["name"] = "/";
    s["location"][2]["proxy"] = create("common/quattor-proxy/pkg-cache",
        "pass", "https://restricted-packages");


    s["listen"]["ssl"] = true;
    s["ssl"] = create("common/nginx/basic_ssl", "options", null);
    s["ssl"]["verify_client"] = "none";

    append(s);
};

"upstream/restricted-packages/host/0" = format("%s:443",
                                               RESTRICTED_SOFTWARE_SERVER);
