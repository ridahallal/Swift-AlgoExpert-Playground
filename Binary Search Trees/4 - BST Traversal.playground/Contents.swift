//Generic Iterative BST Class
class IterativeBST
{
    var value: Int?
    var left: IterativeBST?
    var right: IterativeBST?
    
    init(value: Int)
    {
        self.value = value
        self.left = nil
        self.right = nil
    }
    
    //Average: O(log(n)) time | O(1) space
    //Worst: O(n) time | O(1) space
    func insert(value: Int) -> IterativeBST
    {
        var currentNode: IterativeBST? = self
        
        while true
        {
            //If the value to insert is less than the current node's value
            if let node = currentNode, let currentNodeValue = node.value, value < currentNodeValue
            {
                //If the current node doesn't have a left node
                if node.left === nil
                {
                    //Just set the current node's left node to a new node with the value that we want to insert and break
                    node.left = IterativeBST(value: value)
                    break
                }
                else
                {
                    //Set current node to be equal to that left node
                    currentNode = node.left
                }
            }
                //If the value to insert is greater than the current node's value
            else if let node = currentNode
            {
                //If the current node doesn't have a right node
                if node.right === nil
                {
                    //Just set the current node's right node to a new node with the value that we want to insert and break
                    node.right = IterativeBST(value: value)
                    break
                }
                else
                {
                    //Set current node to be equal to that right node
                    currentNode = node.right
                }
            }
        }
        
        return self
    }
    
    //Average: O(log(n)) time | O(1) space
    //Worst: O(n) time | O(1) space
    func contains(value: Int) -> Bool
    {
        var currentNode: IterativeBST? = self
        
        while currentNode !== nil
        {
            //If the value we're searching for is less than the current node's value
            if let node = currentNode, let selfValue = node.value, value < selfValue
            {
                //Set current node to be equal to its left node
                currentNode = node.left
            }
                //If the value we're searching for is greater than the current node's value
            else if let node = currentNode, let selfValue = node.value, value > selfValue
            {
                //Set current node to be equal to its right node
                currentNode = node.right
            }
                //If the value we're searching for is equal than the current node's value
            else
            {
                //The BST does actually contain the value
                return true
            }
        }
        
        return false
    }
    
    //Average: O(log(n)) time | O(1) space
    //Worst: O(n) time | O(1) space
    func remove(value: Int?, parentNode: IterativeBST?) -> IterativeBST
    {
        var currentNode: IterativeBST? = self
        var parentNode: IterativeBST? = parentNode
        
        while currentNode !== nil
        {
            //If the value we're searching for is less than the current node's value
            if let node = currentNode, let selfValue = node.value, let valueToRemove = value, valueToRemove < selfValue
            {
                parentNode = currentNode
                currentNode = currentNode?.left
            }
                //If the value we're searching for is greater than the current node's value
            else if let node = currentNode, let selfValue = node.value, let valueToRemove = value, valueToRemove > selfValue
            {
                parentNode = currentNode
                currentNode = currentNode?.right
            }
                //If the value we're searching for is equal than the current node's value
            else if let node = currentNode
            {
                //If the current node has both left and right nodes
                if let _ = left, let right = right
                {
                    //Set the current node's value to the right node's minimum value
                    node.value = right.getMinValue()
                    
                    //Remove that value from the right node
                    right.remove(value: value, parentNode: node)
                }
                    //The case of the first node
                else if parentNode === nil
                {
                    //If the current node has a left node
                    if let node = currentNode, let left = left
                    {
                        //Set the current node's value to that node's value
                        node.value = left.value
                        
                        //Set the current node's left to that node's left
                        node.left = left.left
                        
                        //Set the current node's right to that node's right
                        node.right = left.right
                    }
                        //If the current node has a right node
                    else if let node = currentNode, let right = right
                    {
                        //Set the current node's value to that node's value
                        node.value = right.value
                        
                        //Set the current node's left to that node's left
                        node.left = right.left
                        
                        //Set the current node's right to that node's right
                        node.right = right.right
                    }
                        //Otherwise
                    else if let node = currentNode
                    {
                        //Remove the current node's value
                        node.value = nil
                    }
                }
                    //If the parent's left node is equal to the current node
                else if let parent = parentNode, let parentLeft = parent.left, parentLeft === self
                {
                    //Set the parent's left to the current node's left if it exists
                    if let left = left
                    {
                        parent.left = left
                    }
                        //Otherwise set the parent's left to the current node's right
                    else
                    {
                        parent.left = right
                    }
                }
                    //If the parent's right node is equal to the current node
                else if let parent = parentNode, let parentRight = parentNode?.right, parentRight === self
                {
                    //Set the parent's left to the current node's left if it exists
                    if let left = left
                    {
                        parent.right = left
                    }
                        //Otherwise set the parent's left to the current node's right
                    else
                    {
                        parent.right = right
                    }
                }
            }
        }
        
        return self
    }
    
    //Returns smallest value in BST
    func getMinValue() -> Int?
    {
        var currentNode = self
        
        //Keep going until the left node becomes nil
        while currentNode.left !== nil
        {
            //If the current node has a left node
            if let left = currentNode.left
            {
                //Set the current node to be equal to that node
                currentNode = left
            }
        }
        
        return currentNode.value
    }
}

//BST Traversal
//O(n) time | O(n) space
func inOrderTraversal(tree: IterativeBST?, array: inout [Int]) -> [Int]
{
    if tree !== nil
    {
        inOrderTraversal(tree: tree?.left, array: &array)
        
        if let value = tree?.value
        {
            array.append(value)
        }
        
        inOrderTraversal(tree: tree?.right, array: &array)
    }
    
    return array
}

//O(n) time | O(n) space
func preOrderTraversal(tree: IterativeBST?, array: inout [Int]) -> [Int]
{
    if tree !== nil
    {
        if let value = tree?.value
        {
            array.append(value)
        }
        
        preOrderTraversal(tree: tree?.left, array: &array)
        preOrderTraversal(tree: tree?.right, array: &array)
    }
    
    return array
}

//O(n) time | O(n) space
func postOrderTraversal(tree: IterativeBST?, array: inout [Int]) -> [Int]
{
    if tree !== nil
    {
        postOrderTraversal(tree: tree?.left, array: &array)
        postOrderTraversal(tree: tree?.right, array: &array)
        
        if let value = tree?.value
        {
            array.append(value)
        }
    }
    
    return array
}

//Tests
var dumpArray = [Int]()
let firstBST = IterativeBST(value: 10).insert(value: 5).insert(value: 15)

let secondBST = IterativeBST(value: 10).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22)

let thirdBST = IterativeBST(value: 100).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22).insert(value: 1).insert(value: 1).insert(value: 3).insert(value: 1).insert(value: 1).insert(value: 502).insert(value: 55000).insert(value: 204).insert(value: 205).insert(value: 207).insert(value: 206).insert(value: 208).insert(value: 203)

//In Order Traversal
dumpArray = [Int]()
assert(inOrderTraversal(tree: firstBST, array: &dumpArray) == [5, 10, 15])

dumpArray = [Int]()
assert(inOrderTraversal(tree: secondBST, array: &dumpArray) == [1, 2, 5, 5, 10, 15, 22])

dumpArray = [Int]()
assert(inOrderTraversal(tree: thirdBST, array: &dumpArray) == [1, 1, 1, 1, 1, 2, 3, 5, 5, 15, 22, 100, 203, 204, 205, 206, 207, 208, 502, 55000])

//Pre Order Traversal
dumpArray = [Int]()
assert(preOrderTraversal(tree: firstBST, array: &dumpArray) == [10, 5, 15])

dumpArray = [Int]()
assert(preOrderTraversal(tree: secondBST, array: &dumpArray) == [10, 5, 2, 1, 5, 15, 22])

dumpArray = [Int]()
assert(preOrderTraversal(tree: thirdBST, array: &dumpArray) == [100, 5, 2, 1, 1, 1, 1, 1, 3, 15, 5, 22, 502, 204, 203, 205, 207, 206, 208, 55000])

//Post Order Traversal
dumpArray = [Int]()
assert(postOrderTraversal(tree: firstBST, array: &dumpArray) == [5, 15, 10])

dumpArray = [Int]()
assert(postOrderTraversal(tree: secondBST, array: &dumpArray) == [1, 2, 5, 5, 22, 15, 10])

dumpArray = [Int]()
assert(postOrderTraversal(tree: thirdBST, array: &dumpArray) == [1, 1, 1, 1, 1, 3, 2, 5, 22, 15, 5, 203, 206, 208, 207, 205, 204, 55000, 502, 100])
