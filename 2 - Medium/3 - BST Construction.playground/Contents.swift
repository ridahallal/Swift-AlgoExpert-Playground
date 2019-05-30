//BST Construction
//Solution #1
class RecursiveBST
{
    var value: Int?
    var left: RecursiveBST?
    var right: RecursiveBST?
    
    init(value: Int)
    {
        self.value = value
        self.left = nil
        self.right = nil
    }
    
    //Average: O(log(n)) time | O(log(n)) space
    //Worst: O(n) time | O(n) space
    func insert(value: Int) -> RecursiveBST
    {
        //If the value to insert is less than the current node's value
        if let selfValue = self.value, value < selfValue
        {
            //Check if current node has a left node
            if let left = left
            {
                //Call the insert function on that left node
                left.insert(value: value)
            }
            //If the current node doesn't have a left node
            else
            {
                //Just set the current node's left node to a new node with the value that we want to insert
                left = RecursiveBST(value: value)
            }
        }
        //If the value to insert is greater than the current node's value
        else
        {
            //Check if the current node has a right node
            if let right = right
            {
                //Call the insert function on that right node
                right.insert(value: value)
            }
            //If the current node doesn't have a right node
            else
            {
                //Just set the current node's right node to a new node with the value that we want to insert
                right = RecursiveBST(value: value)
            }
        }
        
        return self
    }
    
    //Average: O(log(n)) time | O(log(n)) space
    //Worst: O(n) time | O(n) space
    func contains(value: Int) -> Bool
    {
        //If the value we're searching for is less than the current node's value
        if let selfValue = self.value, value < selfValue
        {
            //Check if the current node has a left node
            if let left = left
            {
                //Call the contains function on that left node
                return left.contains(value: value)
            }
            //If the current node doesn't have a left node, it means we've reached a dead end
            else
            {
                return false
            }
        }
        //If the value we're searching for is greater than the current node's value
        else if let selfValue = self.value, value > selfValue
        {
            //Check if the current node has a right node
            if let right = right
            {
                //Call the contains function on that right node
                return right.contains(value: value)
            }
            //If the current node doesn't have a right node, it means we've reached a dead end
            else
            {
                return false
            }
        }
        //If the value we're searching for is equal than the current node's value
        else
        {
            //The BST does actually contain the value
            return true
        }
    }
    
    //Average: O(log(n)) time | O(log(n)) space
    //Worst: O(n) time | O(n) space
    func remove(value: Int?, parentNode: RecursiveBST?) -> RecursiveBST
    {
        //If the value value we want to remove is less than the current node's value
        if let selfValue = self.value, let valueToRemove = value, valueToRemove < selfValue
        {
            //Check if the current node has a left node
            if let left = left
            {
                //Call the remove function on it
                left.remove(value: value, parentNode: self)
            }
        }
        //If the value we want to remove is greater than the current node's value
        else if let selfValue = self.value, let valueToRemove = value, valueToRemove > selfValue
        {
            //Check if the current node has a right node
            if let right = right
            {
                //Call the remove function on it
                right.remove(value: value, parentNode: self)
            }
        }
        //If the value we want to remove is equal to the current node's value
        else
        {
            //If the current node has both left and right nodes
            if let _ = left, let right = right
            {
                //Set the current node's value to the right node's minimum value
                self.value = right.getMinValue()
                
                //Remove that value from the right node
                right.remove(value: self.value, parentNode: self)
            }
            //The case of the first node
            else if parentNode === nil
            {
                //If the current node has a left node
                if let left = left
                {
                    //Set the current node's value to that node's value
                    self.value = left.value
                    
                    //Set the current node's left to that node's left
                    self.left = left.left
                    
                    //Set the current node's right to that node's right
                    self.right = left.right
                }
                //If the current node has a right node
                else if let right = right
                {
                    //Set the current node's value to that node's value
                    self.value = right.value
                    
                    //Set the current node's left to that node's left
                    self.left = right.left
                    
                    //Set the current node's right to that node's right
                    self.right = right.right
                }
                //Otherwise
                else
                {
                    //Remove the current node's value
                    self.value = nil
                }
            }
            //If the parent's left node is equal to the current node
            else if let parent = parentNode, var parentLeft = parent.left, parentLeft === self
            {
                //Set the parent's left to the current node's left if it exists
                if let left = left
                {
                    parentLeft = left
                }
                //Otherwise set the parent's left to the current node's right
                else
                {
                    parent.left = right
                }
            }
            //If the parent's right node is equal to the current node
            else if let parent = parentNode, var parentRight = parentNode?.right, parentRight === self
            {
                //Set the parent's left to the current node's left if it exists
                if let left = left
                {
                    parentRight = left
                }
                //Otherwise set the parent's left to the current node's right
                else
                {
                    parent.right = right
                }
            }
        }
        
        return self
    }
    
    //Returns smallest value in BST
    func getMinValue() -> Int?
    {
        //If the current node has a left value
        if let left = left
        {
            //Keep recursively calling the function
            return left.getMinValue()
        }
        //If the current node doesn't have a left value
        else
        {
            //Just return the current node's value
            return value
        }
    }
}

//Solution #2
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
        var currentNode = self
        
        while true
        {
            //If the value to insert is less than the current node's value
            if let selfValue = self.value, value < selfValue
            {
                //Check if current node has a left node
                if let left = currentNode.left
                {
                    //Set current node to be equal to that left node
                    currentNode = left
                }
                //If the current node doesn't have a left node
                else
                {
                    //Just set the current node's left node to a new node with the value that we want to insert and break
                    currentNode.left = IterativeBST(value: value)
                    break
                }
            }
            //If the value to insert is greater than the current node's value
            else
            {
                //Check if current node has a right node
                if let right = currentNode.right
                {
                    //Set current node to be equal to that right node
                    currentNode = right
                }
                //If the current node doesn't have a right node
                else
                {
                    //Just set the current node's right node to a new node with the value that we want to insert and break
                    currentNode.right = IterativeBST(value: value)
                    break
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
        let currentNode: IterativeBST? = self
        
        while currentNode !== nil
        {
            //If the value we're searching for is less than the current node's value
            if let node = currentNode, let selfValue = node.value, let valueToRemove = value, valueToRemove < selfValue
            {
                //Check if the current node has a left node
                if let left = node.left
                {
                    //Call the remove function on it
                    left.remove(value: value, parentNode: self)
                }
            }
            //If the value we're searching for is greater than the current node's value
            else if let node = currentNode, let selfValue = node.value, let valueToRemove = value, valueToRemove > selfValue
            {
                //Check if the current node has a right node
                if let right = node.right
                {
                    //Call the remove function on it
                    right.remove(value: value, parentNode: self)
                }
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
                else if let parent = parentNode, var parentLeft = parent.left, parentLeft === self
                {
                    //Set the parent's left to the current node's left if it exists
                    if let left = left
                    {
                        parentLeft = left
                    }
                    //Otherwise set the parent's left to the current node's right
                    else
                    {
                        parent.left = right
                    }
                }
                //If the parent's right node is equal to the current node
                else if let parent = parentNode, var parentRight = parentNode?.right, parentRight === self
                {
                    //Set the parent's left to the current node's left if it exists
                    if let left = left
                    {
                        parentRight = left
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

//Tests
//Solution #1 Tests
let recursiveBST1 = RecursiveBST(value: 10).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 14).insert(value: 22)

let recursiveBST2 = RecursiveBST(value: 10).insert(value: 15).insert(value: 11).insert(value: 22).remove(value: 10, parentNode: nil)

let recursiveBST3 = RecursiveBST(value: 10).insert(value: 5).insert(value: 7).insert(value: 2).remove(value: 10, parentNode: nil)

let recursiveBST4 = RecursiveBST(value: 10).insert(value: 5).insert(value: 15).insert(value: 22).insert(value: 17).insert(value: 34).insert(value: 7).insert(value: 2).insert(value: 5).insert(value: 1).insert(value: 35).insert(value: 27).insert(value: 16).insert(value: 30).remove(value: 22, parentNode: nil).remove(value: 17, parentNode: nil)

func inOrderTraverseRecursive(tree: RecursiveBST?, array: inout [Int]) -> [Int]
{
    if let tree = tree, let value = tree.value
    {
        inOrderTraverseRecursive(tree: tree.left, array: &array)
        array.append(value)
        inOrderTraverseRecursive(tree: tree.right, array: &array)
    }
    
    return array
}

assert(recursiveBST1.left?.value == 5)
assert(recursiveBST1.right?.right?.value == 22)
assert(recursiveBST1.right?.left?.value == 14)
assert(recursiveBST1.left?.right?.value == 5)
assert(recursiveBST1.left?.left?.value == 2)
assert(recursiveBST1.left?.left?.left == nil)
assert(recursiveBST1.right?.left?.right == nil)
assert(recursiveBST1.contains(value: 15) == true)
assert(recursiveBST1.contains(value: 2) == true)
assert(recursiveBST1.contains(value: 5) == true)
assert(recursiveBST1.contains(value: 10) == true)
assert(recursiveBST1.contains(value: 22) == true)
assert(recursiveBST1.contains(value: 23) == false)

var array = [Int]()
assert(inOrderTraverseRecursive(tree: recursiveBST2, array: &array) == [11, 15, 22])

array = [Int]()
assert(inOrderTraverseRecursive(tree: recursiveBST3, array: &array) == [2, 5, 7])

array = [Int]()
print(inOrderTraverseRecursive(tree: recursiveBST4, array: &array))
//assert(inOrderTraverseRecursive(tree: recursiveBST4, array: &array) == [1, 2, 5, 5, 7, 10, 15, 16, 27, 30, 34, 35])

assert(recursiveBST4.right?.right?.value == 27)
//assert(recursiveBST4.right?.right?.left?.value == 16)
