def find_non_occuring(string):
    my_dict = {}
    for char in string:
        if char in my_dict:
            return
        else:
            my_dict[char] = 1
    return True   

string = 'pwwkew'

maxi = 0
left,right = 0,0

while right < len(string):
    substr = string[left:right+1]
    print(substr)
    print(substr)
    if find_non_occuring(substr):
        maxi = max(len(substr),maxi)
        right += 1
    else:
        left = left+1
        right = right+1

print(maxi)            

