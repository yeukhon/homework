#include<stdio.h>
#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/shm.h>
#include "sem.h"
#include<stdlib.h>

#define N 3
#define BUFSIZE 1
#define PERMS 0666 //0666 - To grant read and write permissions 

int *buffer, *num_order;
int nextp=0,nextc=0;
int emptyShelf, orderOnShelf, pizzaOnShelf, mutex;

void waiter_as_producer()
{
    //printf("\n num: %d", *num_order);
    nextp = 0, num_order[0] = 0;
    //printf("\n num: %d", *num_order);
    char cont;
    printf("\nwaiter: Should we take order today (y or n): ");
    scanf("\n%c", &cont);
    if (cont != 'y') return;
	
    while(cont != 'n' && nextp < N)
    {
        num_order[0] = num_order[0] + 1;
        printf("waiter: Enter order number: ");
        scanf("\n%d", (buffer + nextp));
     	nextp++;
        printf("waiter: More customers (y or n): ");
        scanf("\n%c", &cont);
        if (cont == 'n')
        {
            printf("\nwaiter: Stop serving customers right now. Passing orders to cooker:");
            break;
        }
    }
    printf("\nwaiter: There are total of %d order(s)\n", (*num_order));

}

void waiter_as_consumer()
{
    int max, order, i = 0;
    max = num_order[0];
   
    if (max < 1)
    {
        printf("\nwaiter: There are no orders. Don't bother picking up pizza.");
        return;
    } 
    printf("\nwaiter: Hey, thanks cooker.");
    printf("\nwaiter: Okay. Let me deliver pizza to all customers right now.");
    for(; i < max; i++)
    {
        order = buffer[i];
        printf("\nwaiter: Pizza order #%d is ready.", order);
    }
    printf("\nwaiter: Empty shelf!");
}

void cooker_as_consumer()
{
    int order, max;
    nextc = 0;
    max = num_order[0];

    if (max < 1)
    {
       printf("\ncooker: No pizza order. *smoking*");
       return;
    }
    for(; nextc <= max; nextc++)
    {
        order = buffer[nextc];
        printf("\ncooker: Roger, Mr. waiter. I am processing order #%d", order);
    }
    
}

int main()
{
     int shmid, shmid_num;
     int pid;
     if((shmid=shmget(1000,BUFSIZE,IPC_CREAT | PERMS)) < 0)
     {
      printf("\n unable to create shared memory");
      return;
     }
        
     if((shmid_num=shmget(2000, BUFSIZE, IPC_CREAT | PERMS)) < 0)
     {
        printf("\n unable to create shared memory for num_order");
        return;    
     }

     if((buffer=(int*)shmat(shmid,(char*)0,0)) == (int*)-1)
     {
      printf("\n Shared memory allocation error\n");
      exit(1);
     }

     if((num_order=(int*)shmat(shmid_num, (char*)0,0)) == (int*)-1)
     {
        printf("\n Shared memory allocation for num_order encountered error\n");
        exit(1);    
     }

     if((mutex=semget(IPC_PRIVATE,1,PERMS | IPC_CREAT)) == -1)
     {
       printf("\n can't create mutex semaphore");
       exit(1);
     }

     if((emptyShelf=semget(IPC_PRIVATE,1,PERMS | IPC_CREAT)) == -1)
     {
      printf("\n can't create emptyShelf semaphore");
      exit(1);
     }

     if((orderOnShelf=semget(IPC_PRIVATE,1,PERMS | IPC_CREAT)) == -1)
     {
      printf("\ncan't create orderOnShelf semaphore");
      exit(1);
     }

     if((pizzaOnShelf=semget(IPC_PRIVATE, 1, PERMS | IPC_CREAT)) == -1)
     {
      printf("\ncan't create pizzaOnShelf semaphore");
      exit(1);
     }

     // Create the semaphore 	
     sem_create(mutex,1);
     sem_create(emptyShelf,N);
     sem_create(orderOnShelf,0);
     sem_create(pizzaOnShelf,0);


    //forking a child 
     if((pid=fork()) < 0)
     {
      printf("\n Error in process creation");
      exit(1);
     }

    //Producer process
     if(pid > 0)
     {
	   while(1)
	   {
          P(emptyShelf); // waiter as P finds no items on shelf;
          P(mutex); // has permission to use the shelf
          waiter_as_producer();
          V(mutex); // cooker now can use the shelf
          V(orderOnShelf); // cooker now can pickup orders
          
          P(pizzaOnShelf);
          P(mutex);
          waiter_as_consumer();
          V(mutex);
          V(emptyShelf);
	   }
    }
    if(pid == 0)
    {
	   while(1)
	   {
          P(orderOnShelf); // make sure there is an order on shelf
          P(mutex); //permission to work
          cooker_as_consumer(); // take order and put pizza on shelf
          V(mutex); //release permission
          V(pizzaOnShelf); // pizza is now on shelf
          wait();
      }
   }
}
