#pragma once

#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>

#include "variable.h"

#define MAX_LENGTH 256
#define MAX_VARS_AMOUNT 128

// static char** split_to_tokens(char* infix_expr);
//
bool is_double(char* str);
//
char** to_rpn(char** infix_expr);
//
// char** variables_to_values(char** tokens);
