import holidays
import pandas

#all python models need to be defined at the start with this specific syntax
def model(dbt, session):

#python models don't use Jinja. Here we are using dbt.config to create model configurations
#be sure to materialize python models as tables, and to specify the packages that were imported above
    dbt.config(
        materialized="table",
        packages=['pandas', 'holidays']
    )

    norway_holidays = holidays.NO(years=[2025, 2026])

#python models don't use Jinja. Here we are using dbt.ref to create model references
    df = dbt.ref('date_spine').to_pandas()

# if you are using snowpark columns need to be uppercase
    df['IS_HOLIDAY'] = df['DATE_DAY'].isin(norway_holidays)

#in dbt, you always need to return your data frame at the end of your models
    return df