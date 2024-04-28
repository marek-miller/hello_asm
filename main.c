#include <stdint.h>
#include <stdio.h>

#include "hello.h"

int main(int argc, char **argv)
{
	(void)argc;
	(void)argv;

	uint64_t rt = hello_asm(1);
	printf("hello_asm(1)= %lu\n", rt);

	return 0;
}
