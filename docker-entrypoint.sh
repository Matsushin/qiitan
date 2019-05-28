#!/usr/bin/env bash

set -e

PARAMETER_STORE_PREFIX=${PARAMETER_STORE_PREFIX:-}

if [ -n "$PARAMETER_STORE_PREFIX" ]; then
    export DATABASE_USERNAME=$(aws ssm get-parameters --name /qiitan/stg/db_user --with-decryption --query "Parameters[0].Value" --region ap-northeast-1 --output text)
    export DATABASE_PASSWORD=$(aws ssm get-parameters --name /qiitan/stg/db_password --with-decryption --query "Parameters[0].Value" --region ap-northeast-1 --output text)
    export DATABASE_HOSTNAME=$(aws ssm get-parameters --name /qiitan/stg/db_host --with-decryption --query "Parameters[0].Value" --region ap-northeast-1 --output text)
    export SECRET_KEY_BASE=$(aws ssm get-parameters --name /qiitan/stg/SECRET_KEY_BASE --with-decryption --query "Parameters[0].Value" --region ap-northeast-1 --output text)
    export SENDGRID_USERNAME=$(aws ssm get-parameters --name /qiitan/stg/SENDGRID_USERNAME --with-decryption --query "Parameters[0].Value" --region ap-northeast-1 --output text)
    export SENDGRID_PASSWORD=$(aws ssm get-parameters --name /qiitan/stg/SENDGRID_PASSWORD --with-decryption --query "Parameters[0].Value" --region ap-northeast-1 --output text)
    export AWS_ACCESS_KEY_ID=$(aws ssm get-parameters --name /qiitan/stg/aws_access_key_id --with-decryption --query "Parameters[0].Value" --region ap-northeast-1 --output text)
    export AWS_SECRET_ACCESS_KEY=$(aws ssm get-parameters --name /qiitan/stg/aws_secret_access_key --with-decryption --query "Parameters[0].Value" --region ap-northeast-1 --output text)
fi

exec "$@"