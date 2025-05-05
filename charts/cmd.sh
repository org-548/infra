#!/bin/bash

for i in "server-repo" "client-repo"; do
  aws ecr describe-images --repository-name $i --query 'sort_by(imageDetails,& imagePushedAt)[-1].imageTags[0]' | tr -d \" >> val-from-ecr.out
done
