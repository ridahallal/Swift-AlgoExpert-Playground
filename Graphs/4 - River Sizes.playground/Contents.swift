//River Sizes
//O(wh) time | O(wh) space
func riverSizes(_ matrix: [[Int]]) -> [Int]
{
    //This will be the array we return, it will store the river sizes
    var sizes: [Int] = []
    
    //Create an auxiliary matrix with the same width and height as our current matrix but filled with boolean values
    var visited: [[Bool]] = matrix.map { $0.map { $0 == 2 } }
    
    //For each row inside our 2D array
    for var i in 0 ..< matrix.count
    {
        //For each item inside the current row
        for var j in 0 ..< matrix[i].count
        {
            //If we've previously visited this node, skip it
            if visited[i][j] { continue }
            
            //Otherwise, traverse it
            traverseNode(&i, &j, matrix, &visited, &sizes)
        }
    }
    
    return sizes
}

//Helper function that traverses a node
func traverseNode(_ i: inout Int, _ j: inout Int, _ matrix: [[Int]], _ visited: inout [[Bool]], _ sizes: inout [Int])
{
    //Initial value for a river size
    var currentRiverSize = 0
    
    //A nodes to explore stack
    var nodesToExplore = [[i, j]]
    
    //While the stack has values inside it
    while nodesToExplore.count > 0
    {
        //Pop the stack and get the current node
        let currentNode = nodesToExplore.popLast()!
        
        //Set i and j to currentNode's coordinates in the matrix
        i = currentNode[0]
        j = currentNode[1]
        
        //If we've previously visited this node, skip it
        if visited[i][j] { continue }
        
        //Otherwise, mark it as visited
        visited[i][j] = true
        
        //If we land on land, skip it
        if matrix[i][j] == 0 { continue }
        
        //Otherwise, we landed in a river, increment our currentRiverSize
        currentRiverSize += 1
        
        //Get the currentNode's unvisited neighbors (top, bottom, left, right)
        let unvisitedNeighbors = getUnvisitedNeighbors(i, j, matrix, visited)
        
        //Push those unvisited neighbors inside our queue
        for node in unvisitedNeighbors
        {
            nodesToExplore.append(node)
        }
    }
    
    if currentRiverSize > 0 { sizes.append(currentRiverSize) }
}

//Returns a node's top, bottom, left, and right neighbors
func getUnvisitedNeighbors(_ i: Int, _ j: Int, _ matrix: [[Int]], _ visited: [[Bool]]) -> [[Int]]
{
    //Initialize the array we want to return
    var unvisitedNeighbors: [[Int]] = []
    
    //If we're not at the top row and we haven't visited the neighbor above us, add it to unvisitedNeighbors
    if (i > 0 && !visited[i - 1][j]) { unvisitedNeighbors.append([i - 1, j]) }
    
    //If we're not at the bottom row and we haven't visited the neighbor below us, add it to unvisitedNeighbors
    if (i < matrix.count - 1 && !visited[i + 1][j]) { unvisitedNeighbors.append([i + 1, j]) }
    
    //If we're not at the left most column, and we haven't visited the neighbor to our left, add it to unvisitedNeighbors
    if (j > 0 && !visited[i][j - 1]) { unvisitedNeighbors.append([i, j - 1]) }
    
    //If  we're not at the right most column, and we haven't visited the neighbor to our right, add it to unvisitedNeighbors
    if (j < matrix[i].count - 1 && !visited[i][j + 1]) { unvisitedNeighbors.append([i, j + 1]) }
    
    return unvisitedNeighbors
}

//Tests
let firstMatrix = [[0]]
let firstExpected: [Int] = []
let firstRiverSizes = riverSizes(firstMatrix).sorted()
assert(firstExpected == firstRiverSizes)

let secondMatrix = [[1]]
let secondExpected = [1]
let secondRiverSizes = riverSizes(secondMatrix).sorted()
assert(secondExpected == secondRiverSizes)

let thirdMatrix = [[1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0]]
let thirdExpected = [1, 2, 3]
let thirdRiverSizes = riverSizes(thirdMatrix).sorted()
assert(thirdExpected == thirdRiverSizes)

let fourthMatrix = [
    [1, 0, 0, 1],
    [1, 0, 1, 0],
    [0, 0, 1, 0],
    [1, 0, 1, 0],
]
let fourthExpected = [1, 1, 2, 3]
let fourthRiverSizes = riverSizes(fourthMatrix).sorted()
assert(fourthExpected == fourthRiverSizes)

let fifthMatrix = [
    [1, 0, 0, 1, 0],
    [1, 0, 1, 0, 0],
    [0, 0, 1, 0, 1],
    [1, 0, 1, 0, 1],
    [1, 0, 1, 1, 0],
]
let fifthExpected = [1, 2, 2, 2, 5]
let fifthRiverSizes = riverSizes(fifthMatrix).sorted()
assert(fifthExpected == fifthRiverSizes)

let sixthMatrix = [
    [1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0],
    [1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0],
    [0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1],
    [1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
    [1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1],
]
let sixthExpected = [1, 1, 2, 2, 5, 21]
let sixthRiverSizes = riverSizes(sixthMatrix).sorted()
assert(sixthExpected == sixthRiverSizes)

let seventhMatrix = [
    [1, 0, 0, 0, 0, 0, 1],
    [0, 1, 0, 0, 0, 1, 0],
    [0, 0, 1, 0, 1, 0, 0],
    [0, 0, 0, 1, 0, 0, 0],
    [0, 0, 1, 0, 1, 0, 0],
    [0, 1, 0, 0, 0, 1, 0],
    [1, 0, 0, 0, 0, 0, 1],
]
let seventhExpected = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
let seventhRiverSizes = riverSizes(seventhMatrix).sorted()
assert(seventhExpected == seventhRiverSizes)

let eighthMatrix = [
    [1, 0, 0, 0, 0, 0, 1],
    [0, 1, 0, 0, 0, 1, 0],
    [0, 0, 1, 0, 1, 0, 0],
    [0, 0, 1, 1, 1, 0, 0],
    [0, 0, 1, 0, 1, 0, 0],
    [0, 1, 0, 0, 0, 1, 0],
    [1, 0, 0, 0, 0, 0, 1],
]
let eighthExpected = [1, 1, 1, 1, 1, 1, 1, 1, 7]
let eighthRiverSizes = riverSizes(eighthMatrix).sorted()
assert(eighthExpected == eighthRiverSizes)

let ninthMatrix = [
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
]
let ninthExpected: [Int] = []
let ninthRiverSizes = riverSizes(ninthMatrix).sorted()
assert(ninthExpected == ninthRiverSizes)

let tenthMatrix = [
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
]
let tenthExpected = [49]
let tenthRiverSizes = riverSizes(tenthMatrix).sorted()
assert(tenthExpected == tenthRiverSizes)

let eleventhMatrix = [
    [1, 1, 0, 0, 0, 0, 1, 1],
    [1, 0, 1, 1, 1, 1, 0, 1],
    [0, 1, 1, 0, 0, 0, 1, 1],
]
let eleventhExpected = [3, 5, 6]
let eleventhRiverSizes = riverSizes(eleventhMatrix).sorted()
assert(eleventhExpected == eleventhRiverSizes)

let twelfthMatrix = [
    [1, 1, 0],
    [1, 0, 1],
    [1, 1, 1],
    [1, 1, 0],
    [1, 0, 1],
    [0, 1, 0],
    [1, 0, 0],
    [1, 0, 0],
    [0, 0, 0],
    [1, 0, 0],
    [1, 0, 1],
    [1, 1, 1],
]
let twelfthExpected = [1, 1, 2, 6, 10]
let twelfthRiverSizes = riverSizes(twelfthMatrix).sorted()
assert(twelfthExpected == twelfthRiverSizes)
