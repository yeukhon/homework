#include<stdio.h>
#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/shm.h>
#include "sem.h"
#include<stdlib.h>
#define N 3

#define BUFSIZE 1
#define PERMS 0666 //0666 - To grant read and write permissions 

int *buffer, *buffer_len;
int nextp=0,nextc=0;
int busy,full,empty;    //semaphore variables
								 //mutex - to avoid race conditions
 							    //full, empty - to indicate buffer status

void waiter_as_producer()
{
    if (full == 1 && busy == 1)
    {
        printf("Queue full. Cooker is still making pizza. Hold on.");
        busy = 1;
        return;    
    }
    nextp = 0, full = 0, busy = 1, empty = 0;

    int order_num;
    char cont;
    printf("\nShould we take order today (y or n): ");
    scanf("\n%c", &cont);
    if (cont != 'y') return;
    for(; nextp < N; nextp++)
    {
        buffer_len[0] = nextp;  // update number of orders made
        printf("Enter order number: ");
        scanf("\n%d", (buffer+nextp));
        printf("More customers (y or n): ");
        scanf("\n%c", &cont);
        if (cont != 'y')
        {
            printf("\nStop serving customers right now. Passing orders to cooker.");
            break;
        }    
        
    }
    if (nextp == N)
    {
        empty = 0;
        full = 1;    
    }

}

void waiter_as_consumer()
{
     if(empty == 0)
     {
         printf("\nThe queue is full. Cooker is probably busy making pizzas.");
         return ;
     }

     int order, i;
     printf("\nOpps. Thanks cooker.");
     printf("\nOkay. Let me get all the pizzas customer have ordered.");

     for(;i <= nextp; i++)
     {
        order = *(buffer + i);
        printf("\nI am delivering pizza order #%d", order);
     }
     printf("\nI am done!");
     full = 0;
     empty = 1; 
}

void cooker_as_consumer()
{
    printf("cooker as consumer");
    int order, len;
    nextc = 0;
    len = *(buffer_len);
    for(; nextc <= len; nextc++)
    {
        order = *(buffer + nextc);
        printf("\nRoger, waiter. I am processing order# %d", order);
    }
    printf("\nI am finished cooking.");
}

int main()
{
     int shmid_buf, shmid_len,no=1,i;
     int pid,n;

    if((shmid_buf=shmget(1000,BUFSIZE,IPC_CREAT | PERMS)) < 0)
     {
      printf("\n unable to create shared memory");
      return;
     }
    if((shmid_len=shmget(1000,BUFSIZE,IPC_CREAT | PERMS)) < 0)
     {
      printf("\n unable to create shared memory");
      return;
     }
     buffer=(int*)shmat(shmid_buf,(char*)0,0);
     buffer_len = (int*)shmat(shmid_len, (char*)0,0);

     if((busy=semget(IPC_PRIVATE,1,PERMS | IPC_CREAT)) == -1)
     {
       printf("\n can't create busy semaphore");
       exit(1);
     }

     if((empty=semget(IPC_PRIVATE,1,PERMS | IPC_CREAT)) == -1)
     {
      printf("\n can't create empty semaphore");
      exit(1);
     }

     if((full=semget(IPC_PRIVATE,1,PERMS | IPC_CREAT)) == -1)
     {
      printf("\ncan't create full semaphore");
      exit(1);
     }

     // Create the semaphore 	
     sem_create(busy,1);
     sem_create(empty,N);
     sem_create(full,0);


    //forking a child 
     if((pid=fork()) < 0)
     {
      printf("\n Error in process creation");
      exit(1);
     }

    //Producer process
     if(pid > 0)
     {
         P(empty);
         P(busy);
         waiter_as_producer();
         V(busy);
         V(full);
         wait();
         P(empty);
         P(busy);
         waiter_as_consumer();
         V(busy);
         V(full);
     }

    //consumer process - child process
        if(pid == 0)
        {
         P(full);
         P(busy);
         cooker_as_consumer();
         V(busy);
         V(empty);
      }
}
