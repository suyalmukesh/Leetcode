def detectCapitalUse(word):
    if word in (word.capitalize(),word.lower(), word.upper()):
        return True
    return False    



if __name__ == "__main__":
    inputs = ["USA","leetcode","Google","FlaG"]
    case = 0 
    for word in inputs:
        case += 1
        print(f"Case Number : {case}")
        print(detectCapitalUse(word))    