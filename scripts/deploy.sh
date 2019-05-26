#!/bin/sh

eval $(aws ecr get-login --no-include-email --region ap-northeast-1)
docker push $AWS_ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/qiitan/stg:latest

aws ecs run-task \
  --region ap-northeast-1\
  --cluster qiitan-cluster-stg \
  --task-definition qiitan-stg \
  --overrides file://run_task_db_migrate.json

./scripts/ecs-deploy --cluster qiitan-cluster-stg --service-name qiitan-service-stg --image $AWS_ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/qiitan/stg:latest --timeout 600