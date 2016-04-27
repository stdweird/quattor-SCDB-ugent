structure template common/sysctl/struct/msg;

'kernel.msgmni' = '1024';
# Controls the maximum size of a message, in bytes
'kernel.msgmnb' = format('%s',64*1024);
# Controls the default maxmimum size of a message queue
'kernel.msgmax' = format('%s',64*1024);
