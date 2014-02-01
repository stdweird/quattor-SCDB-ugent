@{
    RPMs for burning tests. CPU and disk for now.
}
unique template rpms/burning;

prefix "/software/packages";
"{cpuburn}" = nlist();
"{bonnie++}" = nlist();
"{iozone}" = nlist();