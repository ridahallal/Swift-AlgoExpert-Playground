//Generic Linked List Node Class
class DoublyLinkedListNode
{
    let key: String
    var value: Int
    var previous: DoublyLinkedListNode?
    var next: DoublyLinkedListNode?
    
    init(_ key: String, _ value: Int)
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
    
    func setHeadTo(_ node: DoublyLinkedListNode)
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
    var maxSize: Int
    var currentSize = 0
    var cache = [String: DoublyLinkedListNode]()
    var listOfMostRecent = DoublyLinkedList()
    
    init(maxSize: Int)
    {
        self.maxSize = maxSize
    }
    
    //O(1) time | O(1) space
    func insertKeyValuePair(_ key: String, _ value: Int)
    {
        if !cache.keys.contains(key)
        {
            if currentSize == maxSize
            {
                evictLeastRecent()
            }
            else
            {
                currentSize += 1
            }
            
            cache[key] = DoublyLinkedListNode(key, value)
        }
        else if let existingNode = cache[key]
        {
            existingNode.value = value
        }
        
        if let node = cache[key]
        {
            updateMostRecent(node)
        }
    }
    
    func evictLeastRecent()
    {
        if let key = listOfMostRecent.tail?.key
        {
            listOfMostRecent.removeTail()
            cache[key] = nil
        }
    }
    
    func updateMostRecent(_ node: DoublyLinkedListNode)
    {
        listOfMostRecent.setHeadTo(node)
    }
    
    //O(1) time | O(1) space
    func getValueFormKey(_ key: String) -> Int?
    {
        if let existingNode = cache[key]
        {
            updateMostRecent(existingNode)
            return existingNode.value
        }
        else
        {
            return nil
        }
    }
    
    //O(1) time | O(1) space
    func getMostRecentKey() -> String?
    {
        return listOfMostRecent.head?.key
    }
}

//Tests
let letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]
let letterMaps = ["a": 0, "b": 1, "c": 2, "d": 3, "e": 4, "f": 5, "g": 6, "h": 7, "i": 8, "j": 9]

func testLruOfSize(_ size: Int)
{
    //Instantiate cache and insert first key
    let lru = LRUCache(maxSize: size)
    assert(lru.getValueFormKey("a") == nil)
    lru.insertKeyValuePair("a", 99)
    assert(lru.getMostRecentKey() == "a")
    assert(lru.getValueFormKey("a") == 99)
    
    //Add existing key when cache isn't full
    lru.insertKeyValuePair("a", 0)
    assert(lru.getMostRecentKey() == "a")
    assert(lru.getValueFormKey("a") == 0)
    
    //Add keys until cache reaches maximum capacity
    for i in stride(from: 1, to: size, by: 1)
    {
        let mostRecentLetter = letters[i - 1]
        assert(lru.getMostRecentKey() == mostRecentLetter)
        
        //Test key retrieval when cache isn't full
        for j in stride(from: 0, to: 1, by: 1)
        {
            let letter = letters[j]
            assert(lru.getValueFormKey(letter) == letterMaps[letter])
            assert(lru.getMostRecentKey() == letter)
        }
        
        let currentLetter = letters[i]
        assert(lru.getValueFormKey(currentLetter) == nil)
        lru.insertKeyValuePair(currentLetter, letterMaps[currentLetter]!)
        assert(lru.getMostRecentKey() == currentLetter)
        assert(lru.getValueFormKey(currentLetter) == letterMaps[currentLetter])
    }
    
    //Add keys now that cache is at maximum capacity
    for i in stride(from: size, to: letters.count, by: 1)
    {
        let mostRecentLetter = letters[i - 1]
        assert(lru.getMostRecentKey() == mostRecentLetter)
        
        //Test key retrieval when cache is full
        for j in stride(from: i - size, to: i, by: 1)
        {
            let letter = letters[j]
            assert(lru.getValueFormKey(letter) == letterMaps[letter])
            assert(lru.getMostRecentKey() == letter)
        }
        
        let leastRecentLetter = letters[i - size]
        let currentLetter = letters[i]
        assert(lru.getValueFormKey(currentLetter) == nil)
        lru.insertKeyValuePair(currentLetter, letterMaps[currentLetter]!)
        assert(lru.getMostRecentKey() == currentLetter)
        assert(lru.getValueFormKey(currentLetter) == letterMaps[currentLetter])
        assert(lru.getValueFormKey(leastRecentLetter) == nil)
    }
    
    //Add existing keys
    for i in letters.count - size ..< letters.count
    {
        let currentLetter = letters[i]
        assert(lru.getValueFormKey(currentLetter) == letterMaps[currentLetter])
        lru.insertKeyValuePair(currentLetter, (letterMaps[currentLetter]! + 1) * 100)
        assert(lru.getValueFormKey(currentLetter) == (letterMaps[currentLetter]! + 1) * 100)
    }
}

testLruOfSize(1)
testLruOfSize(2)
testLruOfSize(3)
testLruOfSize(4)
testLruOfSize(5)
testLruOfSize(6)
testLruOfSize(7)
testLruOfSize(8)
testLruOfSize(9)
testLruOfSize(10)
