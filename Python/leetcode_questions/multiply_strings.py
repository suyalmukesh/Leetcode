def multiply_string(num1,num2):
    if num1 is None and num2 is None: return None  
    elif num1 is None: return num2
    elif num2 is None: return num1

    rev_num1 = num1[::-1]
    rev_num2 = num2[::-1]
    
    i = 0 
    product = int(rev_num1[i])*int(rev_num2[i])
    







num1 = "123"
num2 = "456"
print(multiply_string(num1,num2))
