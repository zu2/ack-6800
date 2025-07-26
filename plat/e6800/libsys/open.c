#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>

int open(const char* path, int access, ...)
{
	static int fd = 0;

	return fd++;
}


