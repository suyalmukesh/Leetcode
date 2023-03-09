## https://leetcode.com/problems/plus-one/description/
## LeetCode : 66. Plus One (Easy)


def plusOne(digits):
    n = len(digits)
    sum = 0
    max = 1
    for i in range(n-1):
        max = max*10   
        
    for i in digits:
        sum = sum + max*i
        max = max/10
     
    sum = sum + 1
    sum = int(sum)
    out = []
    sum = str(sum)
    for i in sum:
        out.append(int(i))
    
    return out 

if __name__ == "__main__":
    inputs = [[1,2,3],[4,3,2,1],[9]] 
    case = 0
    for input in inputs:
        case += 1
        print(f"CASE :: {case}")
        print(plusOne(input))
        print("--------------------------------------")           