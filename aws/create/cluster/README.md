# Ritchie Formula

## Premisses

- Github account.
- CircleCI account (associated with the Github Account).
- AWS account.
- [Ritchie-formulas repository](https://github.com/ZupIT/ritchie-formulas) imported.

## Dependencies

- This formula has been implemented using Shell, and manipulates formulas implemented with Golang and Node from the ritchie-formulas repository. Therefore, to execute this formula locally, it will be necessary to have all those programming languages installed, to build the formulas binaries.

## Commands

```bash
rit aws create cluster
```

```bash
echo '{"project_name":"dennis-ritchie-repo", "private":false, "region":"sa-east-1", "bucket":"dennis-ritchie-bucket", "vpc_name":"dennis-ritchie-vpc", "vpc_cidr":"10.0.0.0/16", "vpc_azs":"sa-east-1a,sa-east-1b", "customer_name":"DennisRitchie", "cluster_name":"dennis-ritchie-cluster", "domain_name":"dennisritchiedomain.io"}' | rit aws create cluster --stdin
```

## Note

This formula IS NOT compatible with the DOCKER flag.

## Description

This formula allows to create and configure an EKS on AWS using Github, CircleCI and Terraform.
To do so, it performs 8 steps:

1️⃣ Create a Github Project
2️⃣ Follow the Github project on CircleCI
3️⃣ Create a Bucket on AWS
4️⃣ Generate a terraform project
5️⃣ Add VPC configurations to terraform project
6️⃣ Add EKS configurations to terraform project
7️⃣ Configure the CircleCI environment
8️⃣ Commit the project on Github
