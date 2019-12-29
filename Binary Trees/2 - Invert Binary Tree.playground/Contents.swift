//Generic Iterative BST Class
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
    
    func invertedInsert(values: [Int], index: Int) -> BinaryTree?
    {
        if index >= values.count { return nil }
        
        var queue: [BinaryTree?] = [self]
        
        while queue.count > 0
        {
            let current = queue.removeFirst()
            
            if current?.right === nil
            {
                current?.right = BinaryTree(value: values[index])
                break
            }
            
            queue.append(current?.right)
            
            if current?.left === nil
            {
                current?.left = BinaryTree(value: values[index])
                break
            }
            
            queue.append(current?.left)
        }
        
        self.invertedInsert(values: values, index: index + 1)
        
        return self
    }
}

//Invert Binary Tree
func invertBinaryTree(tree: BinaryTree)
{
    var queue: [BinaryTree?] = [tree]
    
    while queue.count > 0
    {
        let current = queue.removeFirst()
        
        if current === nil
        {
            continue
        }
        
        swapLeftAndright(tree: current!)
        queue.append(current?.left)
        queue.append(current?.right)
    }
}

func swapLeftAndright(tree: BinaryTree)
{
    let left = tree.left
    tree.left = tree.right
    tree.right = left
}

func compareBT(firstTree: BinaryTree?, secondTree: BinaryTree?) -> Bool
{
    if (firstTree === nil && secondTree === nil)
    {
        return true
    }
    
    if (firstTree !== nil && secondTree !== nil)
    {
        return firstTree!.value == secondTree!.value && compareBT(firstTree: firstTree?.left, secondTree: secondTree?.left) && compareBT(firstTree: firstTree?.right, secondTree: secondTree?.right)
    }
    
    return false
}

//Tests
let firstTree = BinaryTree(value: 1)
let invertedFirstTree = BinaryTree(value: 1)

let secondTree = BinaryTree(value: 1).insert(values: [2], index: 0)
let invertedSecondTree = BinaryTree(value: 1).invertedInsert(values: [2], index: 0)

let thirdTree = BinaryTree(value: 1).insert(values: [2, 3], index: 0)
let invertedThirdTree = BinaryTree(value: 1).invertedInsert(values: [2, 3], index: 0)

let fourthTree = BinaryTree(value: 1).insert(values: [2, 3, 4], index: 0)
let invertedFourthTree = BinaryTree(value: 1).invertedInsert(values: [2, 3, 4], index: 0)

let fifthTree = BinaryTree(value: 1).insert(values: [2, 3, 4, 5], index: 0)
let invertedFifthTree = BinaryTree(value: 1).invertedInsert(values: [2, 3, 4, 5], index: 0)

let sixthTree = BinaryTree(value: 1).insert(values: [2, 3, 4, 5, 6], index: 0)
let invertedSixthTree = BinaryTree(value: 1).invertedInsert(values: [2, 3, 4, 5, 6], index: 0)

let seventhTree = BinaryTree(value: 1).insert(values: [2, 3, 4, 5, 6, 7], index: 0)
let invertedSeventhTree = BinaryTree(value: 1).invertedInsert(values: [2, 3, 4, 5, 6, 7], index: 0)

let eighthTree = BinaryTree(value: 1).insert(values: [2, 3, 4, 5, 6, 7, 8], index: 0)
let invertedEihgthTree = BinaryTree(value: 1).invertedInsert(values: [2, 3, 4, 5, 6, 7, 8], index: 0)

let ninthTree = BinaryTree(value: 1).insert(values: [2, 3, 4, 5, 6, 7, 8, 9], index: 0)
let invertedNinthTree = BinaryTree(value: 1).invertedInsert(values: [2, 3, 4, 5, 6, 7, 8, 9], index: 0)

let tenthTree = BinaryTree(value: 1).insert(values: [2, 3, 4, 5, 6, 7, 8, 9, 10], index: 0)
let invertedTenthTree = BinaryTree(value: 1).invertedInsert(values: [2, 3, 4, 5, 6, 7, 8, 9, 10], index: 0)

let eleventhTree = BinaryTree(value: 1).insert(values: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], index: 0)
let invertedEleventhTree = BinaryTree(value: 1).invertedInsert(values: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], index: 0)

invertBinaryTree(tree: firstTree)
assert(compareBT(firstTree: firstTree, secondTree: invertedFirstTree))

if let secondTree = secondTree
{
    invertBinaryTree(tree: secondTree)
    assert(compareBT(firstTree: secondTree, secondTree: invertedSecondTree))
}

if let thirdTree = thirdTree
{
    invertBinaryTree(tree: thirdTree)
    assert(compareBT(firstTree: thirdTree, secondTree: thirdTree))
}

if let fourthTree = fourthTree
{
    invertBinaryTree(tree: fourthTree)
    assert(compareBT(firstTree: fourthTree, secondTree: invertedFourthTree))
}

if let fifthTree = fifthTree
{
    invertBinaryTree(tree: fifthTree)
    assert(compareBT(firstTree: fifthTree, secondTree: invertedFifthTree))
}

if let sixthTree = sixthTree
{
    invertBinaryTree(tree: sixthTree)
    assert(compareBT(firstTree: sixthTree, secondTree: invertedSixthTree))
}

if let seventhTree = seventhTree
{
    invertBinaryTree(tree: seventhTree)
    assert(compareBT(firstTree: seventhTree, secondTree: seventhTree))
}

if let eighthTree = eighthTree
{
    invertBinaryTree(tree: eighthTree)
    assert(compareBT(firstTree: eighthTree, secondTree: invertedEihgthTree))
}

if let ninthTree = ninthTree
{
    invertBinaryTree(tree: ninthTree)
    assert(compareBT(firstTree: ninthTree, secondTree: invertedNinthTree))
}

if let tenthTree = tenthTree
{
    invertBinaryTree(tree: tenthTree)
    assert(compareBT(firstTree: tenthTree, secondTree: invertedTenthTree))
}

if let eleventhTree = eleventhTree
{
    invertBinaryTree(tree: eleventhTree)
    assert(compareBT(firstTree: eleventhTree, secondTree: invertedEleventhTree))
}
