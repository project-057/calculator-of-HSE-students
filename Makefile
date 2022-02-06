CC=clang
RM=rm -f
CLANG-FORMAT=clang-format

WARNING=-Wall -Wextra -Werror

CLANG-SPEC=-fuse-ld=lld --rtlib=compiler-rt -D_CRT_SECURE_NO_WARNINGS
FLAGS=$(CLANG-SPEC) $(WARNING) -std=c11
<<<<<<< HEAD
SRC=src/calculator.c src/utils.c
DEPS=$(SRC) src/eval.h src/utils.h src/variable.h
=======
SRC=src/calculator.c src/eval.c src/utils.c src/stack.c
DEPS=$(SRC) src/eval.h src/utils.h src/variable.h src/stack.h

>>>>>>> origin/master
BINARY=calculator

$(BINARY): $(DEPS)
	$(CC) $(FLAGS) $(SRC) -o $@

.PHONY: isformatted
isformatted: $(DEPS)
	$(CLANG-FORMAT) -dry-run -Werror $(DEPS)

.PHONY: format
format: $(DEPS)
	$(CLANG-FORMAT) -i $(DEPS)

.PHONY: clean
clean:
	$(RM) calculator
