#!/bin/bash

BACKUP_DIR=/opt/middleware/tomcatB/tomcatB1/webapps

cd $BACKUP_DIR
Last_Backup_File=$(find . -type f -name "*.tgz" -printf "%p\n" | sort -n | tail -n 1)
Last_Backup_File_Size=$(du -sh $Last_Backup_File)

echo $Last_Backup_File_Size[opc@trainee-opb-pasindub-1 Shell-Scripts]$
