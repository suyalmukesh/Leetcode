# https://leetcode.com/problems/valid-palindrome/description/

# LeetCode 125 : Easy 
"""
A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.
Given a string s, return true if it is a palindrome, or false otherwise.
Example 1:
Input: s = "A man, a plan, a canal: Panama"
Output: true
Explanation: "amanaplanacanalpanama" is a palindrome.
Example 2:
Input: s = "race a car"
Output: false
Explanation: "raceacar" is not a palindrome."""

def isPalindrome(s):
    target =""
    for char in s:
        if char.isalnum():
            target = target+char
    target = target.lower()
        
    n = len(target)
    i = 0 
    j = n-1
    while (i < j):  # Two pointer Approach 
        if target[i] == target[j]:
            i += 1
            j -= 1
        else:
            return False
    return True


if __name__ == "__main__":
    Inputs = ["A man, a plan, a canal: Panama","race a car"," "]
    case = 0 
    for test_string in Inputs:
        case += 1
        print("case = {}".format(case))
        print(isPalindrome(test_string))
        print("________________________________")
