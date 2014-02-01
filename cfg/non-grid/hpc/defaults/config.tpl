 
unique template defaults/config;

include { 'defaults/functions' };


# SECURITY LOCATIONS ------------------------------------------------------
# ------------------------------------------------------------------------- 



# SERVICE LOCATIONS -------------------------------------------------------
# ------------------------------------------------------------------------- 

# Computing element (gatekeeper) host.  Usually contains the site-level
# BDII.  This must be a fully qualified host name as a string.

variable CE_HOST ?= undef;


# COMPUTING ELEMENT PARAMETERS --------------------------------------------
# ------------------------------------------------------------------------- 

# Export the home areas as an NFS volume.
# This value is normally defined during VO configuration according to
# the contents of WN_SHARED_AREAS. Avoid explicit declaration, except if
# really required.
variable CE_SHARED_HOMES ?= undef;

# Configure SSH host based authentication between CE and WNs
# Normally, default (undef) should not be modified : it will determine the need
# for SSH from the NFS configuration.
# If true, force the configuration of SSH between CE and WNs.
# If false, prevent the configuration even if it seems required.
variable CE_USE_SHH ?= undef;

# Define batch system to use. Currently supported values are :
#   - torque1 : Torque v1 with MAUI
#   - torque2 : Torque v2 with MAUI
# Default is torque1 if CE_BATCH_SYS is defined to pbs (backward compatibility)
variable CE_BATCH_NAME ?= if ( exists(CE_BATCH_SYS) &&
                               is_defined(CE_BATCH_SYS) &&
                               ((CE_BATCH_SYS == "pbs") || (CE_BATCH_SYS == "lcgpbs")) ) {
                            return('torque2');
                          } else {
                            return(undef);
                          };                             


# Batch system and CE Job manager.
# For Torque must be 'pbs'.
variable CE_BATCH_SYS ?= if ( exists(CE_BATCH_NAME) &&
                              is_defined(CE_BATCH_NAME) &&
                              ( (CE_BATCH_NAME == 'torque') ||
                                (CE_BATCH_NAME == 'torque1') ||
                                (CE_BATCH_NAME == 'torque2') ) ) {
                           return('pbs');
                         } else {
                           return(undef);
                         };
variable CE_JM_TYPE ?= CE_BATCH_SYS;

# Used by several templates to trig install of Torque/MAUI components
# Should not be redefined in normal circumstances
variable CE_TORQUE ?= if ( exists(CE_BATCH_SYS) &&
                           is_defined(CE_BATCH_SYS) &&
                           ((CE_BATCH_SYS == "pbs") || (CE_BATCH_SYS == "lcgpbs")) ) {
                        return(true);
                      } else {
                        return(false);
                      };


# Alternate name of CE_HOST when WNs are in a private network
# Must match CE_HOST name on the private network
variable CE_PRIV_HOST ?= undef;

# CE_KEEP_RUNNING_QUEUES is a list of queues that must be kept running even 
# when draining/closing the CE.
variable CE_KEEP_RUNNING_QUEUES ?= list();
                                         
# NOTE; that the default configuration assumes that there is one
# queue per VO.  If you want to change this default, define the
# variable CE_QUEUES.  
# 
# This must contain an nlist with the vos value defined.  The
# vos key must contain a list with the names of the authorized
# VOs. 
#
# The CE_QUEUES variable may also contain an attributes key.  
# If defined it must contain an nlist with the specific queue
# attributes.  These will be merged with the values in 
# CE_QUEUE_DEFAULTS. 
# 
variable CE_QUEUES ?= nlist('names',list('all'));





# NFS DEFINITIONS -----------------------------------------------------------
# --------------------------------------------------------------------------- 

# NFS export ACL definition
# The following settings are used to enable NFS mount access from CE/WNs or other
# nodes. By default only CE and worker nodes are given access to NFS server.
# Several variables allow to customize the NFS export ACL :
#   - NFS_CE_HOSTS : list of CE hosts requiring access to NFS server (default is CE_HOST)
#   - NFS_WN_HOSTS : list of WN hosts requiring access to NFS server (default is WN_HOSTS)
#   - NFS_LOCAL_CLIENTS : list of other local hosts requiring access to NFS server
#
# Both of these variables can be a string, a list or a nlist. A string value is 
# interpreted as a list with one element. When specified as a list or string, the value must be a
# regexp matching name of nodes that must be given access to NFS server. The access right is the value
# of NFS_DEFAULT_RIGHTS. When specified as a nlist, the key must be an escaped regexp and the value is 
# the access rights.
#
# When possible, this is recommended to replace default value for NFS_WN_HOSTS by one or several regexps
# matching WN names.
# 

variable NFS_CE_HOSTS ?= if ( exists(SITE_CE_HOSTS) && is_defined(SITE_CE_HOSTS) ) {
                                return(SITE_CE_HOSTS);
                              } else {
                                return(CE_HOST);
                              };
variable NFS_WN_HOSTS ?= if ( exists(SITE_WN_HOSTS) && is_defined(SITE_WN_HOSTS) ) {
                                return(SITE_WN_HOSTS);
                              } else if ( exists(WORKER_NODES) && is_defined(WORKER_NODES) ) {
                                return(WORKER_NODES);
                              } else {
                                return(undef);
                              };
variable NFS_LOCAL_CLIENTS ?= if ( exists(LOCAL_NFS_CLIENT) && is_defined(LOCAL_NFS_CLIENT) ) {
                                return(LOCAL_NFS_CLIENT);
                              } else {
                                return(undef);
                              };
variable NFS_DEFAULT_RIGHTS ?= "(rw,no_root_squash)";

variable SITE_NFS_ACL  ?= {
  acl = list();
  host_lists = list(NFS_CE_HOSTS,NFS_WN_HOSTS,NFS_LOCAL_CLIENTS);
  foreach (i; v; host_lists) {
    if ( is_list(v) ) {
      foreach (j; regexp; v) {
        acl[length(acl)] = regexp + NFS_DEFAULT_RIGHTS;
      };
    } else if ( is_nlist(v) ) {
      foreach (regexp; rights; v) {
        acl[length(acl)] = unescape(regexp) + rights;
      };
    } else if ( is_defined(v) ) {
      acl[length(acl)] = v + NFS_DEFAULT_RIGHTS;
    };
  };
  if ( length(acl) == 0 ) {
    acl = undef;
  };
  return(acl);
};


# When NFS_AUTOFS is true, autofs is used to mount NFS filesystems
# rather than fstab. It is recommended to use autofs to avoid startup
# synchronization nightmares between NFS servers and clients...
# Default is false for backward compatibility
variable NFS_AUTOFS ?= false;


# Variable NFS_THREADS is used to configure a non default number of NFS
# threads on NFS servers. This is a nlist with 1 entry per NFS server node
# where an explicit number of threads must be defined. A host name present
# in the list but not used as a NFS server is just ignored.
#
# A typical example is :
# variable NFS_THREADS = nlist(
#    CE_HOST, 16,
#    SE_HOST_DEFAULT, 16,
# );
variable NFS_THREADS ?= undef;

# This variable, if true, prevents definition of EDG_WL_SCRATCH environment 
# variable to a local directory when /home is NFS mounted.
# It is strongly advised to keep this variable to false, as having
# EDG_WL_SCRATCH on a NFS area with a large number of workers can 
# result in significant performance penalty on WNs and NFS server.
variable WN_NFS_WL_SCRATCH ?= false;


# WN_SHARED_AREAs is a nlist containing 1 entry for each file system shared
# between CE and WNs. Generally the filesystem is shared by NFS but this is
# not required (can be AFS...). With NFS, the server is not required to be the CE,
# it can be any node (e.g. a dedicated NFS server) and the NFS server is not
# required to be managed by Quattor.
#
# On the CE, WNs and possibly NFS server if managed by Quattor, necessary actions
# will be undertaken to mount the file system as a server or client, depending
# on entry value. A node is considered a filesystem server if it is listed as
# the host in the entry value. This is evaluated filesystem per filesystem :
# there is no requirement to have the same server for all filesystems.
#
# For each NFS mount point, the associated value can be a host name (assume mount
# point is the same on server and client) or host:/path if the mount point on
# the server (/path) is different from the client (mount point).
# For non NFS mount pointsi or mount points not managed by NFS templates,
# the value must be 'undef'.
#
# Listing a shared filesystem, even if not managed by Quattor allows to
# the batch system to take advantage of the shared filesystem.
#
# Warning : Filesystem mount point must be escaped. 
#
# For backward compatibility, if WN_SHARED_AREAS is undefined :
#    - If WN_NFS_AREAS is defined, WN_NFS_AREAS is used.
#    - If CE_NFS_ENABLED (deprecated) is true, it is initialized with one
#      entry for /home using CE_HOST as NFS server.
#
variable WN_SHARED_AREAS ?= 
  if ( exists(WN_NFS_AREAS) && is_defined(WN_NFS_AREAS) ) {
    return(WN_NFS_AREAS);
  } else {
    if ( exists(CE_NFS_ENABLED) && is_defined(CE_NFS_ENABLED) && CE_NFS_ENABLED ) {    
      nlist(escape("/home"),CE_HOST);
    } else {
      return(undef);
    };
  };


# Variable NFS_MOUNT_OPTS is a nlist that can be used to specify specific
# mount options for a filesystem. Key must be the mount point escaped, as
# in WN_SHARED_AREAS
# variable NFS_MOUNT_OPTS = nlist();
                         


# WORKER NODE DEFINITIONS  --------------------------------------------------
# --------------------------------------------------------------------------- 

# WORKER_NODES must contain a list of fully qualified host names of all of the WNs
# on the CE. 
# From this list, a nlist is built to ease some configuration operations. 

variable WORKER_NODES ?= undef;
variable WORKER_NODES_NLIST = {
  if ( exists(WORKER_NODES) && is_defined(WORKER_NODES) && (length(WORKER_NODES) > 0 ) ) {
    foreach (i;wn;WORKER_NODES) {
      SELF[wn] = '';
    };
    return(SELF);
  } else {
    return(undef);
  };
};


# Define number of process slots per CPU.
# Should be 2 to accomodate MAUI SRs if using LAL configuration
# variable WN_CPU_SLOTS = 2;


# Define the number of CPU per machine.
# WN_CPUS_DEF defines default value, WN_CPUS lists exceptions
#variable WN_CPUS_DEF = 4;
#variable WN_CPUS = nlist(
#  "grid15."+SITE_DOMAIN, 2,
#  "grid16."+SITE_DOMAIN, 2,
#);


# Define specific attributes for all or some of the worker nodes
# To define an attribute that apply to each WN, use special entry DEFAULT.
# This can be used to force all nodes to drain.
# Each entry value must be a nlist.
#variable WN_ATTRS = nlist(
#  "DEFAULT",    nlist("state", "offline"),
#);

