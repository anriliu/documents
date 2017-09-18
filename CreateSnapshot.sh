#!/bin/bash
# Automatically create a snapshot every month
# date: 2016-4-5
# create by wangyong

set -x
#vols=`aws ec2 describe-instances --filters "Name=instance-state-code,Values=16" | grep VolumeId | cut -d : -f 2 | sed 's/\,//g'| sed 's/\"//g'`
vols=`aws ec2 describe-instances | grep VolumeId | cut -d : -f 2 | sed 's/\,//g'| sed 's/\"//g'`
date=`date +"%Y-%m-%d"`

for vol in $vols
do
        aws ec2 create-snapshot  --volume-id $vol --description $date" "$vol
done

