#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

int add(int, int);
int divi(int, int);
void printParent();
void printChild();

int main()
{
    printf("Program begins here!\n");
    printParent();

    pid_t pid1, pid2, pid3;
    int a = 2, b = 2, c = 2, d = 2, e = 2, f = 2;
    int result, rtval1, rtval2, rtval3;

    pid1 = fork();

    if(pid1 == 0)
    {
        printChild();
        return add(a, b);
    }
    else
    {
        printf("I just finished forking pid1.\n");
        waitpid(-1, &rtval1, 0);
        rtval1 = WEXITSTATUS(rtval1);
        printParent();

        pid2 = fork();
        if(pid2 == 0)
        {
            printChild();
            return add(c, b);    
        }
        else
        {
            printf("I just finished forking pid2.\n");
            waitpid(-1, &rtval2, 0);
            rtval2 = WEXITSTATUS(rtval2);
            printParent();

            pid3 = fork();
            if(pid3 == 0)
            {
                printChild();
                return divi(e, f);
            }
            else
            {
                printf("I just finished forking pid3.\n");
                waitpid(-1, &rtval3, 0);
                rtval3 = WEXITSTATUS(rtval3);
                printParent();
            }
        }
    }
    result = (rtval1 * rtval2) - rtval3;
    //printf("%d, %d, %d\n", rtval1, rtval2, rtval3);  // debug
    printf("The result of doing (%d + %d) * (%d + %d) - (%d / %d) is: %d\n", a, b, c, d, e, f, result);
    return 0;
}

int add(int a, int b)
{
    printf("I am doing %d + %d\n", a, b);
    return a + b;    
}

int divi(int a, int b)
{
    printf("I am doing %d / %d\n", a, b);
    return a * b;    
}

void printParent()
{
    printf("I am parent. My PID is: %d\n", getpid());
    printf("\n");
}

void printChild()
{
    printf("I am the child. My PARENT pid: %d, and my pid: %d\n", getppid(), getpid());
}
