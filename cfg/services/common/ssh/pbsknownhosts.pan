unique template common/ssh/pbsknownhosts;
include 'components/pbsknownhosts/config';
# Add CE explicitly as it is not a PBS node
"/software/components/pbsknownhosts/nodes" = CE_HOST_LIST;
"/software/components/pbsknownhosts/targets" = list("knownhosts");
