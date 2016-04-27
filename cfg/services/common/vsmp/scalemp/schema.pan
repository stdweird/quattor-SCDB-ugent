declaration template common/vsmp/scalemp/schema;

type structure_vsmp_scalemp = {
    include structure_component

    'master' : string
    'slaves' : string[]
    'boards' : long[]
    'pxesuffixprefix' : string = 'vsmp'
};

bind '/software/components/vsmp' = structure_vsmp_scalemp;
