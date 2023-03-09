"""Given an integer array nums, return all the triplets 
[nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, 
and nums[i] + nums[j] + nums[k] == 0.
Notice that the solution set must not contain duplicate triplets."""

def _threeSum(nums): ## BruteForce
    n = len(nums)
    output = []
    for i in range(n-2):
        for j in range(i+1,n-1):
            for k in range(j+1,n):
                if nums[i]+nums[j]+nums[k] == 0:
                    temp = sorted([nums[i],nums[j],nums[k]])
                    if temp not in output:
                        output.append(temp)
    
    return output                   
    
def threeSum(nums): ## BruteForce
    if len(nums) < 3:
        return []

    nums.sort()
    output = []
    for i in range(len(nums)-2):
        if i > 0 and nums[i] == nums[i-1]:
            continue 
        left = i+1
        right = len(nums) - 1

        while left < right:
            total = nums[left] + nums[right] + nums[i]
            if total == 0:
                output.append([nums[i],nums[left],nums[right]])
                left += 1
                right -= 1
                while nums[left] == nums[left-1] and left < right:
                    left += 1
                while nums[right] == nums[right+1] and left < right:
                    right -= 1
            elif total < 0:
                left += 1
            else: 
                right -= 1
    return output                                           



    
    

if __name__ == "__main__":
    inputs = [[-1,0,1,2,-1,-4],[0,1,1],[0,0,0]]
    case = 0 
    for input in inputs:
        case += 1
        print(f"Case : {case}")
        print(threeSum(input))
        print("+++++++++++++++++++++++++++++")

