https://leetcode.com/problems/swap-nodes-in-pairs/description/

24. Swap Nodes in Pairs
Medium
9.3K
358
company
Amazon
company
Microsoft
company
Adobe
Given a linked list, swap every two adjacent nodes and return its head. You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)

 

Example 1:


Input: head = [1,2,3,4]
Output: [2,1,4,3]
Example 2:

Input: head = []
Output: []
Example 3:

Input: head = [1]
Output: [1]



# -------------------------------------------

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution(object):
    def swapPairs(self, head):
       
        dummy = ListNode(None,head)
        prev = dummy 
        curr = head 

        while curr and curr.next:
            prev.next = curr.next 
            curr.next = curr.next.next
            prev.next.next = curr

            prev = curr
            curr = curr.next
        return dummy.next    


## dummy -->  [] --> []  -->  [] --> [] --> [] --> NULL 




