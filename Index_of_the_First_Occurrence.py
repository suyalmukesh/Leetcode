"""Q28: Given two strings needle and haystack, return the index of the first occurrence of 
needle in haystack, or -1 if needle is not part of haystack."""

def strStr(haystack, needle):
    n = len(needle)
    m = len(haystack)
    if n == m:
        return 0 if haystack == needle else -1

    if n > m :
        print("We are trying to search bigger string in small string ")
        return -1

    i = 0
    j = n

    while j <= m:
        if haystack[i:j] == needle:
            return i
        else:
            i = i+1
            j = j+1     
    return -1        

if __name__ == "__main__":
    input = [["sadbutsad","sad"],["leetcode","leeto"],["sadbutsad","sad"],["sad","sadbutsad"]]
    case = 0 
    for mycase in input:
        case += 1
        print(f"Case Number : {case}")
        haystack = mycase[0]
        needle = mycase[1]
        print(strStr(haystack,needle))
        print("------------------------------------")

