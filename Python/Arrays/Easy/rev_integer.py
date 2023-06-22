def reverse2(x): ## Time Limit Exceeded here 
    base = pow(10,len(str(x))-1 )
    num = 0
    
    while x != 0:
        y = x%10 
        num = num + base*y
        x = int(x/10)
        base = base/10
    
    return int(num)

def reverse(x):
    
    
    flg = 1
    if x < 0:
        flg = -1 
    
    x = str(abs(x))
    x = x[::-1]
    x = int(x)
    if x >= 2**31-1 or x <= -2**31 : return 0 
    return x*flg






if __name__ == "__main__":
    num = 12345678912345677668686868686886686868686868
    num = 2**31+5
    print(reverse(num))        