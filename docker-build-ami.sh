#!/bin/bash

if [ -z $AWS_ACCESS_KEY_ID ]; then echo 'env $AWS_ACCESS_KEY_ID not found' && exit; fi
if [ -z $AWS_SECRET_ACCESS_KEY ]; then echo 'env $AWS_SECRET_ACCESS_KEY not found' && exit; fi
if [ -z $AWS_REGION ]; then echo 'env $AWS_REGION not found' && exit; fi

docker build -t vyos-build-ami .
docker run \
  -v $(pwd):/build-ami/ \
  -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e AWS_DEFAULT_REGION=$AWS_REGION \
  --rm -it vyos-build-ami /bin/bash
