#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

int main()
{
        printf("I am the parent, my pid is: %d\n", getpid());
        int a = 10, b = 25, pid=0;
        pid=fork();
        if(pid==0)
        {
                a = a +b;
                printf("I am child, a is: %d\n", a);
                printf("I am child, b is: %d\n", b);
                printf("I am child, current pid is: %d\n", pid);
                pid = fork();
                if(pid != 0)
                {
                        //wait(0);
                        b = b + 20;
                        printf("I am second parent, a is: %d\n", a);
                        printf("I am second parent, b is: %d\n", b);
                        printf("I am second parent, my current child pid is: %d\n", pid);
                        exit(0);
                }
                else
                {
                        a = (a*b)+30;
                        printf("I am second child, a is: %d\n", a);
                        printf("I am second child, b is: %d\n", b);
                        printf("I am second child, current pid is: %d\n", pid);
                        printf("\n");
                }
                exit(0);
        }
        else
        {
                //wait(0);
                printf("I just forked. I am parent: %d\n", getpid());
                b = a + b - 5;
                printf("I am the top parent, bottom else\n");
                printf("I am the top parent, a is: %d\n", a);
                printf("I am the top parent, b is: %d\n", b);
                printf("I am the top parent, my current child pid is: %d\n", pid);
                printf("\n");
        }
        return 0;
}
