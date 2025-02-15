CC=clang
RM=rm -f
CLANG-FORMAT=clang-format
PY=python3

WARNING=-Wall -Wextra -Werror
FLAGS=$(WARNING) -std=c11 -lm
SRC_WITHOUT_MAIN=src/eval.c src/utils.c src/stack.c src/variable.c src/vtv.c
SRC=src/calculator.c $(SRC_WITHOUT_MAIN)

DEPS=$(SRC) src/eval.h src/utils.h src/variable.h src/stack.h
BINARY=./calculator

TEST_FLAGS=$(FLAGS) -g -O0
TEST_SRC=tests/smoke.c
TEST_DEPS=$(TEST_SRC) tests/greatest.h
TEST_BINARY=./test_smoke
INTEGRATION_TEST_SCRIPT=./tests/run_full.py
EXEC_INTEGRATION_TEST_SCRIPT=$(PY) $(INTEGRATION_TEST_SCRIPT)
INTEGRATION_TESTS=tests/full/*.in tests/full/*.exp

$(BINARY): $(DEPS)
	$(CC) $(FLAGS) $(SRC) -o $@

.PHONY: isformatted
isformatted: $(DEPS)
	$(CLANG-FORMAT) -dry-run -Werror $(DEPS) $(TEST_DEPS)

.PHONY: format
format: $(DEPS)
	$(CLANG-FORMAT) -i $(DEPS) $(TEST_DEPS)

.PHONY: clean
clean:
	$(RM) $(BINARY)
	$(RM) $(TEST_BINARY)

$(TEST_BINARY): $(TEST_DEPS)
	$(CC) $(TEST_FLAGS) $(TEST_SRC) $(SRC_WITHOUT_MAIN) -o $@

.PHONY: test
test: $(TEST_BINARY)
	$(TEST_BINARY)

.PHONY: integrationtest
integrationtest: $(BINARY) $(INTEGRATION_TEST_SCRIPT) $(INTEGRATION_TEST_SCRIPT)
	$(EXEC_INTEGRATION_TEST_SCRIPT) $(BINARY)
