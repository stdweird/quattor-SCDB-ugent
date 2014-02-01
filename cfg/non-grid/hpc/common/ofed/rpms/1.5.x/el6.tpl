unique template common/ofed/rpms/1.5.x/el6;


prefix "/software/packages";
"{rdma}" = nlist();
"{infinipath-psm}"  = nlist();
"{infinipath-psm-devel}"  = nlist();

# fixes
"/software/components/symlink/links" = {
    append(nlist(
        "name", "/etc/udev/rules.d/60-ipath.rules",
        "target", "/etc/udev.d/60-ipath.rules",
        "exists", false,
        "replace", nlist("all","yes"),
    ));
};
