//Generic Linked List Class
class LinkedList
{
    var value: Int
    var next: LinkedList?
    
    init(value: Int)
    {
        self.value = value
    }
    
    func addMany(values: [Int]) -> LinkedList
    {
        var current: LinkedList? = self
        
        while current?.next != nil
        {
            current = current?.next
        }
        
        for value in values
        {
            current?.next = LinkedList(value: value)
            current = current?.next
        }
        
        return self
    }
    
    func getNodesInArray() -> [Int]
    {
        var nodes = [Int]()
        var current: LinkedList? = self
        
        while current != nil
        {
            if let value = current?.value
            {
                nodes.append(value)
            }
            
            current = current?.next
        }
        
        return nodes
    }
}

//Reverse Linked List
//O(n) time | O(1) space
func reverseLinkedList(_ head: LinkedList) -> LinkedList
{
    var firstPointer: LinkedList? = nil
    var secondPointer: LinkedList? = head
    
    while secondPointer != nil
    {
        let thirdPointer = secondPointer?.next
        secondPointer?.next = firstPointer
        firstPointer = secondPointer
        secondPointer = thirdPointer
    }
    
    return firstPointer!
}

let test = LinkedList(value: 0)
let result = reverseLinkedList(test).getNodesInArray()
let expected = LinkedList(value: 0).getNodesInArray()
assert(result == expected)

func testReverseLinkedList(initialValue: Int, values: [Int], reversedInitialValue: Int, reversedValues: [Int])
{
    let test = LinkedList(value: initialValue).addMany(values: values)
    let result = reverseLinkedList(test).getNodesInArray()
    let expected = LinkedList(value: reversedInitialValue).addMany(values: reversedValues).getNodesInArray()
    assert(result == expected)
}

testReverseLinkedList(initialValue: 0, values: [1], reversedInitialValue: 1, reversedValues: [0])
testReverseLinkedList(initialValue: 0, values: [1, 2], reversedInitialValue: 2, reversedValues: [1, 0])
testReverseLinkedList(initialValue: 0, values: [1, 2, 3], reversedInitialValue: 3, reversedValues: [2, 1, 0])
testReverseLinkedList(initialValue: 0, values: [1, 2, 3, 4], reversedInitialValue: 4, reversedValues: [3, 2, 1, 0])
testReverseLinkedList(initialValue: 0, values: [1, 2, 3, 4, 5], reversedInitialValue: 5, reversedValues: [4, 3, 2, 1, 0])
testReverseLinkedList(initialValue: 0, values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], reversedInitialValue: 12, reversedValues: [11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0])
