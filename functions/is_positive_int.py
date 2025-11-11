import re

def _digits_only(s: str) -> bool:
    return bool(re.search(r'^[0-9]+$', s or ''))

def _to_flag(is_match: bool) -> int:
    return 1 if is_match else 0

def main(a_string: str) -> int:
    """
    This is used as the entry point for the UDF.
    Returns 1 if a_string represents a positive integer (e.g., "10"),
    else 0.
    """
    return _to_flag(_digits_only(a_string))