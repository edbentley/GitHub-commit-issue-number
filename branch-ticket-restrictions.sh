#!/bin/bash

# array of branches you DON'T want tickets on
# separate branches by spaces in array
# e.g. RESTRICTED=("master" "develop")
RESTRICTED=()

# array of prefixes branches MUST start with
# no restrictions if array is empty
# separate prefixes by spaces in array
# e.g. PREFIXES=("feature/" "test-")
PREFIXES=()
