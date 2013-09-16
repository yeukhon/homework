#include<errno.h>
#include <stdio.h>
#include <unistd.h>

int main (int argc, char* argv[])
{
	char* filepath = argv[1];
	int returnval;

	returnval = access (filepath, F_OK);
	if (returnval == 0)
		printf ("\n %s exists\n", filepath);
	else 
		printf ("%s is not accessible\n", filepath);
	return 0;
}
