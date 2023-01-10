## Leetcode Q13 : Roman To Integer  
def return_number(roman):
    mapping = {
        "I": 1, "V":5, "X":10, "L":50,"C":100, "D":500,"M":1000 }

    n = len(roman)
    sum , num = 0 , 0
    i = 0 
    while i < n:
        if i == n-1:  # If we reached at the last character
            num = mapping[roman[i]] 
            print(f"A Block -> i:num :: {i}:{num}")
            i+= 1     
        elif mapping[roman[i+1]] > mapping[roman[i]]: # Here , we are comparing 2 consequitive chars
            num = mapping[roman[i+1]] - mapping[roman[i]]
            print(f"B Block -> i:num :: {i}:{num}")
            i = i+2
        else: # If none of above condition holds , we simply extract the roman given value from the dictionary
            num = mapping[roman[i]] 
            print(f"C Block -> i:num :: {i}:{num}")
            i+= 1
        sum = sum + num 
    return sum       

if __name__ == "__main__":
    input_set = ["I","VI","IV","XL","III","LVIII","MCMXCIV"]

    test_case = 0
    for i in input_set:
        print(f"Test Case : {test_case + 1} ----------------")
        print(return_number(i))
        test_case += 1
        print("----------------")