def shift_right(list,pos,m,n):
    m = int(m)
    n = int(n)
    r =  m + n -1
    for i in range(r,pos,-1):
        if i-1 > 0:
            list[i] = list[i-1]
            list[i-1] = 0 
    return list



def merge_1(nums1,m,nums2,n): # Here we are creating third array 
    nums3 = []
    i = 0 
    j = 0
    while i < m and j < n:
        if nums1[i] < nums2[j]:
            nums3.append(nums1[i])
            i += 1
        else:
            nums3.append(nums2[j])
            j+=1
   
    while i < m :
            nums3.append(nums1[i])
            i+=1
   
    while j < n:
            nums3.append(nums2[j])
            j += 1
      
    return nums3        

def merge(nums1,m,nums2,n):
    total = m+n-1
    last = total 
    while last:
        if nums1[m-1] <= nums2[n-1]:
            nums1[last] = nums2[n-1]
            last = last - 1
            n = n-1
        else:
            nums1[last] = nums1[m-1]
            last = last - 1
            m = m-1
    return nums1



if __name__ == "__main__":
    print("Case 1 ")
    nums1 = [1,2,3,0,0,0]
    m = 3 
    nums2 = [2,5,6] 
    n = 3
    print(merge(nums1, m, nums2, n))
    #shift_right(nums1,3,m,n)
    print("Case 2 ")
    nums1 = [1]
    m = 1 
    nums2 = [] 
    n = 0
    print(merge(nums1, m, nums2, n))
    print("Case 3 ")
    nums1 = [0]
    m = 0 
    nums2 = [1] 
    n = 1
    print(merge(nums1, m, nums2, n))