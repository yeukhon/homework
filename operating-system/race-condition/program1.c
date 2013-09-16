#include<stdio.h>
#include<stdlib.h>

static void charatatime(char *);

int main(void)
{
	int pid;
	
	if( (pid = fork()) < 0)
	{
		perror("Fork error");
		exit(1);
	}

	else if( pid == 0)
	{
		charatatime("Output from Process Q\n");
	}
	
	else
	{
		charatatime("Output from Process P\n");
	}

	exit(0);
}

static void charatatime(char * str)
{
	char * ptr;
	int c;
	/* Ensure that characters sent to stdout are output as soon
	   as possible - make stdout unbuffered. */
	setbuf(stdout,NULL);
	for(ptr = str; c = *ptr++; )
		putc(c, stdout);
}
