def find_pair(str1,str2):
    out = []
    for i in str1:
        for j in str2:
            out.append(f"{i}{j}")
    return out        

def letterCombinations(digits):
    alphabets = {
                2 : "abc", 3 : "def",4 : "ghi",5 : "jkl",6 : "mno",
                7 : "pqrs",8 : "tuv",9 : "wxyz"
            }
    
    my_list = []
    for digit in str(digits):
        #print(f"{digit} -> {alphabets[int(digit)]}")   
        my_list.append(alphabets[int(digit)])
        #print(f"my_list : {my_list}")    

    output = []
    if len(my_list) == 0:
        return []

    elif len(my_list) == 1:
        print("here")
        for i in my_list[0]:
            output.append(i)
        return output

    else:
        for k in range(1,len(my_list)):            
            first = my_list[0]
            second = my_list[k]
            print(f"first:second :: {first}:{second}")
            for i in first:
                for j in second:
                    output.append(f"{i}{j}")
            first = output
            output = first
            return output

if __name__ == "__main__":
    input = [23,45,29,6,879]
    case = 0
    for number in input:
        case += 1
        print(f"Case Number : {case}")
        print(letterCombinations(number))
        print("--------------------------------")


    print(find_pair(["abc"],["hgy"]))    