unique template defaults/functions;

# Function to merge new tags with existing, removing duplicates
# Accept a list of arguments that must be list of tags
# Must be assigned to a variable containing the list to update
function add_ce_runtime_env = {
  function_name = 'add_ce_runtime_env';
  if ( ARGC == 0 ) {
    error("Usage: "+function_name+"(tag_list[,tag_list...])");
  };

  tag_nlist = dict(); 
  if ( exists(SELF) ) {
    tag_list = SELF;
  };
  if ( exists(tag_list) && is_defined(tag_list) && is_list(tag_list) ) {
    ok = first(tag_list, i, v);
    while (ok) {
      tag_nlist[v] = '';
      ok = next(tag_list, i, v);
    };
  } else {
    tag_list = list();
  };
  
  arg_num = 0;
  while ( arg_num < ARGC ) {
    if ( is_list(ARGV[arg_num]) ) {
      new_tags_list = ARGV[arg_num];
    } else if ( is_string(ARGV[arg_num]) ) {
      new_tags_list = list(ARGV[arg_num]);
    } else if ( ! is_null(ARGV[arg_num]) ) {
      error(function_name+" : argument "+to_string(arg_num+1)+" must be a list or a string");
    };

    ok = first(new_tags_list, i, v);
    while (ok) {
      if ( !exists(tag_nlist[v]) ) {
        tag_nlist[v] = '';
      };
      ok = next(new_tags_list, i, v);
    };
    arg_num = arg_num + 1;
  };
  
  tag_list = list();
  ok = first(tag_nlist, k, v);
  while (ok) {
    tag_list[length(tag_list)] = k;
    ok = next(tag_nlist, k, v);
  };

  tag_list;
};
