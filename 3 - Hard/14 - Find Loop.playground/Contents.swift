//Generic Singly Linked List Class
class LinkedList
{
    var value: Int
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
            if let next = current.next
            {
                current = next
            }
        }
        
        for value in values
        {
            current.next = LinkedList(value: value)
            
            if let next = current.next
            {
                current = next
            }
        }
        
        return self
    }
    
    func getNthNode(n: Int) -> LinkedList
    {
        var counter = 1
        var current = self
        
        while counter < n
        {
            counter += 1
            
            if let next = current.next
            {
                current = next
            }
        }
        
        return current
    }
}

//Find Loop
//O(n) time | O(1) space
func findLoop(head: LinkedList) -> LinkedList?
{
    var firstPointer = head.next
    var secondPointer = head.next?.next
    
    while firstPointer !== secondPointer
    {
        firstPointer = firstPointer?.next
        secondPointer = secondPointer?.next?.next
    }
    
    firstPointer = head
    
    while firstPointer !== secondPointer
    {
        firstPointer = firstPointer?.next
        secondPointer = secondPointer?.next
    }
    
    return firstPointer
}

//Tests
let test1 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test1.getNthNode(n: 10).next = test1.getNthNode(n: 1)

let test2 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test2.getNthNode(n: 10).next = test2.getNthNode(n: 2)

let test3 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test3.getNthNode(n: 10).next = test3.getNthNode(n: 3)

let test4 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test4.getNthNode(n: 10).next = test4.getNthNode(n: 4)

let test5 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test5.getNthNode(n: 10).next = test5.getNthNode(n: 5)

let test6 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test6.getNthNode(n: 10).next = test6.getNthNode(n: 6)

let test7 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test7.getNthNode(n: 10).next = test7.getNthNode(n: 7)

let test8 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test8.getNthNode(n: 10).next = test8.getNthNode(n: 8)

let test9 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test9.getNthNode(n: 10).next = test9.getNthNode(n: 9)

let test10 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test10.getNthNode(n: 10).next = test10.getNthNode(n: 10)

let test11 = LinkedList(value: 0).addMany(values: [1, 2, 3, 4, 5, 6, 7, 8, 9])
test11.getNthNode(n: 10).next = test11.getNthNode(n: 0)

assert(findLoop(head: test1) === test1.getNthNode(n: 1))
assert(findLoop(head: test2) === test2.getNthNode(n: 2))
assert(findLoop(head: test3) === test3.getNthNode(n: 3))
assert(findLoop(head: test4) === test4.getNthNode(n: 4))
assert(findLoop(head: test5) === test5.getNthNode(n: 5))
assert(findLoop(head: test6) === test6.getNthNode(n: 6))
assert(findLoop(head: test7) === test7.getNthNode(n: 7))
assert(findLoop(head: test8) === test8.getNthNode(n: 8))
assert(findLoop(head: test9) === test9.getNthNode(n: 9))
assert(findLoop(head: test10) === test10.getNthNode(n: 10))
assert(findLoop(head: test11) === test11.getNthNode(n: 0))
