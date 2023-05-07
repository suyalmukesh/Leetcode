class node:
    def __init__(self,val,next=None):
        self.val = val 
        self.next = next

class linked_list:
    def __init__(self):
        self.head = None
    
    def insert_last(self,n):
        new_node = node(n)
        if self.head is None:
            self.head = new_node
            return self.head 
        temp = self.head 
        while temp.next:
            temp = temp.next 
        temp.next = new_node
        return self.head         

    def count(self):
        if self.head is None:
            return 0 
        counter = 0 
        temp = self.head
        while temp:
            counter += 1
            temp= temp.next 
        return counter

    def display(self):
        if self.head is None:
            print("\nThe List is empty !!")
            return None
        temp = self.head 
        while temp:
            print(temp.val,end=" --> ")
            temp = temp.next 

    def delete_n_from_last(self,n):  ## Implement using 2 pointer approach 
        if self.head is None:
            return None
        slow = self.head
        fast = self.head 

        while fast and fast.next:
            pre = slow 
            slow = slow.next
            fast = fast.next.next 
             
        pre.next = pre.next.next 
        return self.head
        
    def delete_duplicates(self):
        pass

    def reverse_list(self):
        
        ## [1] -> [2] -> [3] -> [4] -> [5] -> NULL 

        prev = node(None,None)
        curr = self.head 
        after = curr.next

        while curr:
            curr.next = prev 
            prev = curr
            curr  = after

            if after:
                after = after.next 
            
        self.head = prev
        return prev







    


    def detect_cycle(self):   ## Implement using 2 pointer approach 
        pass
    def return_cycled_node(self):  ## Implement using 2 pointer approach 
        pass
    def intersection_node(self):  ## Implement using 2 pointer approach 
        pass
        



if __name__ == "__main__":
    my_list = linked_list()
    print("Choose from the below options")
    while(1):
        print("\n1 : Insert at last")
        print("2 : display")
        print("3 : Count elements")
        print("4 : delete nth node from last ")
        print("5 : reverse linked list ")
        print("0 : Exit")
        n = int(input("Option : "))

        if n == 1:
            num = input("Enter a value : ")
            my_list.insert_last(num)
            my_list.display() 
        elif n == 2:
            my_list.display()
        elif n == 3 :
            print(f"The count is : {my_list.count()}")
        elif n == 4:
            n = int(input("Enter the position from last "))
            my_list.delete_n_from_last(n)
            my_list.display()
        elif n == 5:
            my_list.reverse_list()
            my_list.display()    
        elif n == 0:
            break

