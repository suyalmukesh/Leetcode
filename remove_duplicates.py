## Very intersting logic , got from internet not my thinking but smart one 
## THIS WILL PLACE THE NUMBERS IN ASCENDING ORDER IN THE FIRS HALF OF THE ARRAY
## THE LATER HALF DOES NOT MATTER

def removeDuplicates(nums):
    
        count = 0 
        for i in range(1,len(nums)):
            if nums[i]==nums[i-1]:
                count += 1
                print(f"debug_1 :: nums = {nums}") 
            else:
                nums[i-count]=nums[i]
                print(f"debug_2 :: nums = {nums}")

        return len(nums)-count   


if __name__ == "__main__":
    
    input = [[1,1,2],[0,0,1,1,1,2,2,3,3,4]]
    case = 0
    for nums in input:
        case += 1
        print(f"Case Number : {case}")
        print(removeDuplicates(nums))
        print("__________________________________")
