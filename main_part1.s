.data
.dword 2,2,2,2,1,2,3,4,1,2,3,4

.text
#x3 first matrix number(for first element) x4 2nd matrix number(for first element)

lui x3,0x10000 #base address
lui x6,0x4

add x5,x6,x3 #the result base addresss

ld x12 ,0(x3) #rowA
addi x3,x3,8
ld x13,0(x3) #colA
addi x3,x3,8
ld x14,0(x3) #rowB
addi x3,x3,8
ld x15,0(x3) #colB
addi x3,x3,8

lui x4,0x10000 #to get the starting address of 2nd matrix

#get the  correct address of other matrix
mul x8,x12,x13
addi x8,x8,4
addi x1,x1,8 #x1 is used as temporarie
mul x8,x8,x1 

add x4,x4,x8 #location recieved contains 2nd matrix location
#ld x28,0(x4)


# to check for compatability
beq x13,x14,no_error
sd x0,0(x5)
addi x5,x5,8
sd x0,0(x5)
addi x5,x5,8
beq x0,x0,exit_the_code
no_error:  #if no error is there in the dimension then follow the functions
    sd x12,0(x5) #stored the result row-dim
    addi x5,x5,8
    sd x15,0(x5) # stored column dim result
    addi x5,x5,8

jal x1,mmult
beq x0,x0,exit_the_code

#function starts here
mmult:
     
     #i variable x28
     addi x28,x0,0
     # global variable for value 8
     addi x23,x0,8
     outer_loop:
         
         
         
         bge x28,x12 ,exit_outer_loop
      
         #variable j
         addi x29,x0,0
            
            inner_loop1:
                bge x29,x15,exit_inner_loop1
             
                
                #temporary variable to put the  values in matrix
                #x31=i*colB+j
                mul x31,x28,x15 #i*rowA
                
                add x31,x29,x31
                mul x31,x31,x23
                add x31,x31,x5 ## added base address to store result
                sd x0,0(x31) #c[i][j]=0
                
                #variable k x30
                addi x30,x0,0
                
                    inner_loop2:
                        bge x30,x14,exit_inner_loop2
                        
                        #calculating a[i][k]=i*colA+k k is x30
                        mul x18,x13,x28
                        
                        add x18,x18,x30
                        mul x18,x18,x23
                        add x18,x3,x18 
                        ld x18,0(x18) #loaded a[i][k]
                        
                        #calculating b[k][j]=k*colB+j
                        mul x19,x15,x30
                        
                        add x19,x29,x19
                        mul x19,x19,x23
                        add x19,x4,x19
                        ld x19,0(x19) #loaded b[k][j]
                        
                        #adding the sum
                        mul x21,x19,x18 #multiply it
                        add x20,x20,x21
                        #sd x20,0(x31) #31 is the address to store
                        
                        #incrmenting k
                        addi x30,x30,1
                        beq x0,x0,inner_loop2
                        
                        
                        
                         
                    exit_inner_loop2:
                        sd x20,0(x31) #31 is the address to store
                        addi x20,x0,0 #resetting the register
                        #incrementing j
                        addi x29,x29,1
                        beq x0,x0,inner_loop1
                    
            exit_inner_loop1:
                #incrementing i
                addi x28,x28,1
                beq x0,x0,outer_loop
     exit_outer_loop:
         addi x0,x0,0
         jalr x0,x1,0
         
         
exit_the_code:
    #here code ended
    addi x0,x0,0
    
    
    
    
    



