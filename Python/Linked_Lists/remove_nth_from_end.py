class node:
    def __init__(self,data,next=None):
        self.data = data
        self.next = next

class linked_list:
    def __init__(self):
        self.head = None

    def insert_at_last(self,num):
        new_node = node(num)
        if self.head is None:
           self.head = new_node
        else:
            current = self.head
            while current.next != None:
                current = current.next
            current.next = new_node

    def insert_at_first(self,num):
        new_node = node(num)
        if self.head is None:
            self.head = new_node
        else:
            new_node.next = self.head
            self.head =new_node

    def insert_at_position(self,pos,num):
        if pos < 1 :
            print(f"\n{pos} is Invalid position")
            return
        print(f"\nInserting at position : {pos}")    
        new_node = node(num)
        if pos == 1:
            new_node.next = self.head
            self.head = new_node
            return   
        count = 1
        temp = self.head 
        while temp.next and count < pos:
            count += 1
            prev = temp
            temp = temp.next
        
        prev.next = new_node
        new_node.next = temp
        return

    def delete_at_first(self):
        if self.head is None:
            print("\nNothing to delete")
            return
        print("\ndeleting first node")    
        temp = self.head
        self.head = temp.next
        temp = None
        return

    def delete_at_last(self):
        if self.head is None:
            print("Nothing to delete")
            return
        print("\nDeleting the last node")    
        
        temp = self.head
        while temp.next:
            prev = temp
            temp = temp.next
        prev.next = None
        return       

    def display(self):
        current = self.head
        if current is None:
            print("List is empty")
        while current:
            print(current.data,end=" --> ")
            current = current.next
   


if __name__ == "__main__":

    a = linked_list()
    a.display()
    a.insert_at_first(0)
    a.insert_at_last(5)
    a.insert_at_last(10)
    a.insert_at_last(15)
    a.insert_at_first(12)
    a.insert_at_position(3,19)
    a.display()
    a.insert_at_position(1,219)
    a.display()
    a.insert_at_position(0,302)
    a.display()
    a.delete_at_first()
    a.display()
    a.delete_at_first()
    a.display()
    a.delete_at_last()
    a.display()


                        