## Leetcode : 944 Easy
# https://leetcode.com/problems/delete-columns-to-make-sorted/description/
"""You are given an array of n strings strs, all of the same length.
The strings can be arranged such that there is one on each line, making a grid. For example, strs = ["abc", "bce", "cae"] can be arranged as:
abc
bce
cae
You want to delete the columns that are not sorted lexicographically. In the above example (0-indexed), columns 0 ('a', 'b', 'c') and 2 ('c', 'e', 'e') are sorted while column 1 ('b', 'c', 'a') is not, so you would delete column 1.
Return the number of columns that you will delete."""

def minDeletionSize(strs):
        n = len(strs[0])
        i = 0
        count = n
        while i < n:
            temp = []
            for j in strs:
                temp.append(j[i])
            if temp == sorted(temp):
                count = count -1 
            i += 1    
        return count

# Driver 
if __name__ == "__main__":
    inputs = [["cba","daf","ghi"],["a","b"],["zyx","wvu","tsr"]]  

    case = 0
    for strs in inputs:
        case += 1
        print(f"Case Number : {case}")
        print(f"Output : {minDeletionSize(strs)}")
        print("------------------------------------")      