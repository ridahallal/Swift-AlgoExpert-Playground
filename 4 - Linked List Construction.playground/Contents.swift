//Generic Node class
class Node: Equatable
{
    var value: Int
    var previous: Node?
    var next: Node?
    
    init(value: Int)
    {
        self.value = value
        self.previous = nil
        self.next = nil
    }
    
    //Equatable protocol conformance
    static func == (lhs: Node, rhs: Node) -> Bool
    {
        let equalValue = lhs.value == rhs.value
        let equalPrevious = lhs.previous == rhs.previous
        let equalNext = lhs.next == rhs.next
        
        return equalValue && equalPrevious && equalNext
    }
}

//Generic Linked List class
class DoublyLinkedList
{
    var head: Node?
    var tail: Node?
    
    init()
    {
        self.head = nil
        self.tail = nil
    }
    
    //Checks if Linked List contains node with value --- O(N) time | O(1) space
    func containsNodeWithValue(value: Int) -> Bool
    {
        //Traverse the Linked List
        var node = self.head
        
        //Start a while loop that checks that node variable's value against the desired value
        while node != nil, node?.value != value
        {
            //Jump to the next node if it exists
            if let next = node?.next
            {
                node = next
            }
            //If we've reached the tail return false
            else
            {
                return false
            }
        }
        
        //Return true if we exit the while loop
        return true
    }
    
    //Removes Node from Linked List --- O(1) time | O(1) space
    func remove(node: Node)
    {
        //If the node passed in to this function is equal to the head (we want to remove the head), we set the head to the next node
        if node == self.head
        {
            self.head = self.head?.next
        }
        
        //If the node passed in to this function is equal to the tail (we want to remove the tail), we set the tail to the previous node
        if node == self.tail
        {
            self.tail = self.tail?.previous
        }
        
        //Remove node bindings
        removeNodeBindings(node: node)
    }
    
    //Removes node bindings
    func removeNodeBindings(node: Node)
    {
        //If the node passed in has a previous node
        if let previous = node.previous
        {
            //Remove the gap between these nodes by setting the previous node's next to the nodes' next
            previous.next = node.next
        }
        
        //If the node passed in has a next node
        if let next = node.next
        {
            //Remove the gap between these nodes by setting the next node's previous to the node's previous
            next.previous = node.previous
        }
        
        //Kill the node's previous and next bindings
        node.previous = nil
        node.next = nil
    }
    
    //Removes nodes having a certain value --- O(N) time | O(1) space
    func removeNodesWithValue(value: Int)
    {
        //Traverse the Linked List
        var node = self.head
        
        //Keep going until we reach the end
        while node != nil
        {
            //Create nodeToRemove constant and give it the value of the current node
            let nodeToRemove = node
            
            //Update the value of the current node
            node = node?.next
            
            //If nodeToRemove's value is the desired value
            if nodeToRemove?.value == value
            {
                //Call our Remove Node function
                remove(node: nodeToRemove!)
            }
        }
    }
    
    //Inserts a node before a specified node --- O(1) time | O(1) space
    func insertBefore(node: Node, nodeToInsert: Node)
    {
        //If our Linked List only has one node and we pass that node to the function
        if nodeToInsert == self.head && nodeToInsert == self.tail
        {
            //Just return (no-op)
            return
        }
        
        //Shed the nodeToInsert's bindings and update its surrounding nodes
        self.remove(node: nodeToInsert)
        
        //Since we are inserting before a specified node, update the nodeToInsert's previous and next accordingly
        nodeToInsert.previous = node.previous
        nodeToInsert.next = node
        
        //If the specified node has no previous (we are at the head)
        if node.previous == nil
        {
            //Set the head to nodeToInsert
            self.head = nodeToInsert
        }
        //If the specified node has a previous node
        else
        {
            //Update that previous node's next to be nodeToInsert
            node.previous?.next = nodeToInsert
        }
        
        //Insert nodeToInsert before specified node
        node.previous = nodeToInsert
    }
    
    //Inserts a node after a specified node --- O(1) time | O(1) space
    func insertAfter(node: Node, nodeToInsert: Node)
    {
        //If our Linked List only has one node and we pass that node to the function
        if nodeToInsert == self.head && nodeToInsert == self.tail
        {
            //Just return (no-op)
            return
        }
        
        //Shed the nodeToInsert's bindings and update its surrounding nodes
        self.remove(node: nodeToInsert)
        
        //Since we are inserting after a specified node, update the nodeToInsert's previous and next accordingly
        nodeToInsert.previous = node
        nodeToInsert.next = node.next
        
        //If the specified node has no next (we are at the tail)
        if node.next == nil
        {
            //Set the tail to nodeToInsert
            self.tail = nodeToInsert
        }
        //If the specified node has a next value
        else
        {
            //Update the next node's previous to be nodeToInsert
            node.next?.previous = nodeToInsert
        }
        
        //Insert nodeToInsert after specified node
        node.next = nodeToInsert
    }
    
    //Sets the Linked List's head --- O(1) time | O(1) space
    func setHead(node: Node)
    {
        //If our Linked List is empty
        if self.head == nil
        {
            //Set both head and tail to the node
            self.head = node
            self.tail = node
            
            return
        }
        
        //Otherwise, use our insertBefore function and insert the node before our current head
        insertBefore(node: self.head!, nodeToInsert: node)
    }
    
    //Sets the Linked List's tail --- O(1) time | O(1) space
    func setTail(node: Node)
    {
        //If our Linked List is empty
        if self.tail == nil
        {
            //Call our setHead function which will take care of updating both head and tail
            self.setHead(node: node)
            
            return
        }
        
        //Otherwise, use our insertAfter function and insert the node after our current tail
        insertAfter(node: self.tail!, nodeToInsert: node)
    }
    
    //Inserts a node at a specified position --- O(P) time | O(1) space
    func insertAtPosition(position: Int, nodeToInsert: Node)
    {
        //If the specified position is 1, just call our setHead function
        if position == 1
        {
            self.setHead(node: nodeToInsert)
            
            return
        }
        
        //Traverse the Linked List
        var node = self.head
        
        //Keep track of our current position
        var currentPosition = 1
        
        //Keep going until we reach the end or the desired position
        while node != nil && currentPosition != position
        {
            node = node?.next
            currentPosition = currentPosition + 1
        }
        
        //If there exists a node at the desired position
        if node != nil
        {
            //Use our insertBefore function and insert the node before that node
            insertBefore(node: node!, nodeToInsert: nodeToInsert)
        }
        //If we've reached the end
        else
        {
            //Just append the node to the end of the Linked List
            setTail(node: nodeToInsert)
        }
    }
}

//Tests

//Asserts that the Linked List is empty
func expectEmpty(linkedList: DoublyLinkedList)
{
    assert(linkedList.head == nil)
    assert(linkedList.tail == nil)
}

//Asserts that the Linked List's head and tail are equal to given values
func expectHeadTail(linkedList: DoublyLinkedList, head: Node, tail: Node)
{
    assert(linkedList.head == head)
    assert(linkedList.tail == tail)
}

//Asserts that the Linked List contains only one node
func expectSingleNode(linkedList: DoublyLinkedList, node: Node)
{
    assert(linkedList.head == node)
    assert(linkedList.tail == node)
}

//Returns node values from head to tail
func getNodeValuesHeadToTail(linkedList: DoublyLinkedList) -> [Int]
{
    var values = [Int]()
    
    var node = linkedList.head
    
    while node != nil
    {
        values.append(node?.value)
        node = node?.next
    }
    
    return values
}

func getNodeValuesTailToHead(linkedList: DoublyLinkedList) -> [Int]
{
    var values = [Int]()
    
    var node = linkedList.tail
    
    while node != nil
    {
        values.append(node?.value)
        node = node?.previous
    }
    
    return values
}

func removeNodes(linkedList: DoublyLinkedList, nodes: [Node])
{
    for node in nodes
    {
        linkedList.remove(node: node)
    }
}
