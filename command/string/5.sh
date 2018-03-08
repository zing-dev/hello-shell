#!/usr/bin/env bash

STRING_A="abcd"
STRING_B="ab"
if [[ ${STRING_A/${STRING_B}//} == ${STRING_A} ]]
    then
        ## is not substring.
        echo N
else
        ## is substring.
        echo Y
fi

echo ${STRING_A/${STRING_B}}
echo ${STRING_A/${STRING_B}/}
echo ${STRING_A/${STRING_B}//}