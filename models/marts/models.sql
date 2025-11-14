select
    maybe_positive_int_column,
    {{ function('is_positive_int') }}(maybe_positive_int_column) as is_positive_int
from {{ ref('customers') }}
