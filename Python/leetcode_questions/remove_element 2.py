"""Given an integer array nums and an integer val, remove all occurrences
 of val in nums in-place. The relative order of the elements may be changed."""
# Return k after placing the final result in the first k slots of nums.#
"""
Note that the five elements can be returned in any order.
It does not matter what you leave beyond the returned k (hence they are underscores).
"""

def removeElement(nums, val):
        count = 0 
        for i in range(0,len(nums)):
            if nums[i] == val:
                count += 1
            else:    
                nums[i-count] = nums[i]
        print(nums)        
        return len(nums)-count

if __name__ == "__main__":
    
    input = [[[3,2,2,3],3],[[0,1,2,2,3,0,4,2],2]]
    case = 0
    for nums in input:
        arr = nums[0]
        target = nums[1]
        case += 1
        print(f"Case Number : {case}")
        print(removeElement(arr,target))
        print("__________________________________")
