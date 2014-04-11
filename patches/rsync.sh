#! /bin/bash
# Script for repo reset and sync 
# Have to be executed from Android root folder

export PATH=~/bin:$PATH

rootDir=$(pwd)
echo $rootDir

for p in $(find device/notionink/adam_3g/patches/ -name "*.diff")
        do
                patchname=$(basename $p | awk -F"." '{print $1}')
                echo -n "Git resetting hard for patch: "$patchname
		echo ""
                dir=$(echo ${patchname%'-'*} | tr _ /)
                echo "Repo to reset is: "$dir
                if [ -d $dir ]; then
			cd $dir
        	        git reset --hard >&1;
			cd $rootDir
                        if [ $? == 0 ]; then
                               	echo "     [RESET DONE]"
                        	        rm $patchname".p"
               	        else
       	                        echo "     [RESET FAILED]"
                        fi

                 else
                        echo "ERROR: Dir where patch should be applied doesn't exists. Please check patch name format. It should be dir_dir_dir-patchname.diff"
                 fi
                echo ""
        done

cd $rootDir
echo "Start repo sync"
repo sync
