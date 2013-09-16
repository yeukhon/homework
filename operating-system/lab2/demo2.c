#include <stdio.h>
#include <unistd.h>/* contains fork prototype */

int main(void)
{
	int pid;

	printf("Hello World!\n");
	printf("Here I am  before use of forking\n");
	printf("I am the PARENT process and pid is : %d\n",getpid());

	pid = fork( );
	if (pid == 0)
	{	  
	  printf("\n\nHere I am just after forking\n");
     printf("I am the Child process and pid is :%d\n",getpid());
	  printf("My parent's pid is: %d\n", getppid()); /*Since this child is orphan, its adopted by the 
                                                      ancestor process init and hence return pid as 1*/
	}
   else
   {
     printf("\n\nHere I am just after forking\n");
     printf("I am the Parent process and pid is: %d\n",getpid());
   }

}
