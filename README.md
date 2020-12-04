# Ritchie Formula Repo

![Rit banner](/docs/img/ritchie-banner.png)

## Documentation

[Contribute to the Ritchie community](https://github.com/ZupIT/ritchie-formulas/blob/master/CONTRIBUTING.md)

This repository contains Ritchie formulas which can be executed by the [ritchie-cli](https://github.com/ZupIT/ritchie-cli).

- [Gitbook](https://docs.ritchiecli.io)

## Use Formulas

To import this repository, you need [Ritchie CLI installed](https://docs.ritchiecli.io/getting-started/installation)

Then, you can use the `rit add repo` command manually, or execute the command line below directly on your terminal:

```bash
echo '{"provider":"Github", "name":"formulas-aws", "url":"https://github.com/GuillaumeFalourd/formulas-aws", "priority":1}' | rit add repo --stdin
```

Finally, you can check if the repository has been imported correctly by executing the `rit list repo` command.

## How to give priority

The commons repository installed through the `rit init` command of Ritchie CLI has duplicated commands with the formulas-aws repository.

You have to `set priority 0` for the formulas-aws repository, and `set priority 1` for the commons repository, for the `rit aws create cluster` command to work.

This can be achieved through the `rit set repo-priority` command.

## Contribute to the repository with your formulas

1. Fork the repository
2. Create a branch: `git checkout -b <branch_name>`
3. Check the step by step of [how to create formulas on Ritchie](https://docs.ritchiecli.io/getting-started/creating-formulas)
4. Add your formulas to the repository
and commit your implementation: `git commit -m '<commit_message>`
5. Push your branch: `git push origin <project_name>/<location>`
6. Open a pull request on the repository for analysis.
