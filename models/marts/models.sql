select
    maybe_positive_int_column,
    {{ function('is_positive_int') }}(maybe_positive_int_column)
from {{ ref('customers') }}
