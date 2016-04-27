unique template common/download/service;
include 'components/download/config';
variable DOWNLOAD_SERVER ?= QUATTOR_SERVER;
variable DOWNLOAD_PORT ?= '446';
variable DOWNLOAD_PROTOCOL ?= 'https';
variable DOWNLOAD_USE_CERTS ?= true;
variable DOWNLOAD_USE_SINDES_CERTS ?= true;

'/software/components/download/server' = DOWNLOAD_SERVER+':'+DOWNLOAD_PORT;
'/software/components/download/proto' = DOWNLOAD_PROTOCOL;
include 'common/download/functions';
