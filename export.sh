#!/bin/bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>log.out 2>&1
echo "pin_export export utility started...."
mkdir -p "$PIN_HOME"/sys/test/pin_export_files
cat pin_export.conf | sed -n 1'p' | tr ',' '\n' | while read word; do
	echo "copying $word"
	cp $word "$PIN_HOME"/sys/test/pin_export_files
 	echo " $word - file copied"
done
while IFS=$'\t' read -r -a myArray
do
	user=${myArray[1]}
	host=${myArray[2]}
	echo "username : $user"
	echo "hostname : $host"
done < pin_export.conf 
cd "$PIN_HOME"/sys/test
	tar -czvf "$PIN_HOME"/sys/test/pin_export_files/pin_export_files.tar.gz pin_export_files
	echo "Started the transferring files from PROD to FTP server"
	echo "transferring Started"
cd "$PIN_HOME"/sys/test/pin_export_files
 	scp pin_export_files.tar.gz $user@$host:/tmp
 	echo "transfer done"
cd "$PIN_HOME"/sys/test
#	rm -rf pin_export_files
