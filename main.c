#include <stdio.h>
#include <stdint.h>

#include "hello.h"

int main(void) {

    uint64_t rt = hello_asm(1);
    printf("hello_asm(1)= %lu\n", rt);

    return 0;
}
