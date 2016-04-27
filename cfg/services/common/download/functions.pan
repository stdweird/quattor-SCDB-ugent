unique template common/download/functions;

function download_file = {
    ##
    ## Arg1 : destination filename
    ## Arg2 : relative path to download from
    ## Arg3 : optional, nlist with other attributes
    ##
    
    if (length (ARGV) == 2) {
        extra = dict(); 
    } else if (length (ARGV) == 3) {
    	##EXTRA ARGUMENTS GIVEN
    	if (is_nlist(ARGV[2])) {
            extra = ARGV[2];
        } else {
            error("download_file: 3rd arguments should be a nlist.")
        };
    } else {
       error ("function download_file expects minimum 2 arguments, 3rd one optional");
    };
    
    
    if (DOWNLOAD_USE_CERTS) {
    	if (DOWNLOAD_USE_SINDES_CERTS) {
    		#extra = merge('cacert','/etc/sindes/certs/ca-'+QUATTOR_SERVER+'.crt');
    		extra = merge(extra,dict('cacert','/etc/sindes/certs/ca-'+QUATTOR_SERVER+'.crt'));
    		extra = merge(extra,dict('cert','/etc/sindes/certs/client_cert.pem'));
    		extra = merge(extra,dict('key','/etc/sindes/certs/client_cert_key.pem'));
    	} else {
    		error("only use of SINDES certs implemented.");
    	};
    
    };
    
    ## real work
    return(dict(escape(ARGV[0]),merge(dict('href',ARGV[1]),extra))); 
};
