# 🥪 The Jaffle Shop 🦘

![Jaffle Shop Logo](https://github.com/dbt-labs/jaffle-shop/assets/91998347/bfba27af-04bf-48fb-8a2d-99a1965a9a25)

This is a sandbox project for exploring the basic functionality and latest features of dbt. It's based on a fictional restaurant called the Jaffle Shop that serves [jaffles](https://en.wikipedia.org/wiki/Pie_iron). Enjoy!

## Create new repo from template

1. <details>
   <summary>Click the green "Use this template" button at the top of the page to create a new repository from this template.</summary>

   ![Click 'Use this template'](/.github/static/use-template.gif)
   </details>

2. Follow the steps to create a new repository. You should choose the option to only copy the `main` branch.

## Platform setup

1. Set up a dbt Cloud account and follow Step 4 in the [Quickstart instructions for your data platform](https://docs.getdbt.com/quickstarts), to connect your platform to dbt Cloud, then follow one of the two paths below to set up your development environment.

### dbt Cloud IDE (most beginner friendly)

1. Choose the repo you created in Step 1 as the repository for your dbt Project code.

2. Click `Develop` in the top nav, you should be prompted to run a `dbt deps`, which you should do.

### dbt Cloud CLI (if you prefer to work locally)

> [!NOTE]
> If you'd like to use the dbt Cloud CLI, but are a little intimidated by the terminal, we've included config for a task runner called, fittingly, `task`. It's a simple way to run the commands you need to get started with dbt. You can install it by following the instructions [here](https://taskfile.dev/#/installation). We'll call out the `task` based alternative to each command below.

1. Run `git clone [new repo name]` (or `gh repo clone [repo owner]/[new repo name]` if you prefer GitHub's excellent CLI) to clone your new repo to your local machine.

2. [Follow the steps on this page](https://cloud.getdbt.com/cloud-cli) to install and set up a dbt Cloud connection with the dbt Cloud CLI.

> [!TIP]
> If you're using `task`, you can run `task setup` to skip all the rest of this and run all the setup commands in one easy command. I recommend it!

3. Set up a virtual environment and activate it. I like to call my virtual environment `.venv` and add it to my `.gitignore` file (we've already done this if you name your virtual environment '`.venv`') so that I don't accidentally commit it to the repository, but you can call it whatever you want, just make sure you `.gitignore` it.

   ```shell
   python3 -m venv .venv # create a virtual environment
   source .venv/bin/activate # activate the virtual environment
   OR
   task venv # create a virtual environment
   ```

4. Install the project's requirements into your virtual environment.

   ```shell
   python3 -m pip install --upgrade pip # upgrade pip (always a good idea!)
   python3 -m pip install -r requirements.txt # install the project's requirements
   OR
   task install # install the project's requirements
   ```

5. Double check that your `dbt_project.yml` is set up correctly by running `dbt list`. You should get back a list of models and tests in your project.

## Project setup

Once your development platform of choice is set up, use the following steps to get the project ready for whatever you'd like to do with it.

1. Run `task gen` to generate a year of synthetic data for the Jaffle Shop.

2. Run `task build` to seed the generated data into your warehouse and build the project.

3. Run `task clean` to delete the generated data to avoid re-seeding the same data repeatedly for no reason.

#### OR

1. In your activated virtual environment with dependencies installed, run `jafgen` to generate a year of synthetic data for the Jaffle Shop, no arguments are necessary for the defaults.

2. Run `dbt deps` to install the dbt packages configured in the `packages.yml` file.

3. Run `dbt seed` to seed the generated data into your warehouse.

4. Delete the generated data to avoid re-seeding the same data repeatedly for no reason.
   ```shell
   rm -rf jaffle-data
   ```
5. Run `dbt build` to build and test the project, make sure you deleted the generated data first or you'll be re-seeding the same data.

## Pre-commit and SQLFluff

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
