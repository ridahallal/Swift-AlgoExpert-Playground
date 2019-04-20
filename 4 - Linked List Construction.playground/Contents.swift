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
    
    //Checks if Linked List contains node with value
    func containsNodeWithValue(value: Int) -> Bool
    {
        //If head exists, set a node variable
        if var node = self.head
        {
            //Start a while loop that checks that node variable's value against the desired value
            while node.value != value
            {
                //Jump to the next node if it exists
                if let next = node.next
                {
                    node = next
                }
                //Return false if we've reached the end of the list
                else
                {
                    return false
                }
            }
            
            //Return true if we exit the while loop
            return true
        }
        //If head doesn't exist
        else
        {
            //Return false
            return false
        }
    }
    
    //Removes Node from Linked List
    func remove(node: Node)
    {
        //If the node passed in to this function is equal to the head (we want to remove the head), we set the head to the next node
        if var head = self.head, let next = head.next, node == head
        {
            head = next
        }
        
        //If the node passed in to this function is equal to the tail (we want to remove the tail), we set the tail to the previous node
        if var tail = self.tail, let previous = tail.previous, node == tail
        {
            tail = previous
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
    
    func setHead(node: Node)
    {
        
    }
    
    func setTail(node: Node)
    {
        
    }
    
    func insertBefore(node: Node, nodeToInsert: Node)
    {
        
    }
    
    func insertAfter(node: Node, nodeToInsert: Node)
    {
        
    }
    
    func insertAtPosition(position: Int, nodeToInsert: Node)
    {
        
    }
    
    func removeNodesWithValue(value: Int)
    {
        
    }
}
