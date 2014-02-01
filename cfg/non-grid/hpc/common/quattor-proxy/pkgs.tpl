unique template common/quattor-proxy/pkgs;

variable SOFTWARE_SERVER ?= QUATTOR_SERVER;

prefix "/software/components/metaconfig/services/{/etc/nginx/nginx.conf}/contents";

"http/0" = merge(SELF, create("common/nginx/cache/base"));
"http/0/server" = {
    s = nlist();
    s["name"] = list(FULL_HOSTNAME);
    s["listen"]["addr"] = format("%s:8080", FULL_HOSTNAME);
    s["location"] = list();
    s["location"][0]["name"] = '^/\d+/.*repodata';
    s["location"][0]["operator"] = "~";
    s["location"][0]["proxy"] = create("common/quattor-proxy/pkg-cache",
                                       "pass", "http://packages");

    s["location"][1]["name"] = "repodata";
    s["location"][1]["operator"] = "~";
    s["location"][1]["proxy"] = create("common/quattor-proxy/pkg-cache",
                                       "pass", "http://packages",
                                       "cache", null);
    s["location"][2]["name"] = "/";
    s["location"][2]["proxy"] = create("common/quattor-proxy/pkg-cache",
                                       "pass", "http://packages");
    append(s);
};

"http/0/upstream/packages/host/0" = SOFTWARE_SERVER;

"/software/components/dirperm/paths" = append(
    nlist("path", "/var/cache/nginx",
          "type", "d",
          "owner", "root:root",
          "perm", "0755"));

"/software/components/dirperm/paths" = append(
    nlist("path", value("/software/components/metaconfig/services/{/etc/nginx/nginx.conf}/contents/http/0/proxy_cache_path/0/path"),
        "type", "d",
        "owner", "nginx:root",
        "perm", "0700"));
