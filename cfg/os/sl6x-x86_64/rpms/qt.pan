unique template rpms/qt;

prefix "/software/packages";

"{qt}" = nlist();
"{qt-devel}" = nlist();
"{qt-sqlite}" = nlist();

# Yum find weird conflicts otherwise
"/system/aii/osinstall/ks/base_packages" = append("qt-devel");
