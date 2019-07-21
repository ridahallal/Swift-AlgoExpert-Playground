//Four Number Sum
//Average: O(n^2) time | O(n^2) space
//Worst: O(n^3) time | O(n^2) space
func fourNumberSum(array: [Int], targetSum: Int) -> [[Int]]
{
    //Dictionary that will contain all of our pair sums like 10 -> [[4, 6], [1, 9]]
    var allPairSums = [Int: [[Int]]]()
    
    //Result array
    var quadruplets = [[Int]]()
    
    //Iterate from second number till last number - 1
    for i in 1 ..< array.count - 1
    {
        //Iterate from that number till the end of the array
        for j in i + 1 ..< array.count
        {
            //Calculate the sum at i and j
            let currentSum = array[i] + array[j]
            let difference = targetSum - currentSum
            
            if allPairSums.keys.contains(difference)
            {
                for pair in allPairSums[difference]!
                {
                    quadruplets.append(pair + [array[i], array[j]])
                }
            }
        }
        
        //Iterate from the beginning of the array up to i
        for k in 0 ..< i
        {
            let currentSum = array[k] + array[i]
            
            if !allPairSums.keys.contains(currentSum)
            {
                allPairSums[currentSum] = [[array[k], array[i]]]
            }
            else
            {
                allPairSums[currentSum]!.append([array[k], array[i]])
            }
        }
    }
    
    return quadruplets
}

//Tests
func sortAndStringify(array: [Int]) -> String
{
    let stringifiedArray = array.sorted(by: {$0 < $1}).map{"\($0)"}.reduce(""){$0 + $1}
    
    return stringifiedArray
}

func testFourNumberSum(count: Int, target: Int, numbers: [Int], quadruplets: [[Int]])
{
    let output = fourNumberSum(array: numbers, targetSum: target)
    
    let outputStringified = output.map
    {
        array -> String in
        
        sortAndStringify(array: array)
    }
    
    assert(output.count == count)
    
    for quadruplet in quadruplets
    {
        assert(outputStringified.contains(sortAndStringify(array: quadruplet)))
    }
}

var count = 1
var target = 10
var numbers = [1, 2, 3, 4, 5, 6, 7]
var quadruplets =
    [
        [1, 2, 3, 4]
    ]

testFourNumberSum(count: count, target: target, numbers: numbers, quadruplets: quadruplets)

count = 2
target = 16
numbers = [7, 6, 4, -1, 1, 2]
quadruplets =
    [
        [7, 6, 4, -1],
        [7, 6, 1, 2]
    ]

testFourNumberSum(count: count, target: target, numbers: numbers, quadruplets: quadruplets)

count = 3
target = 0
numbers = [5, -5, -2, 2, 3, -3]
quadruplets =
    [
        [5, -5, -2, 2],
        [5, -5, 3, -3],
        [-2, 2, 3, -3],
    ]

testFourNumberSum(count: count, target: target, numbers: numbers, quadruplets: quadruplets)

count = 4
target = 4
numbers = [-2, -1, 1, 2, 3, 4, 5, 6, 7, 8, 9]
quadruplets =
    [
        [-2, -1, 1, 6],
        [-2, 1, 2, 3],
        [-2, -1, 2, 5],
        [-2, -1, 3, 4],
    ]

testFourNumberSum(count: count, target: target, numbers: numbers, quadruplets: quadruplets)

count = 5
target = 30
numbers = [-1, 22, 18, 4, 7, 11, 2, -5, -3]
quadruplets =
    [
        [-1, 22, 7, 2],
        [22, 4, 7, -3],
        [-1, 18, 11, 2],
        [18, 4, 11, -3],
        [22, 11, 2, -5],
    ]

testFourNumberSum(count: count, target: target, numbers: numbers, quadruplets: quadruplets)

count = 7
target = 20
numbers = [-10, -3, -5, 2, 15, -7, 28, -6, 12, 8, 11, 5]
quadruplets =
    [
        [-5, 2, 15, 8],
        [-3, 2, -7, 28],
        [-10, -3, 28, 5],
        [-10, 28, -6, 8],
        [-7, 28, -6, 5],
        [-5, 2, 12, 11],
        [-5, 12, 8, 5],
    ]

testFourNumberSum(count: count, target: target, numbers: numbers, quadruplets: quadruplets)

target = 100
numbers = [1, 2, 3, 4, 5]
let output = fourNumberSum(array: numbers, targetSum: target)
let outputStringified = output.map
{
    array -> String in
    
    sortAndStringify(array: array)
}

assert(output.count == 0)
