#include <stdio.h>

// Get most significant bit
int msb (unsigned int reg) {
    if (reg & 0b10000000000000000000000000000000) {
        return 1;
    }
    else {
        return 0;
    }
}

void printbinary(unsigned int reg, int length){
    for (int i = 0; i < length; i++){
        if (msb(reg)){
            printf("1");
        }
        else {
            printf("0");
        }
        reg <<= 1;
    }
}


int main() {
    unsigned int message = 0xffffffff;
    unsigned int polynom = 0b11000001;
    
    printf("Enter Polynom (decimal): ");
    scanf("%u",&polynom);
    
    unsigned int polynom32 = polynom <<= (32-8);

    printf("Enter Message (decimal): ");
    scanf("%u",&message);

    polynom32 <<=(1); // führende 1 abschneiden
    
    printf("Polynom: ");
    printbinary(polynom32,32);
    printf("\n");

    printf("message: ");
    printbinary(message, 32);
    printf("\n");

    for (int i = 0; i < 32; i++) {
        if (msb(message)) {
            message <<= 1;
            message = (message ^ polynom32);
        }
        else {
            message <<= 1;
        }
        printf("message:%i   " , i);
        printbinary(message,32);
        printf("\n");
    }
    
    printbinary(message, 7);
    return 1;
}

