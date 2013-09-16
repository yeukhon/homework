#include <stdio.h>
#include <math.h>
#include "gmp.h"

int main()
{
    mpz_t start;
    mpz_t base;
    mpz_t unit; // set to be one

    mpz_init(start);
    mpz_set_ui(start, 0);

    mpz_init(base);
    mpz_set_ui(base, 2);

    mpz_init(unit);
    mpz_set_ui(unit, 1);

    unsigned long int power = 64;
    mpz_pow_ui(start, base, power);
    mpz_sub(start, start, unit); // start -= 1;

    printf("We are starting out at ");
    mpz_out_str(stdout,10,start);
    printf("\n");
    
    mpz_t next_prime;
    mpz_init(next_prime);
    
    mpz_t diff;
    mpz_init(diff);
    

    mpz_t two;
    mpz_init(two);
    mpz_set_ui(two, 2);

    mpz_nextprime(next_prime, start);
    mpz_sub(diff, next_prime, start);

    if(mpz_cmp(diff, two) == 0)
    {
        printf("We found the twin primes to be: ");
        mpz_out_str(stdout, 10, start);
        printf(" and ");
        mpz_out_str(stdout, 10, next_prime);
        printf("\n");
        return 0;
    }
    
    while(1)
    {
        mpz_init_set(start, next_prime); // set start to the current new prime
        mpz_nextprime(next_prime, start);
        mpz_sub(diff, next_prime, start);
        if(mpz_cmp(diff, two) == 0)
        {
            printf("We found the twin primes to be: ");
            mpz_out_str(stdout, 10, start);
            printf(" and ");
            mpz_out_str(stdout, 10, next_prime);
            printf("\n");
            break;
        }
        printf("Still looking...\n");
        mpz_out_str(stdout, 10, start);
        printf("\n");
    }
    
    return 0;
}
