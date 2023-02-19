def search( nums, target) :
    
        start,end = 0, len(nums)-1
        
        while  start <= end:

            middle = int((start + end)/2)                    
            
            if nums[middle] == target:
               return middle 
            elif target > nums[middle]:
                start = middle + 1
            else:
                end = middle - 1
        
        return -1



if __name__ == "__main__":
    inputs = [[[-1,0,3,5,9,12],9],[[-1,0,3,5,9,12],2]]
    case = 0 
    for input in inputs:
        case += 1
        nums = input[0]
        target = input[1]
        print(f"Case : {case}")
        print(search(nums,target))
        print("------------------------------------------------------")

         

