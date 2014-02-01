@{
    Machine type representing a trac server
}
unique template machine-types/trac-server;

include { 'machine-types/core' };

include { 'common/postgresql/service' };
include { 'common/trac/service' };

