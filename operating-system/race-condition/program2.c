#include<stdio.h>
#include<fcntl.h>

void main()
{
  char c;
  int pid;
	 
  int fd = open("input.txt", O_RDONLY);
  read(fd, &c, 1);
  printf("root process:%c\n",c);
	 
  pid = fork();
  if (pid == 0)
  {
    read(fd, &c, 1);
    printf("child:%c\n",c);
  }
  else
  {
    read(fd, &c, 1);
    printf("parent:%c\n",c);
  }
}
