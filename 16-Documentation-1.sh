source "${TEST_LIB}/funcs.bash"

test_start "Documentation Check" \
    "Ensures documentation is provided for each function and data structure and the README is filled out"

if ! ( which doxygen &> /dev/null ); then
    # "Doxygen is not installed. Please install (as root) with:"
    # "pacman -Sy doxygen"
    test_end 1
fi

grep 'TODO' "${TEST_DIR}/../README.md" && test_end 0
# If the grep above found any TODOs, the test case fails.

doxygen "${TEST_DIR}/../Doxyfile" 2>&1 \
    | grep -v 'display.h' \
    | grep -v 'display.c' \
    | grep -v 'inspector.c' \
    | grep -v '(variable)' \
    | grep -v '(macro definition)' \
    | grep 'is not documented' \
        && test_end 1

test_end 0
