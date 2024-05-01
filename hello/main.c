#include <stdint.h>
#include <stdio.h>

#include "hello.h"

int main(int argc, char **argv)
{
	(void)argc;
	(void)argv;

	uint64_t rta = hello_a(1);
	printf("hello_a(1)=%lu\n", rta);

	uint64_t rtc = hello_c(1);
	printf("hello_c(1)=%lu\n", rtc);

	return 0;
}
