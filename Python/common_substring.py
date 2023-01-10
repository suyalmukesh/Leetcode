def find_common(strs):
    strs = sorted(strs)
    first = strs[0]
    last = strs[len(strs)-1]

    n = min(len(first),len(last))
    
    largest_substring = ""
    for i in range(n):
        if first[i] == last[i]:
            largest_substring=largest_substring+first[i]
        else:
            break    
    return largest_substring



my_input = [["aaa","aa","aaa"],["a","ab","abc"],["dog","racecar","car"],["flower","flow","flight"]]
case = 0 
for i in my_input:
    case += 1
    print(f"Test Case : {case}")
    print(f"Input : {i}")
    print(find_common(i))
    print("------------------------------------------")