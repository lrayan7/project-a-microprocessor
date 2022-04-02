
int main(){
	
	int fd;
    char *name = "machine_code";
    fd = open(name, O_WRONLY , 0644);
    if (fd == -1) {
        perror("open failed");
        exit(1);
    }

    if (dup2(fd, 1) == -1) {
        perror("dup2 failed"); 
        exit(1);
    }

    // file descriptor 1, i.e. stdout, now points to the file
    // "helloworld" which is open for writing
    // You can now use printf which writes specifically to stdout

    
    
	for(int j0 = 0;j0 < 250; j0+=4)
		printf("instruction_memory[%d] = 32'b00001;\n",j0);
	for(int j1 = 250;j1 < 500; j1+=4)
		printf("instruction_memory[%d] = 32'b00010;\n",j1);
	for(int j2 = 500;j2 < 750; j2+=4)
		printf("instruction_memory[%d] = 32'b00011;\n",j2);
	for(int j3 = 750;j3 < 1000; j3+=4)
		printf("instruction_memory[%d] = 32'b00100;\n",j3);
	for(int j4 = 1000;j4 < 1250; j4+=4)
		printf("instruction_memory[%d] = 32'b01001;\n",j4);
	
		
	
	exit(0);
}


