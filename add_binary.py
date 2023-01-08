## https://leetcode.com/problems/add-binary/
"""Given two binary strings a and b, return their sum as a binary string.
Example 1:
Input: a = "11", b = "1"
Output: "100"
Example 2:
Input: a = "1010", b = "1011"
Output: "10101

1+1=0 with carry 1
1+0=1 with carry 0
0+1=1 with carry 0
0+0=0 with carry 0
Imp:1+1=1 with carry 1 if previous carry was 1

"""
def sum_bits(a,b):
    if a == '1' and b == '1' :
        sum = '0'
        carry = '1'
        return [sum,carry]
    elif a == '1' and b == '0':
        sum,carry = '1','0'
        return [sum,carry]
    elif a == '0' and b == '1':
        sum, carry = '1','0'
        return [sum,carry]
    elif a == '0' and b == '0' :
        sum, carry = '0','0'
        return [sum,carry]
    else:
        return '-1' 
                      


def addBinary(numa, numb):
    la = len(numa) - 1
    lb = len(numb) - 1

    str = ""
    carry = 0 
    maxi = max(la,lb)
    for i in range(maxi,-1,-1):
        if numa[i] and numb[i]:
            a , b = sum(numa[i],numb[i])
            c , d = sum(a,carry) 
            str = str + c
            carry = d
        elif numa[i]:
            a,b = sum(numa[i],carry)
            str = str + a
            carry = b
        elif numb[i]:
            a,b = sum(numb[i],carry)              
            str = str + b
            carry = b
    print(str)


# Driver 
if __name__ == "__main__":
    inputs = [["11","1"],["1010","1011"]]
    case = 0
    for input in inputs:
        case += 1
        print(f"Case : {case}")
        print(addBinary(input[0],input[1]))
        print("------------------------------------------")