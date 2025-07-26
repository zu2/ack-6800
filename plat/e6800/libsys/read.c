/* $Source$
 * $State$
 * $Revision$
 */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <emu6800.h>

ssize_t read(int fd, void* buffer, size_t count)
{
eio:
	errno = EIO;
	return -1;
}
