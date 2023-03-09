# https://leetcode.com/problems/search-insert-position/description/?envType=study-plan&id=algorithm-i

"""Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
You must write an algorithm with O(log n) runtime complexity.
Example 1:
Input: nums = [1,3,5,6], target = 5
Output: 2

Example 2:
Input: nums = [1,3,5,6], target = 2
Output: 1

Example 3:
Input: nums = [1,3,5,6], target = 7
Output: 4  """

def searchInsert(nums, target):
        n = len(nums)
        start, end = 0, len(nums)-1
       
        while start <= end:
            middle = int((start+end)/2)
            if target < nums[middle]:
                end = middle - 1
            elif target > nums[middle]:
                start = middle + 1 
            else: return middle
            
        return start

# driver 
if __name__ == "__main__":
    Inputs  = [[1,3,5,6],[1,3,5,6],[1,3,5,6]]
    Targets = [5,2,7]
    case = 0
    for i in range(len(Inputs)):
        nums , target = Inputs[i] , Targets[i]
        case += 1
        print(f"Case Number : {case}")
        print(f"Output : {searchInsert(nums,target)}")
        print("------------------------------------") 