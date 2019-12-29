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

//Find Closest Value In BST
//Solution #1
//Average: O(log(n)) time | O(log(n)) space
//Worst: O(n) time | O(n) space
func findClosestValueInBSTRecursive(tree: IterativeBST?, target: Int) -> Int
{
    var closest = Int(Int32.max)
    
    return findClosestValueInBSTRecursiveHelper(tree: tree, target: target, closest: &closest)
}

func findClosestValueInBSTRecursiveHelper(tree: IterativeBST?, target: Int, closest: inout Int) -> Int
{
    if tree === nil
    {
        return closest
    }
    
    if let tree = tree, let value = tree.value
    {
        let closestDifference = target - closest
        let currentDifference = target - value
        
        if (closestDifference.magnitude > currentDifference.magnitude)
        {
            closest = value
        }
    }
    
    if let tree = tree, let value = tree.value, target < value
    {
        if let left = tree.left
        {
            return findClosestValueInBSTRecursiveHelper(tree: left, target: target, closest: &closest)
        }
        else
        {
            return closest
        }
    }
    else if let tree = tree, let value = tree.value,  target > value
    {
        if let right = tree.right
        {
            return findClosestValueInBSTRecursiveHelper(tree: right, target: target, closest: &closest)
        }
        else
        {
            return closest
        }
    }
    else
    {
        return closest
    }
}

//Solution #2
//Average: O(log(n)) time | O(1) space
//Worst: O(n) time | O(1) space
func findClosestValueInBSTIterative(tree: IterativeBST?, target: Int) -> Int
{
    var closest = Int(Int32.max)
    
    return findClosestValueInBSTIterativeHelper(tree: tree, target: target, closest: &closest)
}

func findClosestValueInBSTIterativeHelper(tree: IterativeBST?, target: Int, closest: inout Int) -> Int
{
    var currentNode = tree
    
    while currentNode !== nil
    {
        if let node = currentNode, let value = node.value
        {
            let closestDifference = target - closest
            let currentDifference = target - value
            
            if (closestDifference.magnitude > currentDifference.magnitude)
            {
                closest = value
            }
        }
        
        if let node = currentNode, let value = node.value, target < value
        {
            currentNode = node.left
        }
        else if let node = currentNode, let value = node.value,  target > value
        {
            currentNode = node.right
        }
        else
        {
            break
        }
    }
    
    return closest
}

//Tests
let iterativeBST = IterativeBST(value: 100).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22).insert(value: 1).insert(value: 1).insert(value: 3).insert(value: 1).insert(value: 1).insert(value: 502).insert(value: 55000).insert(value: 204).insert(value: 205).insert(value: 207).insert(value: 206).insert(value: 208).insert(value: 203).insert(value: -51).insert(value: -403).insert(value: 1001).insert(value: 57).insert(value: 60).insert(value: 4500)

//Recursive
assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: 100) == 100)

assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: 208) == 208)

assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: 4500) == 4500)

assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: 4501) == 4500)

assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: -70) == -51)

assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: 2000) == 1001)

assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: 6) == 5)

assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: 30000) == 55000)

assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: -1) == 1)

assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: 29751) == 55000)

assert(findClosestValueInBSTRecursive(tree: iterativeBST, target: 29749) == 4500)

//Iterative
assert(findClosestValueInBSTIterative(tree: iterativeBST, target: 100) == 100)

assert(findClosestValueInBSTIterative(tree: iterativeBST, target: 208) == 208)

assert(findClosestValueInBSTIterative(tree: iterativeBST, target: 4500) == 4500)

assert(findClosestValueInBSTIterative(tree: iterativeBST, target: 4501) == 4500)

assert(findClosestValueInBSTIterative(tree: iterativeBST, target: -70) == -51)

assert(findClosestValueInBSTIterative(tree: iterativeBST, target: 2000) == 1001)

assert(findClosestValueInBSTIterative(tree: iterativeBST, target: 6) == 5)

assert(findClosestValueInBSTIterative(tree: iterativeBST, target: 30000) == 55000)

assert(findClosestValueInBSTIterative(tree: iterativeBST, target: -1) == 1)

assert(findClosestValueInBSTIterative(tree: iterativeBST, target: 29751) == 55000)

assert(findClosestValueInBSTIterative(tree: iterativeBST, target: 29749) == 4500)
