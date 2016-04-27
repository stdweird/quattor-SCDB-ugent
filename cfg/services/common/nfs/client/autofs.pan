unique template common/nfs/client/autofs;


# ----------------------------------------------------------------------------
# Build an indirect map for all the specified NFS filesystems.
# An indirect map is used instead of a direct map because direct map
# support on Linux (as of SL3/4) is broken and disabled by default.
# The workaround is to use an indirect map mounted on a special mount
# point and define symlinks corresponding to user's view of mount point.
# ----------------------------------------------------------------------------
prefix "/software/packages";
"{autofs}" = dict();
"{nfs-utils}" = dict();
include 'components/autofs/config';
include 'components/symlink/config';
variable NFS_MAP_NAME ?= "quattor";
variable NFS_MAP_MOUNT_POINT = "/"+NFS_MAP_NAME+"_mnt";
variable NFS_DEFAULT_MOUNT_OPTTIONS ?= "rw";

## start here. this will overwrite any existing map for NFS_MAP_NAME
"/software/components/autofs/maps/" = {
    SELF[NFS_MAP_NAME] = dict();
    SELF[NFS_MAP_NAME]["mapname"] = "/etc/auto."+NFS_MAP_NAME;
    SELF[NFS_MAP_NAME]["type"] = "file";
    SELF[NFS_MAP_NAME]["options"] = "-"+NFS_DEFAULT_MOUNT_OPTTIONS+",hard";   # Mount hard
    SELF[NFS_MAP_NAME]["mountpoint"] = NFS_MAP_MOUNT_POINT;
    SELF[NFS_MAP_NAME]["preserve"] = false;
    SELF;
};

# If WNs are using a shared (NFS) filesystem for home areas
# or VO SW areas, mount them on the worker nodes.

variable NFS_MOUNT_POINTS = {
  mounts = dict();
  wn_mnts = undef;
  if ( exists(WN_SHARED_AREAS) && is_defined(WN_SHARED_AREAS) ) {
    if ( ! is_nlist(WN_SHARED_AREAS) ) {
      error("WN_SHARED_AREAS must be a nlist");
    };
    if ( length(WN_SHARED_AREAS) > 0 ) {
      wn_mnts = WN_SHARED_AREAS;
    };
  };

  if ( is_defined(wn_mnts) && length(wn_mnts) > 0 ) {
    ok = first(wn_mnts, e_mnt_point, mnt_path);
    while (ok) {
      # An undefined mnt_path means mount must not be handled by NFS templates
      if ( is_defined(mnt_path) ) {
        mnt_path_toks = matches(mnt_path, '^((?:[\w\-]+\.*)*):?((?:/[\w\.\-]*)*)');
        # No match
        if ( length(mnt_path_toks) == 0 ) {
          error('Invalid mount path ('+mnt_path+')');
        };
        mnt_host = mnt_path_toks[1];
        if ( mnt_host != FULL_HOSTNAME ) {
          # With indirect map, mount point in the map must be a relative path and
          # cannot contain any '/'. Thus the specified mount point must be rewritten.
          # Unfortunatly, PAN matches() doesn't support 'g' (global) option so a loop
          # is used to split the mount path. Else a pattern like '%(?:^|\G)(?:/)([\w\.\-]+)%g'
          # could have been used instead of the loop.
          mnt_point = '';
          autofs_mnt_point = '';
          mnt_point_toks = matches(unescape(e_mnt_point), '^(?:/)([\w\.\-]+)(.*)$');
          while ( length(mnt_point_toks) == 3 ) {
            if ( length(mnt_point) > 0 ) {
              mnt_point = mnt_point + "/";
              autofs_mnt_point = autofs_mnt_point + "__";
            };
            mnt_point = mnt_point + mnt_point_toks[1];
            autofs_mnt_point = autofs_mnt_point + mnt_point_toks[1];
            mnt_point_toks = matches(mnt_point_toks[2], '^(?:/)([\w\.\-]+)(.*)$');
          };
          if ( length(mnt_point) == 0 ) {
            error('Mount point must start with / ('+unescape(e_mnt_point)+')');
          };

          if ( (length(mnt_path_toks) < 3) || (length(mnt_path_toks[2]) == 0) ) {
            mnt_path = mnt_host + ':/' + mnt_point;
          };
          e_mnt_point = escape(mnt_point);
          if ( !exists(mounts[e_mnt_point]) || !is_defined(mounts[e_mnt_point]) ) {
            mounts[e_mnt_point]["location"] = mnt_path;
            mounts[e_mnt_point]["mntpoint"] = autofs_mnt_point;
            if ( exists(NFS_MOUNT_OPTS[e_mnt_point]) && is_defined(NFS_MOUNT_OPTS[e_mnt_point]) ) {
              mounts[e_mnt_point]["options"] = NFS_MOUNT_OPTS[e_mnt_point];
            } else {
              # ncm-autofs doesn't properly handle undefined options
              mounts[e_mnt_point]["options"] = '';
            };
          };
        };
      };
      ok = next(wn_mnts, e_mnt_point, mnt_path);
    };
  };

  if ( length(mounts) == 0 ) {
    mounts = null;
  };
  return(mounts);
};

"/software/components/autofs/maps/" ={

  mounts = NFS_MOUNT_POINTS;
  if ( !exists(mounts) || !is_defined(mounts) ) {
    return(null);
  };

  if ( !is_defined(SELF[NFS_MAP_NAME]["entries"]) || !is_nlist(SELF[NFS_MAP_NAME]["entries"]) ) {
    SELF[NFS_MAP_NAME]["entries"] = dict();
  };

  ok = first(mounts, e_mnt_point, mnt_params);
  while (ok) {
    # Indirect map mount points cannot contain /
    mnt_point = mnt_params["mntpoint"];
    delete(mnt_params["mntpoint"]);
    SELF[NFS_MAP_NAME]["entries"][escape(mnt_point)] = mnt_params;
    ok = next(mounts, e_mnt_point, mnt_params);
  };
  SELF;
};

"/software/components/autofs/maps/" = {
    if ( exists(SELF[NFS_MAP_NAME]["entries"]) &&
         length(SELF[NFS_MAP_NAME]["entries"]) > 0 ) {
      SELF[NFS_MAP_NAME]["enabled"] = true;
    } else {
      SELF[NFS_MAP_NAME]["enabled"] = false;
    };
    SELF;
};

# Define symlinks to actual mount point
"/software/components/symlink/" = {
  if ( !( is_defined(SELF['links']) && is_list(SELF['links']) ) ) {
    SELF['links'] = list();
  };

  if ( is_defined(NFS_MOUNT_POINTS) ) {
    foreach(e_mnt_point; mnt_params;NFS_MOUNT_POINTS) {
      link_index = length(SELF['links']);
      SELF['links'][link_index]["name"] = "/"+unescape(e_mnt_point);
      SELF['links'][link_index]["target"] = NFS_MAP_MOUNT_POINT+"/"+mnt_params["mntpoint"];
      SELF['links'][link_index]["exists"] = false;
      SELF['links'][link_index]["replace"] = dict("all","yes");
    };

  };
  SELF;
};


# When using autofs to mount directories, make sure that ncm-autofs
# is defined as pre dependency for ncm-accounts to avoid problems
# when creating home directories
variable AUTOFS_NEEDED = {
	if (exists(NFS_AUTOFS) && is_defined(NFS_AUTOFS) &&
	       NFS_AUTOFS && exists('/software/components/autofs/maps/'+NFS_MAP_NAME+'/enabled') &&
	       value('/software/components/autofs/maps/'+NFS_MAP_NAME+'/enabled')) {
		return(true);
	} else {
		 return(false);
	};
};
"/software/components/accounts/dependencies/" = {
	if ( ! ( is_defined(SELF['pre']) && is_list(SELF['pre']))) {
     	SELF['pre'] = list();
   	};
	if( AUTOFS_NEEDED ) {
		SELF['pre'][length(SELF['pre'])]="autofs";
	};
	SELF;
};
"/software/components/chkconfig/" = {
    if ( ! ( is_defined(SELF['service']) && is_nlist(SELF['service']))) {
        SELF['service'] = dict();
    };
   if( AUTOFS_NEEDED ) {
	SELF['service']["autofs"] = dict(
		"on","",
		"startstop",true,
		);
   };
   SELF;
};
