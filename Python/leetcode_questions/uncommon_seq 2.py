def findLUSlength(a, b):
    def findLUSlength(self, a, b):
        if a == b:
            return -1 
        if len(a) <= len(b):
            min = a
            max = b
        else:
            min = b
            max = a
        
        if max not in min:
            return len(max)    
        elif min not in max:
            return len(min)
   
        for i in range(len(min)):
            j = len(min) - i
            slice = min[i:j]
            if slice not in max:
                return len(slice)

        return -1





if __name__ == "__main__":
    inputs = [["abc","cdc"],["aaa","bbb"],["aaa","aaa"]]
    case = 0
    for pair in inputs:
        case += 1
        print(pair)
        a,b = pair[0],pair[1]
        print(findLUSlength(a,b))
        print("______________________________________________________")  


