#include<stdio.h>
#include<stdlib.h>	
#include<fcntl.h>
#include<unistd.h>
#include<string.h>

int main()
{
    int fd_r;
    int fd_w;
    char buffer[512];
    size_t nbytes = sizeof(buffer);
    size_t bytes_read;
    size_t bytes_written;

    fd_r = open("source.txt", O_RDONLY);
    if(fd_r < 0)
    {
        printf("Could not open the file for reading.\n");    
    }

     
    fd_w = open("destination.txt", O_CREAT | O_TRUNC | O_WRONLY, 0751);
    if(fd_w < 0)
    {
        perror("open");
    }

    while((bytes_read = read(fd_r, buffer, nbytes)) > 0)
    {
        //printf("%s", buffer);
        bytes_written = write(fd_w, buffer, bytes_read);
        if(bytes_written < 0)
        {
            printf("Write file encountered issue.");    
        }
    }
    close(fd_r);
    close(fd_w);
    return 0;
}
