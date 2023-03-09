class node:
    def __init__ (self,data,next=None):
        self.data = data
        self.next = next

class linked_list:
    def __init__(self):
        self.head = None 
    
    def insert(self,data):
        new_node = node(data)
        if(self.head is None):
            self.head = new_node
        else:
            current = self.head
            while(current.next):
                current = current.next
            current.next = new_node        

    def print_list(self):
        current = self.head
        while current:
            print(current.data,end=' -> ') 
            current = current.next 

    def delete_key(self,num):
        temp = self.head
        
        if temp is not None: # If head node itself holds the num to be deleted 
            if temp.data == num:
                self.head = temp.next
                temp = None
                return self.head

        while temp is not None:
            if temp.data == num:
                break 
            prev = temp
            temp = temp.next
        
        if temp == None:
            return 
        prev.next = temp.next
        temp = None





new_list = linked_list()
new_list.insert(6)
new_list.insert(5)
new_list.insert(10)

new_list.print_list()
print(".....")
new_list.delete_key(15)
new_list.print_list()