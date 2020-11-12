@echo off
SETLOCAL

@REM The line below makes a temporary correction to the directory
SET proj_loc=%CURRENT_PWD:\=\\%

call:%~1
goto exit

:runFormula
  echo --- Starting Cluster Creation Automation --------
  echo -------------------------------------------------
  echo --- Create Github Project -----------------------
  SET tmp1=%cd%
  cd %CURRENT_PWD%
  echo {"project_name":"%PROJECT_NAME%", "project_description":"Terraform project created with Ritchie CLI ^(https://ritchiecli.io^)", "private":"%PRIVATE%", "workspace_path": " "} | rit github create repo --stdin
  timeout /t 10 /nobreak > nul

  echo --- Follow project on CircleCI ------------------
  echo {"provider":"github", "project":"%PROJECT_NAME%"} | rit circleci follow project --stdin
  timeout /t 3 /nobreak > nul

  echo --- Create Bucket on AWS ------------------------
  echo {"region":"%REGION%", "bucket":"%BUCKET%"} | rit aws create bucket --stdin
  timeout /t 3 /nobreak > nul

  echo --- Generate terraform project ------------------
  echo -------------------------------------------------
  echo %cd%
  echo {"project_name":"%PROJECT_NAME%", "project_location":"%proj_loc%", "bucket_name":"%BUCKET%", "bucket_region":"%REGION%"} | rit aws generate terraform-project --stdin
  timeout /t 3 /nobreak > nul
  cd %PROJECT_NAME%

  echo --- Add VPC configurations ----------------------
  echo {"region":"%REGION%", "vpc_name":"%VPC_NAME%", "vpc_cidr":"%VPC_CIDR%", "vpc_azs":"%VPC_AZS%", "customer_name":"%CUSTOMER_NAME%"} | rit aws add terraform-vpc --stdin
  timeout /t 3 /nobreak > nul

  echo --- Add EKS configurations ----------------------
  echo {"cluster_name":"%CLUSTER_NAME%", "domain_name":"%DOMAINE_NAME%"} | rit aws add terraform-eks --stdin
  timeout /t 3 /nobreak > nul

  echo --- Configure CircleCI environment (QA) ---------
  echo {"repo_owner":"%USERNAME%", "repo_name":"%PROJECT_NAME%", "env_name":"AWS_ACCESS_KEY_ID_QA", "env_value":"%ACCESS_KEY%"} | rit circleci add env --stdin
  echo {"repo_owner":"%USERNAME%", "repo_name":"%PROJECT_NAME%", "env_name":"AWS_SECRET_ACCESS_KEY_QA", "env_value":"%SECRET_ACCESS_KEY%"} | rit circleci add env --stdin
  timeout /t 3 /nobreak > nul

  echo --- Commit project (QA) -------------------------
  git checkout -b qa
  git add .
  git commit -m "First commit from Ritchie (rit aws create cluster) formula" > nul
  git push origin qa
  cd %tmp1%
  timeout /t 3 /nobreak > nul

  SET URL=https://app.circleci.com/pipelines/github/%USERNAME%/%PROJECT_NAME%?branch=qa
  echo CircleCI pipeline initiated at %URL%

  goto exit

:exit
  ENDLOCAL
  exit /b 0