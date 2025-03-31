#!/bin/bash

cd ./modules/ecr

if [ -d $1 ]; then
  rm -r ./$1
fi

git clone "https://github.com/tereza-arta/$1.git"

cd $1

aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin $2.dkr.ecr.$3.amazonaws.com

docker build -t $4 .

docker tag $4:$5 $2.dkr.ecr.$3.amazonaws.com/$4:$5

#docker push "$2.dkr.ecr.$3.amazonaws.com/$4:$5"
docker push $2.dkr.ecr.$3.amazonaws.com/$4:$5
