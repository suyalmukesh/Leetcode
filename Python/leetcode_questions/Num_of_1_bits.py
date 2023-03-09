def hammingWeight(n):
        count = 0
        # Loop until n is 0
        while n != 0:
            # If the last bit of n is 1, increment the counter
            if n & 1 == 1:
                count += 1
            # Shift n to the right by 1 bit
            n = n >> 1
        # Return the counter
        return count

if __name__ == "__main__":
    inputs = [00000000000000000000000000001011,00000000000000000000000010000000,11111111111111111111111111111101]
    case = 0 
    for binary in inputs: 
        case += 1
        print(f"Case : {case}")
        hammingWeight(binary)
        print("_____________________________________________________")
