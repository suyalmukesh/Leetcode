# https://leetcode.com/problems/binary-search/description/?envType=study-plan&id=algorithm-i

"""Given an array of integers nums which is sorted in ascending order, and an integer target, write a function to search target in nums. If target exists, then return its index. Otherwise, return -1.
You must write an algorithm with O(log n) runtime complexity.
Example 1:
Input: nums = [-1,0,3,5,9,12], target = 9
Output: 4
Explanation: 9 exists in nums and its index is 4
Example 2:

Input: nums = [-1,0,3,5,9,12], target = 2
Output: -1
Explanation: 2 does not exist in nums so return -1 """

def search(nums, target):
        n = len(nums) - 1
        
        first , last = 0 , n
        
        while (first <= last ):
            middle = (first+last)/2
            middle = int(middle)
            if target < nums[middle]: last = middle-1
            elif target > nums[middle]: first = middle+1
            else:
                return middle
        return -1


if __name__ == "__main__":
    Inputs = [[-1,0,3,5,9,12],[-1,0,3,5,9,12]]
    targets = [9,2]
    case = 0
    for i in range(len(Inputs)):
        nums = Inputs[i]
        target = targets[i]
        case += 1
        print(f"Case : {case}")
        print(search(nums,target))
        print("----------------------------") 
