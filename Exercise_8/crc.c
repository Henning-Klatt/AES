#include <stdio.h>
#include <stdint.h>


int msb (uint32_t reg)
{
    if (reg & 0b10000000000000000000000000000000)
    {
        return 1;
    }
    else{return 0;}
}

void printbinary(uint32_t reg){
    for (int i = 0 ; i<32 ; i++){
        if (msb(reg)){
            printf("1");
        }
        else {
            printf("0");
        }
        reg <<= 1;
    }
}



int main()
{ 
	uint32_t message = 0xffffffff;
	uint32_t polynom = 0b11000001;
    uint32_t polynom32 = polynom <<= (32-8);
	
	for (int i = 0; i < 32; ++i)
	{
        if (msb(message))
        {
            message = (message << (32-8) ^ polynom32);
        }
        else{
            message <<= 1;
        }
        printf("message:%i   " , i);
        printbinary(message);
        printf("\n");
	}

    //printf("Message: %d", message);

    printbinary(message);
    //printf("test");
    return 1;
	
	//output checksum
	//query the user for checking


}

