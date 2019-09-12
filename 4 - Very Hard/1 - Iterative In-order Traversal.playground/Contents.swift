//Generic Binary Tree class
class BinaryTree
{
    let value: Int
    let parent: BinaryTree?
    var left: BinaryTree? = nil
    var right: BinaryTree? = nil
    
    init(value: Int, parent: BinaryTree?)
    {
        self.value = value
        self.parent = parent
    }
    
    func insert(values: [Int], index: Int) -> BinaryTree?
    {
        if index >= values.count { return nil }
        
        var queue: [BinaryTree?] = [self]
        
        while queue.count > 0
        {
            let current = queue.removeFirst()
            
            if current?.left === nil
            {
                current?.left = BinaryTree(value: values[index], parent: current)
                break
            }
            
            queue.append(current?.left)
            
            if current?.right === nil
            {
                current?.right = BinaryTree(value: values[index], parent: current)
                break
            }
            
            queue.append(current?.right)
        }
        
        insert(values: values, index: index + 1)
        return self
    }
}

//Iterative In-order Traversal
//O(n) time | O(1) space
func iterativeInOrderTraversal(_ tree: BinaryTree, _ callback: (BinaryTree) -> (Void))
{
    var previousNode: BinaryTree?
    var currentNode: BinaryTree? = tree
    
    //While we haven't reached the tree's parent
    while currentNode !== nil
    {
        //Temporary next node variable
        let nextNode: BinaryTree?
        
        //If we are moving downwards
        if previousNode === nil || previousNode === currentNode?.parent
        {
            //If we have a left node, continue exploring
            if currentNode?.left !== nil
            {
                nextNode = currentNode?.left
            }
            //Otherwise we are a the left most position, callback on current node and move to right node (if available)
            else
            {
                callback(currentNode!)
                nextNode = currentNode?.right !== nil ? currentNode?.right : currentNode?.parent
            }
        }
        //If we are moving upwards from the left direction
        else if previousNode === currentNode?.left
        {
            callback(currentNode!)
            nextNode = currentNode?.right !== nil ? currentNode?.right : currentNode?.parent
        }
        //If we are moving upwards from the right direction
        else
        {
            //We want to flip the currentNode and the previousNode, so we set next node to be the currentNode.parent
            nextNode = currentNode?.parent
        }
        
        //Update previous and current nodes
        previousNode = currentNode
        currentNode = nextNode
    }
}

//Tests
var testArray = [Int]()

func testCallback(_ tree: BinaryTree)
{
    testArray.append(tree.value)
}

let firstTest = BinaryTree(value: 1, parent: nil)
let secondTest = BinaryTree(value: 1, parent: nil).insert(values: [2, 3, 4], index: 0)
let thirdTest = BinaryTree(value: 1, parent: nil).insert(values: [2, 3, 4, 5, 6, 7], index: 0)
let fourthTest = BinaryTree(value: 1, parent: nil).insert(values: [2, 3, 4, 5, 6, 7, 8, 9, 10], index: 0)
let fifthTest = BinaryTree(value: 1, parent: nil).insert(values: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], index: 0)
let sixthTest = BinaryTree(value: 1, parent: nil).insert(values: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], index: 0)

testArray = []
iterativeInOrderTraversal(firstTest, testCallback(_:))
assert(testArray == [1])

testArray = []
iterativeInOrderTraversal(secondTest!, testCallback(_:))
assert(testArray == [4, 2, 1, 3])

testArray = []
iterativeInOrderTraversal(thirdTest!, testCallback(_:))
assert(testArray == [4, 2, 5, 1, 6, 3, 7])

testArray = []
iterativeInOrderTraversal(fourthTest!, testCallback(_:))
assert(testArray == [8, 4, 9, 2, 10, 5, 1, 6, 3, 7])

testArray = []
iterativeInOrderTraversal(fifthTest!, testCallback(_:))
assert(testArray == [8, 4, 9, 2, 10, 5, 11, 1, 12, 6, 13, 3, 7])

testArray = []
iterativeInOrderTraversal(sixthTest!, testCallback(_:))
assert(testArray == [16, 8, 17, 4, 18, 9, 2, 10, 5, 11, 1, 12, 6, 13, 3, 14, 7, 15])
