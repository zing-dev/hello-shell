#!/usr/bin/env bash

STRING_A="abc"
STRING_B="abv"
if [[ ${STRING_A/${STRING_B}//} == ${STRING_A} ]]
    then
        ## is not substring.
        echo N
    else
        ## is substring.
        echo Y
    fi