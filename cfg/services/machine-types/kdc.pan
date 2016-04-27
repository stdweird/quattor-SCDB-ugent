unique template machine-types/kdc;

@{
    Machine type representing a mirror of RPM packages.
}

include 'machine-types/core';

include 'common/kdc/service';

include 'machine-types/post/core';
