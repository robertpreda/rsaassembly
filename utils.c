#include <stdlib.h>
#include <stdio.h>

int gcd(int a, int b)
{
    while(a != b)
    {
        if(a > b)
            a = a -b;
        else
            b = b - a;
    }
    return a;
}

int get_e(int totient, int n, int *return_val)
{
    int i;
    for(i=2; i < totient;i++)
    {
        if(gcd(totient,i ) == 1 && gcd(n, i) == 1)
        {
             return_val = i;
             return i;
        }
           
    }
}
int get_d(int totient, int e, int *retval)
{
    int i=1;
    while(1)
    {
        if(i*e % totient == 1)
            {
                retval=i;
                return i;
            }
    }
}
void test()
{
    fprintf(stdout, "shit\n");
}

int main(void)
{
    //// everyday I shit my pants
    printf("%d", gcd(6,3));
}