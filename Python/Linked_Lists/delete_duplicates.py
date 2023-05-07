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

    def delete_duplicates_1(self):
        if self.head is None:
            return None
        temp = self.head 
        if temp.next is None:
            return self.head 
        
        while temp and temp.next:
            if temp.val == temp.next.val:
                delete_node = temp.next
                temp.next = delete_node.next
                delete_node = None
            if temp.next:
                temp = temp.next       
        return self.head

    def delete_duplicates(self): 
        temp = self.head
        while (temp and temp.next):
            if (temp.next.val == temp.val):
                temp.next = temp.next.next
                continue
            temp = temp.next
        return self.head
        





if __name__ == "__main__":
  
    
    test_cases = [[1,2,3,3,4,5],[1],[1,1],[1,2,3,4,5,6,7,7],[1,1,1]]
    case = 1
    for input in test_cases:
        my_list = linked_list()
        print(f"Case :: {case}")
        for num in input:
            my_list.insert_last(num)
        my_list.display()
        print("\n")
        my_list.delete_duplicates()
        my_list.display()
        case += 1
        print("\n--------------------------------\n")
