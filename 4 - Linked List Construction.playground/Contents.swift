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
        var node = self.head
        
        //Start a while loop that checks that node variable's value against the desired value
        while node != nil, node?.value != value
        {
            //Jump to the next node if it exists
            if let next = node?.next
            {
                node = next
            }
        }
        
        //Return true if we exit the while loop
        return true
    }
    
    //Removes Node from Linked List
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
    
    func removeNodesWithValue(value: Int)
    {
        var node = self.head
        
        while node != nil
        {
            let nodeToRemove = node
            node = node?.next
            
            if (nodeToRemove?.value == value)
            {
                remove(node: nodeToRemove!)
            }
        }
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
}
