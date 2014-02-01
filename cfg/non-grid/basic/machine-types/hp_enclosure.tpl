unique template machine-types/hp_enclosure;

include {'machine-types/minimal'};
"/system/enclosure/type" = "blade";

function create_children_list = {
    base = ARGV[0];
    itemsperenclosure = ARGV[1];
    offset = ARGV[2];
    domain = ARGV[3];
    l = list();
    for (i=0; i< itemsperenclosure; i = i+1) {
    	n = offset + 1 + (base-1)*itemsperenclosure + i;
    	l[i] = format("node%03d.%s", n, domain);
    };
    return (l);
};
