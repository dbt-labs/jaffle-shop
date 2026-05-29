import holidays
import pandas

def model(dbt, session):
    dbt.config(materialized = "table", packages = ['pandas', 'holidays'])
    
    norway_holidays = holidays.NO(years=2025)
        
    df = dbt.ref("date_spine").to_pandas()
    df['IS_HOLIDAY'] = df['DATE_DAY'].isin(norway_holidays)

    return df