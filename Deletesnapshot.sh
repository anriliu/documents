#!/bin/bash
#set -x
aws ec2  describe-snapshots  --query "Snapshots[?StartTime<=\`$(date +'%Y-%m-%d' -s '15 days ago')\`]" --output text >$(date +'%Y-%m-%d' -s '15 days ago')
aws ec2  describe-snapshots  --query "Snapshots[?StartTime>=\`$(date +'%Y-%m-%d' -s '30 days ago')\`]" --output text  >$(date +'%Y-%m-%d' -s '30 days ago')
cat $(date +'%Y-%m-%d' -s '15 days ago') $(date +'%Y-%m-%d' -s '30 days ago')|sort|uniq   -d > $(date +'%Y-%m-%d' -s '15 days ago')-$(date +'%Y-%m-%d' -s '30 days ago')
