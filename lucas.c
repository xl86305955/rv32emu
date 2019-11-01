#define NUM 7

void main()
{
    volatile char* tx = (volatile char*) 0x40002000;
    const char* output = "L(7) = ";
    
    int count = 0;
    int tmp;
    int o_int;
    char o_char[50];
    int flag = 1;
    int L[NUM];
    L[0] = 2;
    L[1] = 1;
    int i = 2;
    while(*output) {
    	*tx = *output;
    	output++;
    }

    /* calculate the lucas number */
    for (;i<=NUM;i++) {
		L[i] = L[i-1] + L[i-2];
	}

    o_int = L[NUM];
    
    /* int to char */    
    do {
	if (o_int < 10) {
		flag = 0;
	}
	tmp = o_int%10;
	if (tmp == 0) o_char[count] = '0';
	if (tmp == 1) o_char[count] = '1';
	if (tmp == 2) o_char[count] = '2';
	if (tmp == 3) o_char[count] = '3';
	if (tmp == 4) o_char[count] = '4';
	if (tmp == 5) o_char[count] = '5';
	if (tmp == 6) o_char[count] = '6';
	if (tmp == 7) o_char[count] = '7';
	if (tmp == 8) o_char[count] = '8';
	if (tmp == 9) o_char[count] = '9';
	count++;       	
	o_int = o_int/10;	
	}while ( o_int > 10 || flag == 1);
    
    /* print out the value of result*/
    for (;count>=0;count--) {
    	*tx = o_char[count];	
    }

}

