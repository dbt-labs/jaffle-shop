# 🥪 The Jaffle Shop 🦘

This is a sandbox project for exploring the basic functionality and latest features of dbt. It's based on a fictional restaurant called the Jaffle Shop that serves [jaffles](https://en.wikipedia.org/wiki/Pie_iron). Enjoy!

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/dbt-labs/jaffle-shop?quickstart=1)  
[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/dbt-labs/jaffle-shop)

## Create new repo from template

1. <details>
   <summary>Click the green "Use this template" button at the top of the page to create a new repository from this template.</summary>

   ![Click 'Use this template'](/.github/static/use-template.gif)
   </details>
3. Follow the steps to create a new repository.

## Platform setup

### dbt Cloud IDE (most beginner friendly)
1. Set up a dbt Cloud account and follow Step 4 in the [Quickstart instructions for your data platform](https://docs.getdbt.com/quickstarts), to connect your platform to dbt Cloud.
2. Choose the repo you created in Step 1 as the repository for your dbt Project code.
3. Click `Develop` in the top nav, you should be prompted to run a `dbt deps`, which you should do.

### dbt Cloud in GitHub Codespaces (more customizable)

1. <details>
   <summary>In the new repository, click the green "Code" button and select "Open with Codespaces" from the dropdown. If possible, open in VSCode locally rather than the web version, performance is significantly better.</summary>

   ![Create codespace on main](.github/static/open-codespace.gif)
   </details>
2. Install the recommend extensions when prompted unless you have set preferences here.
3. Run `task install-cloud`[^1] in the integrated terminal.

### dbt Core with DuckDB in GitHub Codespaces (think local, act global)

1. <details>
   <summary>In the new repository, click the green "Code" button and select "Open with Codespaces" from the dropdown. If possible, open in VSCode locally rather than the web version, performance is significantly better.</summary>

   ![Create codespace on main](.github/static/open-codespace.gif)
   </details>
2. Install the recommend extensions when prompted unless you have set preferences here.
3. Run `task install-core`[^2] in the integrated terminal.

### dbt Core with other platforms (choose your own adventure)

If you know what you're doing, you can use this repo with any local or cloud database with a dbt adapter. We can't offer support for this setup, but the general steps should be as follows:

1. Clone the new repository to your local machine or open it in a GitHub Codespace.
2. Run `task venv`.[^3]
3. Run `source .venv/bin/activate && exec $SHELL`
4. Run `task install-core`.[^2]
5. [Live your life](https://www.youtube.com/watch?v=koVHN6eO4Xg&t=72s)!

## Project setup

Once your project is set up, use the following steps to get the project ready for whatever you'd like to do with it.

### dbt Cloud IDE

1. Run `dbt seed` to load the sample data into your raw schema.
2. Delete the `jaffle-data` directory now that the raw data is loaded into the warehouse.

### All other paths

1. Run `task setup`.[^4]
2. Run a `dbt build` to build your project.
3. [Ready to run](https://www.youtube.com/watch?v=Wu4_zVxmufY&t=234s) whatever you want!

---

[^1]: This will install the dbt Cloud CLI [currently in beta] as well as the python packages necessary for running MetricFlow queries, linting your code, and other tasks.
[^2]: This will install dbt Core and the DuckDB adapter as well as the python packages necessary for running MetricFlow queries, linting your code, and other tasks.
[^3]: This will create a virtual environment called `.venv`.
[^4]: This will run a `dbt seed` then `rm -rf jaffle-data`, deleting the sample data now that it's loaded into your raw schema.
