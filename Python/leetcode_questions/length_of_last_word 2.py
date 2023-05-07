def lengthOfLastWord(s):
    my_list = []
    s = s.strip()
    my_list = s.split(" ")
    return len(my_list[-1])