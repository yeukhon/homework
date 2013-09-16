#include <stdio.h>
#include <unistd.h>

int main(void)
{
   int pid, status;

   printf("Hello World!\n");
   printf("Here I am  before use of forking\n");
   printf("I am the PARENT process and pid is : %d\n",getpid());
	
//   printf("STATUS: %d\n", status);	

   pid = fork( );
   if (pid == 0)
	{	  
	  printf("\n\nHere I am just after forking\n");
     printf("I am the Child process and pid is :%d\n",getpid());	  
	  printf("My parent's pid is :%d\n",getppid());		
//	  printf("Status: %d\n", status);	
	}
   else
   {
     wait(&status);
     printf("\n\nHere I am just after forking\n");
     printf("I am the Parent process and pid is: %d\n",getpid());
   }
}
