## https://leetcode.com/problems/median-of-two-sorted-arrays/description/
"""
Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.
The overall run time complexity should be O(log (m+n)).
Example 1:
Input: nums1 = [1,3], nums2 = [2]
Output: 2.00000
Explanation: merged array = [1,2,3] and median is 2.

Example 2:
Input: nums1 = [1,2], nums2 = [3,4]
Output: 2.50000
Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
"""

def findMedianSortedArrays(nums1, nums2):

    n , m = len(nums1), len(nums2)
    combined = [0]* (m+n)   ## Place Holder Array 

    x, y = 0 , 0 
    i = 0 

    while x < len(nums1) and y < len(nums2):
        if nums1[x] <= nums2[y]:
            combined[i] = nums1[x]
            x += 1
        else:
            combined[i] = nums2[y]      
            y += 1
        i += 1    

    while  x < len(nums1):
        combined[i]= nums1[x]
        i+= 1
        x += 1 
    while y < len(nums2):
        combined[i] = nums2[y]
        i += 1
        y += 1

    print(f"Merged List : {combined}")    
    
    n = len(combined)
    rem = n%2
    print(f"rem : {rem}")
    if rem != 0 and (rem < n ):
       rem = int(n/2) 
       return combined[rem]
    else:
        rem = int(n/2)
        return (combined[rem-1] + combined[rem])/2    

# driver 
if __name__ == "__main__":
    inputs =[ [[1,3],[2]],[[1,2],[3,4]],[[],[1]],[[],[1,2,3,4,5]]]
    case = 0
    for input in inputs:
        case += 1
        nums1 = input[0]
        nums2 = input[1]
        print(f"Case : {case}")
        print(findMedianSortedArrays(nums1, nums2))