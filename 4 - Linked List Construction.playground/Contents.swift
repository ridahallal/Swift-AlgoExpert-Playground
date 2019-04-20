//Generic Node class
class Node
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
    
    func containsNodeWithValue(value: Int) -> Bool
    {
        if var node = self.head
        {
            while node.value != value
            {
                if let next = node.next
                {
                    node = next
                }
                else
                {
                    return false
                }
            }
            
            return true
        }
        else
        {
            return false
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
    
    func removeNodesWithValue(value: Int)
    {
        
    }
    
    func remove(node: Node)
    {
        
    }
}
