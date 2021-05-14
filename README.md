# Formulas AWS

<img width="953" alt="title" src="https://user-images.githubusercontent.com/22433243/117589694-889ce780-b101-11eb-84fa-b197d0b72ee8.png">

## 📚 Documentation

This repository contains Ritchie formulas which can be executed by the [ritchie-cli](https://github.com/ZupIT/ritchie-cli).

- [Ritchie CLI documentation](https://docs.ritchiecli.io)

## 🔎 What you'll find in this repository

![Rit aws create cluster](/docs/img/rit-aws-create-cluster.jpg)

### ⚠️  Caution

This repository is a **DEMO** to show what is possible to perform using Ritchie CLI.

The formula's templates use specific and sometimes latest providers versions (for aws, terraform, helm, kubernetes, etc...). 

Therefore, the pipeline created by the formula may not work without updating the versions compatibility in the future.

If that happens, the recommendation is to fork the repo and update the templates' versions.

## ⚙️  How does it work?

### Youtube Video

[![Youtube video](https://user-images.githubusercontent.com/22433243/118302743-fc9d0e00-b4ba-11eb-86d9-50dc0e6a2ac5.jpeg)](https://www.youtube.com/watch?v=C3jYQBUf4Us)

### 1 - Execute the `rit aws create cluster`command:

![](https://user-images.githubusercontent.com/22433243/115786294-f96ca180-a396-11eb-8fe5-227e1c2448c9.png)

### 2 - Check the code on your repository:

[Repository ritchie-tdc-recife](https://github.com/GuillaumeFalourd/ritchie-tdc-recife/tree/qa)

### 3 - Wait for the pipeline to run on circleci:

![](https://user-images.githubusercontent.com/22433243/115786320-05586380-a397-11eb-8824-f4862326ee00.png)

### 4 - Check your cluster on AWS:

![](https://user-images.githubusercontent.com/22433243/115786346-11442580-a397-11eb-9288-f48ddc6a7473.png)

## 🗃 Sample repositories used for demonstrations:

- **12.04.2020**: [ritchie-tdc-recife](https://github.com/GuillaumeFalourd/ritchie-tdc-recife) 
- **10.28.2020**: [ritchie-tdc-poa](https://github.com/GuillaumeFalourd/ritchie-tdc-poa) 
- **30.04.2021**: [ritchie-demo-create-cluster](https://github.com/GuillaumeFalourd/ritchie-demo-create-cluster) 

## 📦 Use Formulas

To import this repository, you need [Ritchie CLI installed](https://docs.ritchiecli.io/getting-started/installation)

Then, you can use the `rit add repo` command manually, or execute the command line below directly on your terminal (since CLI version 2.8.0):

```bash
rit add repo --provider="Github" --name="formulas-aws" --repoUrl="https://github.com/GuillaumeFalourd/formulas-aws" --priority=1
```

Finally, you can check if the repository has been imported correctly by executing the `rit list repo` command.

## 🆙 How to give priority

The commons repository installed through the `rit init` command of Ritchie CLI has duplicated commands with the `formulas-aws` repository.

You have to `set priority 0` for the formulas-aws repository, and `set priority 1` for the commons repository, for the `rit aws create cluster` command to work.

This can be achieved through the `rit set repo-priority` command.

## ♻️ Contribute to the repository

### 🆕 Creating formulas

1. Fork and clone the repository
2. Create a branch: `git checkout -b <branch_name>`
3. Check the step by step of [how to create formulas on Ritchie](https://docs.ritchiecli.io/tutorials/formulas/how-to-create-formulas)
4. Add your formulas to the repository
and commit your implementation: `git commit -m '<commit_message>`
5. Push your branch: `git push origin <project_name>/<location>`
6. Open a pull request on the repository for analysis.

### 🆒 Updating Formulas

1. Fork and clone the repository
2. Create a branch: `git checkout -b <branch_name>`
3. Add the cloned repository to your workspaces (`rit add workspace`) with a highest priority (for example: 1).
4. Check the step by step of [how to implement formulas on Ritchie](https://docs.ritchiecli.io/tutorials/formulas/how-to-implement-a-formula)
and commit your implementation: `git commit -m '<commit_message>`
5. Push your branch: `git push origin <project_name>/<location>`
6. Open a pull request on the repository for analysis.

- [Contribute to Ritchie community](https://github.com/ZupIT/ritchie-formulas/blob/master/CONTRIBUTING.md)

