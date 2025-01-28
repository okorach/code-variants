
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>

#define BIG_ENDIAN_CPU      0
#define LITTLE_ENDIAN_CPU   1

#ifdef TARGET_PPC
typedef uint32_t Integer;
#define CPU_TYPE BIG_ENDIAN_CPU
#else
typedef uint64_t Integer;
#define CPU_TYPE LITTLE_ENDIAN_CPU
#endif

#define SUCCESS "\033[0;32mPASSED\033[0m"
#define FAILED "\033[0;31m** FAILED **\033[0m"


// Computes the double of an integer
Integer double_that(int i)
{
    return (long)i * 2;
}

long test_double_that()
{
    int val = 2000000000;
    // Integer overflow or no integer overflow ?
    long res = double_that(val);
    printf("Test double_that()\t: ");
    printf((long)val * 2 == res ? SUCCESS : FAILED); printf("\n");
    return res;
}

// returns the most significant byte of a short
unsigned char msb(unsigned short n)
{
#if CPU_TYPE == BIG_ENDIAN_CPU
    return n >> 8;
#else
    return *(unsigned char *)&n;
#endif
}

int test_msb()
{
    unsigned short val = 0xBEEF;
    unsigned char c = msb(val);
    // c == 0xBE or c == 0xEF depending on target endianess
    // The below can cause division by zero or not depending on target word sizs (32 or 64 bits)
    printf("Test msb()\t\t: ");
    float ratio = 1 / (0xEF - (int)c);
    printf(SUCCESS);  printf("\n");
    return (ratio != 0);
}

int main()
{
    test_double_that();
    test_msb();
    return 0;
}