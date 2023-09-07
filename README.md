# 🥪 The Jaffle Shop 🦘

This is a sandbox project for exploring the basic functionality and latest features of dbt.

## Create new repo from template

1. Click the green "Use this template" button at the top of the page to create a new repository from this template.
   ![Click 'Use this template'](/.github/static/use-template.gif)
2. Follow the steps to create a new repository.

## Platform setup

### dbt Cloud IDE (most beginner friendly)
1. Set up a dbt Cloud account and follow Step 4 in the [Quickstart instructions for your data platform](https://docs.getdbt.com/quickstarts), to connect your platform to dbt Cloud.
  1a. TODO: write our own instruction set for the above, for clarity. 
2. Choose the repo you created in Step 1 as the repository for your dbt Project code.
3. Click `Develop` in the top nav, you should be prompted to run a `dbt deps`, which you should do.

### dbt Cloud in GitHub Codespaces (more customizable)

1. In the new repository, click the green "Code" button and select "Open with Codespaces" from the dropdown. If possible, open in VSCode locally rather than the web version, performance is significantly better.
  ![Create codespace on main](.github/static/open-codespace.gif)
2. Install the recommend extensions when prompted unless you have set preferences here.
3. Run `task install-cloud` in the integrated terminal. This will install the dbt Cloud CLI [currently in beta] as well as the python packages necessary for running MetricFlow queries, linting your code, and other tasks.

### dbt Core with DuckDB in GitHub Codespaces (think local, act global)

1. In the new repository, click the green "Code" button and select "Open with Codespaces" from the dropdown.
  ![Create codespace on main](.github/static/open-codespace.gif)
2. Install the recommend extensions when prompted unless you have set preferences here.
3. Run `task install-core` in the integrated terminal. This will install dbt Core and the DuckDB adapter as well as the python packages necessary for running MetricFlow queries, linting your code, and other tasks.

### dbt Core with other platforms (choose your own adventure)

If you know what you're doing, you can use this repo with any local or cloud database with a dbt adapter. We can't offer support for this setup, but the general steps should be as follows:

1. Clone the new repository to your local machine or open it in a GitHub Codespace.
2. Run `task venv`.
3. Run `source .venv/bin/activate && exec $SHELL`
4. Run `task install-core`.
5. [Live your life](https://www.youtube.com/watch?v=koVHN6eO4Xg&t=72s)!

## Project setup

Once your project is set up, use the following steps to get the project ready for whatever you'd like to do with it.

1. Run `task load-data`.
2. Run a `dbt build` to build your project.
3. [Party up](https://www.youtube.com/watch?v=thIVtEOtlWM)!
