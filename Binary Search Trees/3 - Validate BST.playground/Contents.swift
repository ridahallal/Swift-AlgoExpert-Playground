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

//Validate BST
//O(n) time | O(d) space
func validateBST(tree: IterativeBST) -> Bool
{
    var minimum = Int(Int32.min)
    var maximum = Int(Int32.max)
    return validateBSTHelper(tree: tree, minimum: &minimum, maximum: &maximum)
}

func validateBSTHelper(tree: IterativeBST?, minimum: inout Int, maximum: inout Int) -> Bool
{
    if tree === nil
    {
        return true
    }
    
    if let tree = tree, let value = tree.value, value < minimum || value >= maximum
    {
        return false
    }
    
    if var treeValue = tree?.value
    {
        let leftIsValid = validateBSTHelper(tree: tree?.left, minimum: &minimum, maximum: &treeValue)
        let rightIsValid = validateBSTHelper(tree: tree?.right, minimum: &treeValue, maximum: &maximum)
        
        return leftIsValid && rightIsValid
    }
    else
    {
        return false
    }
}

//Tests
let firstTree = IterativeBST(value: 10).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22).insert(value: 13).insert(value: 14)

let secondTree = IterativeBST(value: 10).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22).insert(value: -5).insert(value: -15).insert(value: -5).insert(value: -2).insert(value: -1).insert(value: -22)

let thirdTree = IterativeBST(value: 10)

let fourthTree = IterativeBST(value: 10).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22).insert(value: 500).insert(value: 1500).insert(value: 50).insert(value: 200).insert(value: 10000).insert(value: 2200)

let fifthTree = IterativeBST(value: 5000).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22).insert(value: 1).insert(value: 1).insert(value: 3).insert(value: 1).insert(value: 1).insert(value: 502).insert(value: 55000).insert(value: 204).insert(value: 205).insert(value: 207).insert(value: 206).insert(value: 208).insert(value: 203)

let sixthTree = IterativeBST(value: 10).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22)
sixthTree.left?.right?.right = IterativeBST(value: 11)

let seventhTree = IterativeBST(value: 10).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22).insert(value: -5).insert(value: -15).insert(value: -5).insert(value: -2).insert(value: -1).insert(value: -22)
seventhTree.left?.left?.left?.left?.left?.left?.left = IterativeBST(value: 11)

let eightthTree = IterativeBST(value: 10).insert(value: 12)
eightthTree.left = IterativeBST(value: 11)

let ninthTree = IterativeBST(value: 10).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22).insert(value: 500).insert(value: 1500).insert(value: 50).insert(value: 200).insert(value: 10000).insert(value: 2200)
ninthTree.right?.right?.right?.right?.right?.right = IterativeBST(value: 9999)

let tenthTree = IterativeBST(value: 100).insert(value: 5).insert(value: 15).insert(value: 5).insert(value: 2).insert(value: 1).insert(value: 22).insert(value: 1).insert(value: 1).insert(value: 502).insert(value: 55000).insert(value: 204).insert(value: 205).insert(value: 207).insert(value: 206).insert(value: 208).insert(value: 203)
tenthTree.right?.left?.right?.left = IterativeBST(value: 300)

let eleventhTree = IterativeBST(value: 10).insert(value: 5).insert(value: 15)
eleventhTree.left?.right = IterativeBST(value: 10)

assert(validateBST(tree: firstTree) == true)
assert(validateBST(tree: secondTree) == true)
assert(validateBST(tree: thirdTree) == true)
assert(validateBST(tree: fourthTree) == true)
assert(validateBST(tree: fifthTree) == true)
assert(validateBST(tree: sixthTree) == false)
assert(validateBST(tree: seventhTree) == false)
assert(validateBST(tree: eightthTree) == false)
assert(validateBST(tree: ninthTree) == false)
assert(validateBST(tree: tenthTree) == false)
assert(validateBST(tree: eleventhTree) == false)
