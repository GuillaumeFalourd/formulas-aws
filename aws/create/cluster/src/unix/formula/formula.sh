#!/bin/sh

runFormula() {
  echo "🛠 Starting Cluster Creation Automation"

  echo "1️⃣ Create Github Project -------------------------------------"
  echo '{"project_name":"'$PROJECT_NAME'", "project_description":"Terraform project created with Ritchie CLI (https://ritchiecli.io)", "private":"'$PRIVATE'", "workspace_path": " "}' | rit github create repo --stdin
  sleep 10s

  echo "2️⃣ Follow project on CircleCI -------------------------------------"
  echo '{"provider":"github", "project":"'$PROJECT_NAME'"}' | rit circleci follow project --stdin
  sleep 3s

  echo "3️⃣ Create Bucket on AWS -------------------------------------"
  echo '{"region":"'$REGION'", "bucket":"'$BUCKET'"}' | rit aws create bucket --stdin
  sleep 3s

  echo "4️⃣ Generate terraform project -------------------------------------"
  echo '{"project_name":"'$PROJECT_NAME'", "project_location":"'$CURRENT_PWD'", "bucket_name":"'$BUCKET'", "bucket_region":"'$REGION'"}' | rit aws generate terraform-project --stdin
  sleep 3s

  cd $PROJECT_NAME

  echo "5️⃣ Add VPC configurations -------------------------------------"
  echo '{"region":"'$REGION'", "vpc_name":"'$VPC_NAME'", "vpc_cidr":"'$VPC_CIDR'", "vpc_azs":"'$VPC_AZS'", "customer_name":"'$CUSTOMER_NAME'"}' | rit aws add terraform-vpc --stdin
  sleep 3s

  echo "6️⃣ Add EKS configurations -------------------------------------"
  echo '{"cluster_name":"'$CLUSTER_NAME'", "domain_name":"'$DOMAINE_NAME'"}' | rit aws add terraform-eks --stdin
  sleep 3s

  echo "7️⃣ Configure CircleCI environment (QA) -------------------------------------"
  echo '{"repo_owner":"'$USERNAME'", "repo_name":"'$PROJECT_NAME'", "env_name":"AWS_ACCESS_KEY_ID_QA", "env_value":"'$ACCESS_KEY'"}' | rit circleci add env --stdin
  echo '{"repo_owner":"'$USERNAME'", "repo_name":"'$PROJECT_NAME'", "env_name":"AWS_SECRET_ACCESS_KEY_QA", "env_value":"'$SECRET_ACCESS_KEY'"}' | rit circleci add env --stdin
  sleep 3s

  echo "8️⃣ Commit project (QA) -------------------------------------"
  git checkout -b qa
  git add . > /dev/null
  git commit -m "First commit from Ritchie (rit aws create cluster) formula" > /dev/null
  git push qa
  sleep 3s

  URL = https://app.circleci.com/pipelines/github/$USERNAME/$PROJECT_NAME?branch=qa
  echo "🚀 CircleCI pipeline initiated at $URL"
}
