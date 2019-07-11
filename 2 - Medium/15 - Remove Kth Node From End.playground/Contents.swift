//Generic Linked List Class
class LinkedList
{
    var value: Int?
    var next: LinkedList?
    
    init(value: Int)
    {
        self.value = value
        self.next = nil
    }
    
    func addMany(values: [Int]) -> LinkedList
    {
        var current = self
        
        while current.next != nil
        {
            current = current.next!
        }
        
        for value in values
        {
            current.next = LinkedList(value: value)
            current = current.next!
        }
        
        return self
    }
    
    func getNodesInArray() -> [Int]
    {
        var nodes = [Int]()
        
        var current: LinkedList? = self
        
        while current != nil
        {
            nodes.append(current!.value!)
            current = current!.next
        }
        
        return nodes
    }
}

//Remove Kth Node From End
//O(n) time | O(1) space
func removeKthNodeFromEnd(head: LinkedList, k: Int)
{
    var counter = 1
    
    var firstPointer: LinkedList? = head
    var secondPointer: LinkedList? = head
    
    while counter <= k
    {
        secondPointer = secondPointer?.next
        counter += 1
    }
    
    if secondPointer == nil
    {
        head.value = head.next?.value
        head.next = head.next?.next
        
        return
    }
    
    while secondPointer?.next != nil
    {
        firstPointer = firstPointer?.next
        secondPointer = secondPointer?.next
    }
    
    firstPointer?.next = firstPointer?.next?.next
}

//Tests
var firstTest = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
var firstResult = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8])
removeKthNodeFromEnd(head: firstTest, k: 1)
assert(firstTest.getNodesInArray() == firstResult.getNodesInArray())

var secondTest = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
var secondResult = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 9])
removeKthNodeFromEnd(head: secondTest, k: 2)
assert(secondTest.getNodesInArray() == secondResult.getNodesInArray())

var thirdTest = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
var thirdResult = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 8, 9])
removeKthNodeFromEnd(head: thirdTest, k: 3)
assert(thirdTest.getNodesInArray() == thirdResult.getNodesInArray())

var fourthTest = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
var fourthResult = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 7, 8, 9])
removeKthNodeFromEnd(head: fourthTest, k: 4)
assert(fourthTest.getNodesInArray() == fourthResult.getNodesInArray())

var fifthTest = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
var fifthResult = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 6, 7, 8, 9])
removeKthNodeFromEnd(head: fifthTest, k: 5)
assert(fifthTest.getNodesInArray() == fifthResult.getNodesInArray())

var sixthTest = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
var sixthResult = LinkedList(value: 0).addMany(values: [1, 2, 3, 5, 6, 7, 8, 9])
removeKthNodeFromEnd(head: sixthTest, k: 6)
assert(sixthTest.getNodesInArray() == sixthResult.getNodesInArray())

var seventhTest = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
var seventhResult = LinkedList(value: 0).addMany(values: [1, 2, 4, 5, 6, 7, 8, 9])
removeKthNodeFromEnd(head: seventhTest, k: 7)
assert(seventhTest.getNodesInArray() == seventhResult.getNodesInArray())

var eighthTest = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
var eighthResult = LinkedList(value: 0).addMany(values: [1, 3, 4, 5, 6, 7, 8, 9])
removeKthNodeFromEnd(head: eighthTest, k: 8)
assert(eighthTest.getNodesInArray() == eighthResult.getNodesInArray())

var ninthTest = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
var ninthResult = LinkedList(value: 0).addMany(values: [2, 3, 4, 5, 6, 7, 8, 9])
removeKthNodeFromEnd(head: ninthTest, k: 9)
assert(ninthTest.getNodesInArray() == ninthResult.getNodesInArray())

var tenthTest = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
var tenthResult = LinkedList(value: 1).addMany(values: [2, 3, 4, 5, 6, 7, 8, 9])
removeKthNodeFromEnd(head: tenthResult, k: 10)
assert(tenthResult.getNodesInArray() == tenthResult.getNodesInArray())
