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
    close(fd); // close the original file descriptor
    int fd2 = open("input.txt", O_RDONLY);
    read(fd2, &c, 1);
    read(fd2, &c, 1);
    read(fd2, &c, 1);
    printf("child:%c\n",c);
    close(fd2); // closes the child's file descriptor
  }
  else
  {
    read(fd, &c, 2);
    printf("parent:%c\n",c);
  }
  close(fd);
}
