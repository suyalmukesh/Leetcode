def twoSum(nums, target):
        prevMap = {} # val : index
        
        for i, n in enumerate(nums):
            print(f"==>  {i},{n}")
            diff = target - n
            if diff in prevMap:
                return [prevMap[diff], i]
            prevMap[n] = i
        return


if __name__ == "__main__":
    inputs = [[[2,7,11,15],9],[[3,2,4],6],[[3,3],6]]
    case = 0
    for input in inputs:
        case += 1
        nums = input[0]
        target = input[1]
        print(f"Case : {case}")
        print(twoSum(nums,target))
        print("----------------------------------------------") 
