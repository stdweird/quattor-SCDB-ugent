@{
    Machine type representing a build server
}
unique template machine-types/build-server;

include 'machine-types/core';

include 'common/build/service';

include 'machine-types/post/core';
