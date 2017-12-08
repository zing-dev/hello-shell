#! /bin/bash

function getdir(){
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]
        then 
            getdir $dir_or_file
        else
            # echo $dir_or_file
            file $dir_or_file | grep -v UTF-8 | awk -F: {'print $1'}
            #file dir_or_file
        fi  
    done
}
root_dir=`pwd`
getdir $root_dir
