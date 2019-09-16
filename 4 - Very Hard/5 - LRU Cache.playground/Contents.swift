//Generic Linked List Node Class
class DoublyLinkedListNode
{
    let key: String
    let value: Int
    var previous: DoublyLinkedListNode?
    var next: DoublyLinkedListNode?
    
    init(key: String, value: Int)
    {
        self.key = key
        self.value = value
        self.previous = nil
        self.next = nil
    }
    
    func removeBindings()
    {
        if let previous = previous
        {
            previous.next = next
        }
        
        if let next = next
        {
            next.previous = previous
        }
        
        previous = nil
        next = nil
    }
}

//Generic Linked List Class
class DoublyLinkedList
{
    var head: DoublyLinkedListNode?
    var tail: DoublyLinkedListNode?
    
    init()
    {
        self.head = nil
        self.tail = nil
    }
    
    func setHeadTo(node: DoublyLinkedListNode)
    {
        if head === node
        {
            return
        }
        else if head === nil
        {
            head = node
            tail = node
        }
        else if head === tail
        {
            tail?.previous = node
            head = node
            head?.next = tail
        }
        else
        {
            if tail === node
            {
                removeTail()
            }
            
            node.removeBindings()
            head?.previous = node
            node.next = head
            head = node
        }
    }
    
    func removeTail()
    {
        if tail === nil
        {
            return
        }
        
        if head === tail
        {
            head = nil
            tail = nil
            return
        }
        
        tail = tail?.previous
        tail?.next = nil
    }
}

//LRU Cache
class LRUCache
{
    
}
