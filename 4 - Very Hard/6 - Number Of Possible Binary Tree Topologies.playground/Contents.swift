//Number Of Possible Binary Tree Topologies
//Solution #1
//Upper Bound: (O(n * (2n)!)/(n!(n + 1)!)) time | O(n) space
func numberOfBinaryTreeTopologiesFirstSolution(_ n: Int) -> Int
{
    if n == 0
    {
        return 1
    }
    
    var numberOfTopologies = 0
    
    for leftTreeSize in 0 ..< n
    {
        let rightTreeSize = n - 1 - leftTreeSize
        
        let leftNumberOfTopologies = numberOfBinaryTreeTopologiesFirstSolution(leftTreeSize)
        let rightNumberOfTopologies = numberOfBinaryTreeTopologiesFirstSolution(rightTreeSize)
        numberOfTopologies += leftNumberOfTopologies * rightNumberOfTopologies
    }
    
    return numberOfTopologies
}

//Solution #2
//O(n^2) time | O(1) space
func numberOfBinaryTreeTopologiesSecondSolution(_ n: Int) -> Int
{
    var cache = [0 : 1]
    return numberOfBinaryTreeTopologiesHelper(n, &cache)
}

func numberOfBinaryTreeTopologiesHelper(_ n: Int, _ cache: inout [Int: Int]) -> Int
{
    if let cachedValue = cache[n]
    {
        return cachedValue
    }
    
    var numberOfTopologies = 0
    
    for leftTreeSize in 0 ..< n
    {
        let rightTreeSize = n - 1 - leftTreeSize
        
        let leftNumberOfTopologies = numberOfBinaryTreeTopologiesHelper(leftTreeSize, &cache)
        let rightNumberOfTopologies = numberOfBinaryTreeTopologiesHelper(rightTreeSize, &cache)
        numberOfTopologies += leftNumberOfTopologies * rightNumberOfTopologies
    }
    
    cache[n] = numberOfTopologies
    return numberOfTopologies
}

//Solution #3
//O(n^2) time | O(1) space
func numberOfBinaryTreeTopologiesThirdSolution(_ n: Int) -> Int
{
    var cache = [1]
    
    for currentMax in stride(from: 1, through: n, by: 1)
    {
        var numberOfTopologies = 0
        
        for leftTreeSize in stride(from: 0, to: currentMax, by: 1)
        {
            let rightTreeSize = currentMax - 1 - leftTreeSize
            
            let leftNumberOfTopologies = cache[leftTreeSize]
            let rightNumberOfTopologies = cache[rightTreeSize]
            numberOfTopologies += leftNumberOfTopologies * rightNumberOfTopologies
        }
        
        cache.append(numberOfTopologies)
    }
    
    return cache[n]
}

//assert(numberOfBinaryTreeTopologiesFirstSolution(0) == 1)
assert(numberOfBinaryTreeTopologiesSecondSolution(0) == 1)
assert(numberOfBinaryTreeTopologiesThirdSolution(0) == 1)

//assert(numberOfBinaryTreeTopologiesFirstSolution(1) == 1)
assert(numberOfBinaryTreeTopologiesSecondSolution(1) == 1)
assert(numberOfBinaryTreeTopologiesThirdSolution(1) == 1)

//assert(numberOfBinaryTreeTopologiesFirstSolution(2) == 2)
assert(numberOfBinaryTreeTopologiesSecondSolution(2) == 2)
assert(numberOfBinaryTreeTopologiesThirdSolution(2) == 2)

//assert(numberOfBinaryTreeTopologiesFirstSolution(3) == 5)
assert(numberOfBinaryTreeTopologiesSecondSolution(3) == 5)
assert(numberOfBinaryTreeTopologiesThirdSolution(3) == 5)

//assert(numberOfBinaryTreeTopologiesFirstSolution(4) == 14)
assert(numberOfBinaryTreeTopologiesSecondSolution(4) == 14)
assert(numberOfBinaryTreeTopologiesThirdSolution(4) == 14)

//assert(numberOfBinaryTreeTopologiesFirstSolution(5) == 42)
assert(numberOfBinaryTreeTopologiesSecondSolution(5) == 42)
assert(numberOfBinaryTreeTopologiesThirdSolution(5) == 42)

//assert(numberOfBinaryTreeTopologiesFirstSolution(6) == 132)
assert(numberOfBinaryTreeTopologiesSecondSolution(6) == 132)
assert(numberOfBinaryTreeTopologiesThirdSolution(6) == 132)

//assert(numberOfBinaryTreeTopologiesFirstSolution(7) == 429)
assert(numberOfBinaryTreeTopologiesSecondSolution(7) == 429)
assert(numberOfBinaryTreeTopologiesThirdSolution(7) == 429)

//assert(numberOfBinaryTreeTopologiesFirstSolution(8) == 1430)
assert(numberOfBinaryTreeTopologiesSecondSolution(8) == 1430)
assert(numberOfBinaryTreeTopologiesThirdSolution(8) == 1430)

//assert(numberOfBinaryTreeTopologiesFirstSolution(9) == 4862)
assert(numberOfBinaryTreeTopologiesSecondSolution(9) == 4862)
assert(numberOfBinaryTreeTopologiesThirdSolution(9) == 4862)

//assert(numberOfBinaryTreeTopologiesFirstSolution(10) == 16796)
assert(numberOfBinaryTreeTopologiesSecondSolution(10) == 16796)
assert(numberOfBinaryTreeTopologiesThirdSolution(10) == 16796)

//assert(numberOfBinaryTreeTopologiesFirstSolution(11) == 58786)
assert(numberOfBinaryTreeTopologiesSecondSolution(11) == 58786)
assert(numberOfBinaryTreeTopologiesThirdSolution(11) == 58786)

//assert(numberOfBinaryTreeTopologiesFirstSolution(12) == 208012)
assert(numberOfBinaryTreeTopologiesSecondSolution(12) == 208012)
assert(numberOfBinaryTreeTopologiesThirdSolution(12) == 208012)

//assert(numberOfBinaryTreeTopologiesFirstSolution(13) == 742900)
assert(numberOfBinaryTreeTopologiesSecondSolution(13) == 742900)
assert(numberOfBinaryTreeTopologiesThirdSolution(13) == 742900)
