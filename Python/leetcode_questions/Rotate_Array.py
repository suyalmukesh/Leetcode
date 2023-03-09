# https://leetcode.com/problems/rotate-array/?envType=study-plan&id=algorithm-i

"""
Given an integer array nums, rotate the array to the right by k steps, where k is non-negative.
Example 1:

Input: nums = [1,2,3,4,5,6,7], k = 3
Output: [5,6,7,1,2,3,4]
Explanation:
rotate 1 steps to the right: [7,1,2,3,4,5,6]
rotate 2 steps to the right: [6,7,1,2,3,4,5]
rotate 3 steps to the right: [5,6,7,1,2,3,4]
Example 2:

Input: nums = [-1,-100,3,99], k = 2
Output: [3,99,-1,-100]
Explanation: 
rotate 1 steps to the right: [99,-1,-100,3]
rotate 2 steps to the right: [3,99,-1,-100]
"""
# The solution is correct but "Time Limit Exceeded" ... will device new solution 
def rotate(nums, k):
    count = 0   
    while (count != k):
        n = len(nums) - 1
        temp = nums[n]   # last element 
        for i in range(n,0,-1):
            nums[i] = nums[i-1]
        nums[0] = temp    
        count += 1
    return nums        
 
# Driver 

if __name__ == "__main__":
    Inputs = [[1,2,3,4,5,6,7],[-1,-100,3,99]]
    Rotation = [3,2]
    case = 0 
    for i in range(len(Inputs)):
        nums , k = Inputs[i], Rotation[i]
        case += 1
        print(f"Case : {case}")
        print(f"Output : {rotate(nums,k)}")
        print("--------------------------------------------")
   