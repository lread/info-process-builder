#include <stdio.h>

int main(int argc, char *argv[]) {
  printf("argc: %d\n", argc - 1);
  for (int ndx = 1; ndx < argc; ndx++) {
    printf("arg%d: %s\n", ndx , argv[ndx]);
  }
  return 0;
}

