import re

def main(a_string):
    """
    Return 1 if a_string represents a positive integer (e.g., "10", "+8" not allowed here),
    else 0.
    """
    return 1 if re.search(r'^[0-9]+$', a_string or '') else 0
