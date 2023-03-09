def find_substrs(string):
    ## string = "abchfdg"
    substrs = []
    n = len(string)

    for i in range(n+1):
        for j in range(i+1,n):
            substrs.append(string[i:j+1])
            substrs = list(set(substrs))
    return substrs

def find_non_occuring(string):
    my_dict = {}
    for char in string:
        if char in my_dict:
            return
        else:
            my_dict[char] = 1
    return True            

if __name__ == "__main__":
    string = "abcdd"
    unique = []
    result = find_substrs(string)
    print(f"Results : {result}")
    for string in result:
        if find_non_occuring(string):
            unique.append(string)  
    print(f"Unique list : {unique}")
    max = 0
    for string in unique:
         if len(string) > max:
            max = len(string)
    print(f"Max Length : {max}")        
