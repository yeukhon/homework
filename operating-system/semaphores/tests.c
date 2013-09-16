#include "stdio.h"
 
int main(void) 
{

     int order, nextp, N=3;
     char cont;
     nextp = 0;
     printf("\nShould we continue (y or n): ");
     scanf("%c", &cont);
     if (cont != 'y') return;
     for(; nextp < N; nextp++)
     {
        printf("Enter order number: ");
        scanf("%d\n", &order);
        printf("you have entered %d\n", order);
        printf("okay now continue with cont\n");
        

        printf("enter cont y or n: ");
        
        scanf("%c", &cont);
        if (cont != 'y')
        {
            printf("\nnot equal to y\n");
            break;

        }
        printf("after intepreting t[0]");
     }
 
   return 0;
}
