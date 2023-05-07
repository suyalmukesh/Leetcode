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
""" 
THOUGH THIS QUESTION WAS IN EASY BUT IT TOOK ME LOT OF EFFORTS AND STILL I DON'T THINK MY SOLUTION LOOKS GOOD 
"""


def sum_bits(a,b,c):
        sum =  int(a) + int(b) + int(c)
        if sum == 3:
            sum , carry = '1', '1'
            return sum,carry
        elif sum == 2:
            sum , carry = '0', '1'
            return sum,carry
        elif sum == 1:
            sum , carry = '1', '0'
            return sum,carry
        else:
            sum , carry = '0', '0'    
            return sum,carry

def addBinary(a, b):
    b1 = a[::-1]
    b2 = b[::-1]

    out = ""
    aa,bb= 0,0
    mm = max(len(b1),len(b2))
    carry = 0
    for i in range(mm+1):
        if i <= len(b1)-1:
            aa = b1[i]
        else: aa = 0    
        if i <= len(b2)-1:
            bb = b2[i]
        else: bb = 0 
        sum , cc = sum_bits(aa,bb,carry)
        carry = cc
        out = out+sum

    fix_reverse =  out[::-1]   # As we are doing addition from left 
    fix_reverse  = int(fix_reverse)  # Removing prefixed zero 
    fix_reverse = str(fix_reverse)  # As answer is needed in string format 
    return fix_reverse

## LeetCode Official Solution 
## Revice this again and again

def addBinary2(a, b):
        n = max(len(a), len(b))
        a, b = a.zfill(n), b.zfill(n)
        
        carry = 0
        answer = []
        for i in range(n - 1, -1, -1):
            if a[i] == '1':
                carry += 1
            if b[i] == '1':
                carry += 1
                
            if carry % 2 == 1:
                answer.append('1')
            else:
                answer.append('0')
            
            carry //= 2
        
        if carry == 1:
            answer.append('1')
        answer.reverse()
        
        return ''.join(answer)

# Driver 
if __name__ == "__main__":
    inputs = [["11","1"],["1010","1011"]]
    case = 0
    for input in inputs:
        case += 1
        print(f"Case : {case}")
        print(addBinary(input[0],input[1]))
        print(addBinary2(input[0],input[1]))
        print("------------------------------------------")