#!/bin/bash
ftp -n<<!
open 104.207.157.17
user ftpwp wordpress.ftp.tob.
binary
lcd ~/Downloads
cd ~
prompt
mget themes.zip uploads.zip
close
bye
!