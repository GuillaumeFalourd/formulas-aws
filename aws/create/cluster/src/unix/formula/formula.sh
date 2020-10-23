#!/bin/sh

runFormula() {
  echo
  echo -e '\033[1m🛠  STARTING CLUSTER CREATION AUTOMATION\033[0m'

  echo
  echo -e '\033[1m1️⃣  CREATE GITHUB PROJECT\033[0m'
  echo
  echo '{"project_name":"'$PROJECT_NAME'", "project_description":"Terraform project created with Ritchie CLI (https://ritchiecli.io)", "private":"'$PRIVATE'", "workspace_path": " "}' | rit github create repo --stdin
  sleep 3s

  echo
  echo -e '\033[1m2️⃣  FOLLOW PROJECT ON CIRCLECI\033[0m'
  echo
  echo '{"provider":"github", "project":"'$PROJECT_NAME'"}' | rit circleci follow project --stdin
  sleep 3s

  echo
  echo -e '\033[1m3️⃣  CREATE BUCKET ON AWS\033[0m'
  echo
  #echo '{"region":"'$REGION'", "bucket":"'$BUCKET'"}' | rit aws create bucket --stdin
  sleep 3s

  echo
  echo -e '\033[1m4️⃣  GENERATE TERRAFORM PROJECT\033[0m'
  echo
  cd $CURRENT_PWD
  if [ $? != 0 ]; then
      cd -
      exit 1;
  fi
  echo '{"project_name":"'$PROJECT_NAME'", "project_location":"'$CURRENT_PWD'", "bucket_name":"'$BUCKET'", "bucket_region":"'$REGION'"}' | rit aws generate terraform-project --stdin
  sleep 3s

  echo
  echo -e '\033[1m5️⃣  ADD VPC CONFIGURATIONS\033[0m'
  cd $CURRENT_PWD'/'$PROJECT_NAME
  if [ $? != 0 ]; then
      cd -
      exit 1;
  fi
  echo '{"region":"'$REGION'", "vpc_name":"'$VPC_NAME'", "vpc_cidr":"'$VPC_CIDR'", "vpc_azs":"'$VPC_AZS'", "customer_name":"'$CUSTOMER_NAME'"}' | rit aws add terraform-vpc --stdin
  sleep 3s

  echo
  echo -e '\033[1m6️⃣  ADD EKS CONFIGURATIONS\033[0m'
  echo
  echo '{"cluster_name":"'$CLUSTER_NAME'", "domain_name":"'$DOMAINE_NAME'"}' | rit aws add terraform-eks --stdin
  sleep 3s

  echo
  echo -e '\033[1m7️⃣  CONFIGURE CIRCLECI ENVIRONMENT (QA)\033[0m'
  echo
  #echo '{"repo_owner":"'$USERNAME'", "repo_name":"'$PROJECT_NAME'", "env_name":"AWS_ACCESS_KEY_ID_QA", "env_value":"'$ACCESS_KEY'"}' | rit circleci add env --stdin
  #echo '{"repo_owner":"'$USERNAME'", "repo_name":"'$PROJECT_NAME'", "env_name":"AWS_SECRET_ACCESS_KEY_QA", "env_value":"'$SECRET_ACCESS_KEY'"}' | rit circleci add env --stdin
  sleep 3s

  echo
  echo -e '\033[1m8️⃣  COMMIT PROJECT ON GITHUB (QA)\033[0m'
  echo
  cd $CURRENT_PWD'/'$PROJECT_NAME
  if [ $? != 0 ]; then
      cd -
      exit 1;
  fi
  pwd
  git init
  git checkout -b qa
  git add .
  git commit -m "First commit from Ritchie (rit aws create cluster) formula"
  git remote add origin https://$USERNAME:$TOKEN@github.com/$USERNAME/$PROJECT_NAME.git
  git push origin qa
  sleep 3s

  echo
  echo "🚀 CircleCI pipeline initiated at:"
  echo "https://app.circleci.com/pipelines/github/$USERNAME/$PROJECT_NAME?branch=qa"
}
