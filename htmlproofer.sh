#!/usr/bin/env bash

# The primary purpose of this script is to run htmlproofer and turn its output
# into GitHub action annotations.

ARGS=($2)

# htmlproofer writes errors to stderr and everything else to stdout. We don't
# care about the other stuff, just the errors. Stuff them into a file.
htmlproofer $1 "${ARGS[@]}" 2>raw-errors.txt > /dev/null
CODE=$?

# If htmlproofer exited okay, we can stop now.
if [ "$CODE" -eq "0" ]; then
  exit 0
fi

# htmlproofer output ends with a kind of status message. We don't care about
# that so just throw it away.
head -n -2 raw-errors.txt > errors.txt

# Loop over each line in the errors file...
while read LINE; do
  if [[ "$LINE" =~ ^\*[[:space:]]At[[:space:]]([^:]*) ]]; then
    # This line indicates a file with an error in it, so save off the page name
    PAGE="${BASH_REMATCH[1]}"
  elif [[ "$LINE" =~ ^For[[:space:]]the ]]; then
    # This line indicates the start of a new type-of-test. We don't care.
    :
  elif [[ ! "$LINE" =~ ^$ ]]; then
    # This line is not empty nor the previous two types, so it must be error
    # text. Now we can output it! Get rid of commas from the htmlproofer output,
    # though: GitHub uses those as delimiters and they'll mess up the annotation
    # +output.
    echo "::error title=${LINE//,}::in ${PAGE//,}"
  fi
done < errors.txt

exit 1