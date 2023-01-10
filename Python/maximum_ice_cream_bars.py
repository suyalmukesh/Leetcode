# https://leetcode.com/problems/maximum-ice-cream-bars/description/

# Leetcode : 1833 Maximum Ice Cream Bars ( Medium )
"""
It is a sweltering summer day, and a boy wants to buy some ice cream bars.
At the store, there are n ice cream bars. You are given an array costs of length n, where costs[i] is the price of the ith ice cream bar in coins. The boy initially has coins coins to spend, and he wants to buy as many ice cream bars as possible. 
Return the maximum number of ice cream bars the boy can buy with coins coins.
Note: The boy can buy the ice cream bars in any order.

Example 1:
Input: costs = [1,3,2,4,1], coins = 7
Output: 4
Explanation: The boy can buy ice cream bars at indices 0,1,2,4 for a total price of 1 + 3 + 2 + 1 = 7.
"""

def maxIceCream(costs,coins):
    costs = sorted(costs)
    sum = 0
    count = 0
    for i in range(len(costs)):
        sum = sum + costs[i]
        if sum <= coins:
            count += 1
    return count   
        

# Driver Program with sample input and test results 
if __name__ == "__main__":
    inputs = [[[1,3,2,4,1],7],[[10,6,8,7,7,8],5],[[1,6,3,1,2,5],20]]
    correct = [4,0,6]
    case = 0
    for pair in inputs:
        costs = pair[0]
        coins = pair[1]
        case += 1 
        print(f"Case : {case}")
        if correct[case-1] == maxIceCream(costs, coins):
            print(f"Answer {correct[case-1]} => Test Passed") 
            print("--------------------------------------------------")