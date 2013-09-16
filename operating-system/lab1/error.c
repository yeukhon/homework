#include<stdio.h>
#include<stdlib.h>	
#include<fcntl.h>
#include<unistd.h>

int main()
{
	int fd;
	fd = open("destination.txt", O_RDONLY);
	if(fd < 0) /* ah, there’s an error */
	{
		printf("sorry, I couldn’t open filename\n");
		perror("open"); /* This will explain why */
		return;
	}
	return 0;
}
