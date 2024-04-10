# 🥪 The Jaffle Shop 🦘

![Jaffle Shop Logo](https://github.com/dbt-labs/jaffle-shop/assets/91998347/bfba27af-04bf-48fb-8a2d-99a1965a9a25)

This is a sandbox project for exploring the basic functionality and latest features of dbt. It's based on a fictional restaurant called the Jaffle Shop that serves [jaffles](https://en.wikipedia.org/wiki/Pie_iron). Enjoy!

## Table of contents

1. [Create new repo from template](#create-new-repo-from-template)
2. [Platform setup](#platform-setup)
   1. [dbt Cloud IDE](<#dbt-cloud-ide-(most-beginner-friendly)>)
   2. [dbt Cloud CLI](<#dbt-cloud-cli-(if-you-prefer-to-work-locally)>)
3. [Project setup](#project-setup)
   1. [With `task`](#with-task)
   2. [Manually](#manually)
4. [Advanced options](#advanced-options)
   1. [Working with a larger dataset](#working-with-a-larger-dataset)
   2. [Pre-commit and SQLFluff](#pre-commit-and-sqlfluff)

## Create new repo from template

1. <details>
   <summary>Click the green "Use this template" button at the top of the page to create a new repository from this template.</summary>

   ![Click 'Use this template'](/.github/static/use-template.gif)
   </details>

2. Follow the steps to create a new repository. You can choose to only copy the `main` branch for simplicity, or take advantage of the Write-Audit-Publish (WAP) flow we use to maintain the project and copy all branches (which will include `main` and `staging`.

> [!TIP]
> In a setup that follows a WAP flow, you have a `main` branch that serves production data (like downstream dashboards) and is tied to a Production Environment in dbt Cloud, and a `staging` branch that serves a clone of that data and is tied to a Staging Environment in dbt Cloud. You then branch off of `staging` to add new features or fix bugs, and merge back into `staging` when you're done. When you're ready to deploy to production, you merge `staging` into `main`. Staging is meant to be more-or-less a mirror of production, but safe to test breaking changes, so you can verify changes in a production-like environment before deploying them fully. You _write_ to `staging`, _audit_ in `staging`, and _publish_ to `main`.

## Platform setup

1. Set up a dbt Cloud account (if you don't have one already, if you do, just create a new project) and follow Step 4 in the [Quickstart instructions for your data platform](https://docs.getdbt.com/quickstarts), to connect your platform to dbt Cloud.

2. Choose the repo you created in Step 1 of the **Create new repo from template** section as the repository for your dbt Project's codebase.

### dbt Cloud IDE (most beginner friendly)

1. Click `Develop` in the dbt Cloud nav bar. You should be prompted to run a `dbt deps`, which you should do.

> [!TIP]
> Make sure to turn on the 'Defer to staging/production' toggle once you're set up. This will ensure that only modified code is run when you run commands in the IDE, saving you time and resources!

### dbt Cloud CLI (if you prefer to work locally)

> [!NOTE]
> If you'd like to use the dbt Cloud CLI, but are a little intimidated by the terminal, we've included configuration for a _task runner_ called, fittingly, `task`. It's a simple way to run the commands you need to get started with dbt. You can install it by following the instructions [here](https://taskfile.dev/#/installation). We'll call out the `task` based alternative to each command below.

1. Run `git clone [new repo name git link]` (or `gh repo clone [repo owner]/[new repo name]` if you prefer GitHub's excellent CLI) to clone your new repo from the first step of the **Create new repo from template** section to your local machine.

2. [Follow the steps on this page](https://cloud.getdbt.com/cloud-cli) to install and set up a dbt Cloud connection with the dbt Cloud CLI.

> [!TIP]
> If you're using `task`, once you have dbt Cloud CLI set up, you can run `task setup` to skip all the rest of this and run all the setup commands in one easy command. We recommend it!

3. Set up a virtual environment and activate it. I like to call my virtual environment `.venv` and add it to my `.gitignore` file (we've already done this if you name your virtual environment '`.venv`') so that I don't accidentally commit it to the repository, but you can call it whatever you want, just make sure you `.gitignore` it.

   ```shell
   # create a virtual environment
   python3 -m venv .venv
   # activate the virtual environment
   source .venv/bin/activate
   OR
   # create a virtual environment
   task venv
   ```

4. Install the project's requirements into your virtual environment.

   ```shell
   # upgrade pip (always a good idea to do first!)
   python3 -m pip install --upgrade pip
   # install the project's requirements
   python3 -m pip install -r requirements.txt
   OR
   # install the project's requirements
   task install
   ```

5. Double check that your `dbt_project.yml` is set up correctly by running `dbt list`. You should get back a list of models and tests in your project.

## Project setup

Once your development platform of choice and dependencies are set up, use the following steps to get the project ready for whatever you'd like to do with it.

### With `task`

1. Run `task gen` to generate a year of synthetic data for the Jaffle Shop.

2. Run `task build` to seed the generated data into your warehouse and build the project.

3. Run `task clean` to delete the generated data to avoid re-seeding the same data repeatedly for no reason.

#### OR

### Manually

> [!NOTE]
> dbt Cloud CLI has a limit on the size of seed files that can be uploaded to your data warehouse. Seeds are _not_ meant for data loading in production, they're meant for small reference tables, we just use them for convenience here. If you want to generate more than the default 1 year of `jafgen` data, you'll need to use dbt Core to seed the data. [We cover how to do this here](#working-with-a-larger-dataset).

1. In your activated virtual environment with dependencies installed, run `jafgen` to generate a year of synthetic data for the Jaffle Shop, no arguments are necessary for the defaults.

2. Run `dbt deps` to install the dbt packages configured in the `packages.yml` file.

3. Run `dbt seed` to seed the generated data into your warehouse.

4. Delete the generated data to avoid re-seeding the same data repeatedly for no reason, slowing down your build process.

   ```shell
   rm -rf jaffle-data
   ```

5. Run `dbt build` to build and test the project, make sure you deleted the generated data first or you'll be re-seeding the same data.

> [!TIP]
> The dbt Cloud CLI will automatically defer unmodified models to the previously built models in your staging or production environment, so you can run `dbt build`, `dbt test`, etc without worrying about running unnecessary code.

## Advanced options

### Working with a larger dataset

[`jafgen`](https://github.com/dbt-labs/jaffle-shop-generator) is a simple tool for generating synthetic Jaffle Shop data that is maintained on a volunteer-basis by dbt Labs employees. This project is more interesting with a larger dataset generated and uploaded to your warehouse. 6 years is a nice amount to fully observe trends like growth, seasonality, and buyer personas that exist in the data. Uploading this amount of data requires a few extra steps, but we'll walk you through them. If you have a preferred way of loading CSVs into your warehouse or an S3 bucket, that will also work just fine, the generated data is just CSV files.

1. Make sure your virtual environment is activated and you have the dependencies installed, this will install the `jafgen` CLI tool.
2. `pip install dbt-core dbt-[your warehouse adapter]`. For example, if you're using BigQuery, you would run `pip install dbt-core dbt-bigquery`. dbt Core is required temporarily to seed the larger files, we'll uninstall it in the final step to avoid conflicts over the `dbt` command.
3. Because you have an active virtual environment, this new install of `dbt` should take precedence in your [`$PATH`]($PATH`). If you're not familiar with the `PATH` environment variable, just think of this as the order in which your computer looks for commands to run. What's important is that it will look in your active virtual environment first, so when you run `dbt`, it will use the `dbt` you just installed in your virtual environment.
4. Create a `profiles.yml` file in the root of your project. This file is already `.gitignore`d so you can keep your credentials safe. If you'd prefer you can also set up a `profiles.yml` file at the `~/.dbt/profiles.yml` path instead for extra security.
5. [Add a profile for your warehouse connection in this file](https://docs.getdbt.com/docs/core/connect-data-platform/connection-profiles#connecting-to-your-warehouse-using-the-command-line) and add this configuration to your `dbt_project.yml` file as a top-level key called `profile` e.g. `profile: my-profile-name`.
6. Run a `jafgen [integer of years to generate]` e.g. `jafgen 4`, then run a `dbt seed`. Depending on how much data you choose to generate this might take several minutes, we don't recommend generating more than 10 years of data as this is untested and may take a _really_ long time to generate and seed.
7. `pip uninstall dbt-core dbt-[your warehouse adapter]` to remove the dbt Core installation. This is a temporary installation to allow you to seed the data, you don't need it for the rest of the project which will use the dbt Cloud CLI. You can then delete your `profiles.yml` file and the configuration in your `dbt_project.yml` file. If you want to keep your dbt Core installation, you can, but you'll need to be mindful of conflicts between the two installations which both use the `dbt` command.

### Pre-commit and SQLFluff

There's an optional tool included with the project called `pre-commit`.

[pre-commit](https://pre-commit.com/) automatically runs a suite of of processes on your code, like linters and formatters, when you commit. If it finds an issue and updates a file, you'll need to stage the changes and commit them again (the first commit will not have gone through because pre-commit found and fixed an issue). The outcome of this is that your code will be more consistent automatically, and everybody's changes will be running through the same set of processes. We recommend it for any project.

You can see the configuration for pre-commit in the `.pre-commit-config.yaml` file. It's installed as part of the project's `requirements.txt`, but you'll need to opt-in to using it by running `pre-commit install`. This will install _git hooks_ which run when you commit. You can also run the checks manually with `pre-commit run --all-files` to see what it does without making a commit.

At present the following checks are run:

- `ruff` - an incredibly fast linter and formatter for Python, in case you add any Python models
- `check-yaml` - which validates YAML files
- `end-of-file-fixer` - which ensures all files end with a newline
- `trailing-whitespace` - which trims trailing whitespace from files

At present, the popular SQL linter and formatter SQLFluff doesn't play nicely with the dbt Cloud CLI, so we've omitted it from this project _for now_. If you'd like auto-formatting and linting for SQL, check out the dbt Cloud IDE!

We have kept a `.sqlfluff` config file to show what that looks like, and to future proof the repo for when the Cloud CLI support linting and formatting.
