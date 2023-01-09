# https://leetcode.com/problems/sqrtx/description/

## LeetCode 69 : Easy ( But not so easy if logic is unknown )
"""Given a non-negative integer x, return the square root of x rounded down to the nearest integer. The returned integer should be non-negative as well.
You must not use any built-in exponent function or operator.
For example, do not use pow(x, 0.5) in c++ or x ** 0.5 in python.
Example 1:
Input: x = 4
Output: 2
Explanation: The square root of 4 is 2, so we return 2."""

## PLEASE REMEMBER THE LOGIC ( BETTER UNDERSTAND BY DRY-RUN )

def mySqrt(x):
    i = 1 
    if x <= 1 : return x
    sq =  i * i
    while x >= sq:
        i += 1
        sq = i * i 
    return i - 1


if __name__ == "__main__":
    Inputs = [4,8,16,25]
    case = 0 
    for num in Inputs:
        case += 1
        print(f"Test Case Number : {case}")
        print(mySqrt(num))
        print("....................................")
