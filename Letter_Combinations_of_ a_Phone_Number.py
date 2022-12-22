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
        print("There is no number")
        return []

    elif len(my_list) == 1:
        print("Only a single digit number is entered")
        for i in my_list[0]:
            output.append(i)
        return output

    else:
        print(f"{len(my_list)} digit number is entered ")
        n = len(my_list)
        i = 2
        output = find_pair(my_list[0],my_list[1])
        while(i < n):
            output = find_pair(output,my_list[i])
            i+= 1
        return output    


if __name__ == "__main__":
    input = [23,45,29,6,879,"",9876]
    case = 0
    for number in input:
        case += 1
        print(f"Case Number : {case} , Input : {number}")
        print(letterCombinations(number))
        print("--------------------------------")


