def isValid(s):
    my_stack = []
    open_braces = ['(','{','[']
    m = []
    for i in s :
        m.append(i)
        s = m    
           
    my_dict = {')':'(','}':'{',']':'['} 
    
    for i in s:
        if i in open_braces:
            my_stack.append(i)
        else:
            if len(my_stack) == 0:
                return False
            elif my_stack[-1] == my_dict[i]:
                my_stack.pop()
            else:
                return False   
                    
    if len(my_stack) == 0:
        return True


if __name__ == "__main__":        
    input = ["()","()[]{}","(]"]
    case = 0
    for braces in input:
        case += 1
        print(f"Case Number : {case}")
        print(isValid(braces))
        print("___________________________________")