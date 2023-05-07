class node:
    def __init__(self,data,next=None):
        self.data = data 
        self.next = next

class linked_list:
    def __init__(self):
        self.head = None
    
    def insert_last(self,data):
        new_node = node(data)
        if self.head is None:
            self.head = new_node
            return
        temp = self.head    
        while temp.next is not None:
            temp = temp.next
        temp.next = new_node 
        return self.head

    def insert_first(self,data):
        new_node = node(data)
        if self.head is None:
            self.head = new_node
            return self.head
        new_node.next = self.head
        self.head = new_node
        return self.head

    def display(self):
        if self.head is None:
            print("The List is empty")
            return
        temp = self.head
        while(temp):
            print(temp.data,end=" -> ") 
            temp = temp.next 
        print("NULL")

    def delete_first(self):
        if self.head is None:
            print("Nothing to delete ")
            return 
        temp = self.head 
        self.head = temp.next
        temp = None
        return self.head 

    def delete_last(self):
        if self.head is None: # when list is empty 
            print("Nothing to delete")
            return
        if self.head.next is None: # when only one node 
           self.head = None
           return None
        # for more then one node         
        temp = self.head
        while temp.next.next is not None:
            temp = temp.next
        temp.next = None
        return self.head

    def count(self):
        if self.head is None:
            return 0
        count = 0     
        temp = self.head
        while temp:
            count += 1
            temp = temp.next 
        return count               

    def insert_at_pos(self,pos,data):
        total = self.count()
        if pos > total + 1 or pos < 1:
           print("The position don't exists....")
           return 
        new_node = node(data)   
        if pos == 1:
           new_node.next = self.head
           self.head = new_node 
           return
        count = 1    
        temp = self.head
        while count < pos-1 and temp:
            temp = temp.next
            count += 1
        new_node.next = temp.next
        temp.next = new_node
        return self.head

    def _delete_n_from_last(self,n):
        if self.head is None:
            print("Nothing to delete") 
            return None
        count = 0 
        temp = self.head
        while temp:
            count+= 1
            temp = temp.next 

        if n > count:
            print("The position requested is not correct") 
            return self.head
        del_position = count - n 

        if del_position == 1 :
            temp = self.head
            self.head = temp.next 
            temp = None
            return self.head
        temp = self.head      
        counter = 1 
        while counter < del_position:
            temp = temp.next 
            counter += 1
        to_del = temp.next 
        temp.next = to_del.next
        to_del = None 
        return          
    
    def __delete_n_from_last(self,n):
        if head is None:
            return None 

        length = 0 
        temp = head 
        while temp:  ## Calculate length 
            length += 1
            temp = temp.next 

        position = length - n 

        if position == 0:
           temp = head 
           head = head.next
           temp = None
           return head 

        curr = head 
        prev = None 

        while position > 0:
            prev = curr 
            curr = curr.next 
            position = position - 1 
        
        prev.next = curr.next 
        curr = None 
        return head

    def delete_n_from_last(self,n):  ## slow and fast pointer approach 
        print("Slow & Fast pointer ")
        dummy = self.head
        slow = self.head
        fast = self.head 
        
        count = 0 
        
        while count < n:
            count += 1
            fast = fast.next
        
        while fast.next:
            fast = fast.next
            slow= slow.next

        temp = slow    
        del_node = slow.next
        temp.next = del_node.next
        return self.head
          




    def delete_nth_node(self,n):
        if self.head is None:
            print("List is empty ")
            return None
        if n == 1:
            temp = self.head
            self.head = temp.next
            temp = None 
            return self.head
        
        temp = self.head 
        count = 1 
        while count < n-1 and temp.next:
            temp = temp.next  
            count += 1
            print(f"Count : {count}")

        del_node = temp.next 
        print(f"deleting_node is : {del_node.data}")
        temp.next = del_node.next
        del_node = None
        return self.head     








   

if __name__ == "__main__":
    my_list = linked_list()
    print("Choose from the below options")
    while(1):
        print("\n1 : Insert at last")
        print("2 : Insert at first")
        print("3 : display")
        print("4 : delete first node")
        print("5 : delete last node")
        print("6 : Count elements")
        print("7 : insert at position")
        print("8 : delete nth node from last ")
        print("9 : delete nth n ode from front")
        print("0 : Exit")
        n = int(input("Option : "))

        if n == 1:
            num = input("Enter a value : ")
            my_list.insert_last(num)
            my_list.display() 
        elif n == 2:
            num = input("Enter a value : ")
            my_list.insert_first(num)
            my_list.display()
        elif n == 3:
            my_list.display()
        elif n == 4:
            my_list.delete_first()
            my_list.display()
        elif n == 5:
            my_list.delete_last()
            my_list.display()     
        elif n == 6 :
            print(my_list.count())
        elif n == 7:
            pos = int(input("Enter the position"))
            num = int(input("Enter the value"))
            my_list.insert_at_pos(pos,num)
            my_list.display()    
        elif n == 8:
            n = int(input("Enter the position from last "))
            my_list.delete_n_from_last(n)
            my_list.display()
        elif n == 9:
            n = int(input("Enter the position to be deleted.... "))
            my_list.delete_nth_node(n)
            my_list.display()
        elif n == 0:
            break






