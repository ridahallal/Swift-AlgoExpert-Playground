//Generic Binary Tree Class
class BinaryTree
{
    var value: Int?
    var left: BinaryTree?
    var right: BinaryTree?
    
    init(value: Int)
    {
        self.value = value
        self.left = nil
        self.right = nil
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
                current?.left = BinaryTree(value: values[index])
                break
            }
            
            queue.append(current?.left)
            
            if current?.right === nil
            {
                current?.right = BinaryTree(value: values[index])
                break
            }
            
            queue.append(current?.right)
        }
        
        insert(values: values, index: index + 1)
        
        return self
    }
}

//Max Path Sum In Binary Tree
//O(n) time | O(log(n)) space
func maxPathSum(tree: BinaryTree?) -> Int
{
    let rootMaxSumTuple = findMaxSum(tree: tree)
    
    return rootMaxSumTuple.1
}

func findMaxSum(tree: BinaryTree?) -> (Int, Int)
{
    if tree === nil
    {
        return (0, 0)
    }
    
    //Find max sum for left child and store it in a tuple
    let leftMaxSumTuple = findMaxSum(tree: tree?.left)
    let rightMaxSumTuple = findMaxSum(tree: tree?.right)
    
    //Store the biggest straight max sum in childStraightMaxSum
    let childStraightMaxSum = max(leftMaxSumTuple.0, rightMaxSumTuple.0)
    
    //Get the current tree's value
    let value = tree!.value!
    
    //Check whether or not we add the current node's value to the total straight max sum
    let currentStraightMaxSum = max(value + childStraightMaxSum, value)
    
    //If we want to include the current node's value to our total max sum
    //It should be surrounded by a left straight line and a right straight line
    //See whether left line + node + right line is bigger than our current straight max
    //Store that in a variable
    let currentTriangleMaxSum = max(leftMaxSumTuple.0 + value + rightMaxSumTuple.0, currentStraightMaxSum)
    
    //Max sum for the current node will be the max between straight left, straight right, and the current triangle max sum
    let currentMaxSum = max(max(leftMaxSumTuple.1, rightMaxSumTuple.1), currentTriangleMaxSum)
    
    return (currentStraightMaxSum, currentMaxSum)
}

let firstTest = BinaryTree(value: 1).insert(values: [2, 3], index: 0)
assert(maxPathSum(tree: firstTest) == 6)

let secondTest = BinaryTree(value: 1).insert(values: [2, -1], index: 0)
assert(maxPathSum(tree: secondTest) == 3)

let thirdTest = BinaryTree(value: 1).insert(values: [-5, 3, 6], index: 0)
assert(maxPathSum(tree: thirdTest) == 6)

let fourthTest = BinaryTree(value: 1).insert(values: [2, 3, 4, 5, 6, 7], index: 0)
assert(maxPathSum(tree: fourthTest) == 18)

let fifthTest = BinaryTree(value: 1).insert(values: [-10, -5, 30, 45, -20, -21, 5, 1, 3, -3, 100, 2, 100, 1], index: 0)
assert(maxPathSum(tree: fifthTest) == 154)

let sixthTest = BinaryTree(value: 1).insert(values: [-10, -5, 30, 45, -20, -21, 5, 1, 3, -3, 100, 2, 100, 1, 100], index: 0)
assert(maxPathSum(tree: sixthTest) == 201)

let seventhTest = BinaryTree(value: 1).insert(values: [-10, -5, 30, 75, -20, -21, 5, 1, 3, -3, 100, 2, 100, 1, 100], index: 0)
assert(maxPathSum(tree: seventhTest) == 203)

let eightTest = BinaryTree(value: 1).insert(values: [-150, -5, 30, 75, -20, -21, 5, 1, 3, -3, 100, 2, 100, 1, 100, 100, 5, 10, 150, -8], index: 0)
assert(maxPathSum(tree: eightTest) == 228)

let ninthTest = BinaryTree(value: 1).insert(values: [-150, -5, 30, 75, -20, -21, 5, 1, 3, -3, 100, 2, 100, 1, 100, 100, 5, 10, 150, 151], index: 0)
assert(maxPathSum(tree: ninthTest) == 304)

let tenthTest = BinaryTree(value: 1).insert(values: [-5, -3, 0, 2, 2, 1, -3, 3, 1, 1, 0, 5, 1, 1, 0, 1, 1, -1, -1, -6, -1, -100, -9, -91, 2, 1, 0, 1, -5, 0], index: 0)
assert(maxPathSum(tree: tenthTest) == 9)

let eleventhTest = BinaryTree(value: 1).insert(values: [-5, -3, 0, 2, 2, 1, -3, -4, 1, 1, 0, 5, 1, 1, 0, 1, 10, -1, -1, -6, -1, -100, -9, -91, 2, 1, 0, 1, -5, 0], index: 0)
assert(maxPathSum(tree: eleventhTest) == 10)

let twelfthTest = BinaryTree(value: 1).insert(values: [-5, -3, 0, 2, 2, 1, -3, -4, 1, 1, 0, 5, 1, 1, 0, 1, 3, -1, -1, -6, -1, -100, -9, -91, 2, 1, 0, 1, -5, 0, 3, 1, 2, 2, 7, -5], index: 0)
assert(maxPathSum(tree: twelfthTest) == 10)

let thirteenthTest = BinaryTree(value: 1).insert(values: [-5, -3, 0, 2, 2, 1, -3, 3, 1, 1, 0, 5, 1, 1, 0, 1, 1, -1, -1, -6, -1, -100, -9, -91, 2, 1, 0, 1, 5, 0], index: 0)
assert(maxPathSum(tree: thirteenthTest) == 13)
