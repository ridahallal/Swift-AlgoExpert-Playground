//Search For Range Solution #1
//O(log(n)) time | O(log(n)) space
func searchForRangeFirstSolution(_ array: [Int], _ target: Int) -> [Int]
{
    var finalRange = [-1, -1]
    
    alteredBinarySearchRecursive(array, target, 0, array.count - 1, &finalRange, true)
    alteredBinarySearchRecursive(array, target, 0, array.count - 1, &finalRange, false)
    return finalRange
}

func alteredBinarySearchRecursive(_ array: [Int], _ target: Int, _ leftPointer: Int, _ rightPointer: Int, _ finalRange: inout [Int], _ goLeft: Bool)
{
    if leftPointer > rightPointer
    {
        return
    }
    
    let middle = (leftPointer + rightPointer) / 2
    
    if array[middle] > target
    {
        alteredBinarySearchRecursive(array, target, leftPointer, middle - 1, &finalRange, goLeft)
    }
    else if array[middle] < target
    {
        alteredBinarySearchRecursive(array, target, middle + 1, rightPointer, &finalRange, goLeft)
    }
    else
    {
        if goLeft
        {
            if middle == 0 || array[middle] != array[middle - 1]
            {
                finalRange[0] = middle
            }
            else
            {
                alteredBinarySearchRecursive(array, target, leftPointer, middle - 1, &finalRange, goLeft)
            }
        }
        else
        {
            if middle == array.count - 1 || array[middle] != array[middle + 1]
            {
                finalRange[1] = middle
            }
            else
            {
                alteredBinarySearchRecursive(array, target, middle + 1, rightPointer, &finalRange, goLeft)
            }
        }
    }
}

//Search For Range Solution #2
//O(log(n)) time | O(1) space
func searchForRangeSecondSolution(_ array: [Int], _ target: Int) -> [Int]
{
    var finalRange = [-1, -1]
    
    var leftPointer = 0
    var rightPointer = array.count - 1
    
    alteredBinarySearchIterative(array, target, &leftPointer, &rightPointer, &finalRange, true)
    
    leftPointer = 0
    rightPointer = array.count - 1
    alteredBinarySearchIterative(array, target, &leftPointer, &rightPointer, &finalRange, false)
    return finalRange
}

func alteredBinarySearchIterative(_ array: [Int], _ target: Int, _ leftPointer: inout Int, _ rightPointer: inout Int, _ finalRange: inout [Int], _ goLeft: Bool)
{
    while leftPointer <= rightPointer
    {
        let middle = (leftPointer + rightPointer) / 2
        
        if array[middle] > target
        {
            rightPointer = middle - 1
        }
        else if array[middle] < target
        {
            leftPointer = middle + 1
        }
        else
        {
            if goLeft
            {
                if middle == 0 || array[middle] != array[middle - 1]
                {
                    finalRange[0] = middle
                    return
                }
                else
                {
                    rightPointer = middle - 1
                }
            }
            else
            {
                if middle == array.count - 1 || array[middle] != array[middle + 1]
                {
                    finalRange[1] = middle
                    return
                }
                else
                {
                    leftPointer = middle + 1
                }
            }
        }
    }
}

//Tests
assert(searchForRangeFirstSolution([5, 7, 7, 8, 8, 10], 5) == [0, 0])
assert(searchForRangeFirstSolution([5, 7, 7, 8, 8, 10], 7) == [1, 2])
assert(searchForRangeFirstSolution([5, 7, 7, 8, 8, 10], 8) == [3, 4])
assert(searchForRangeFirstSolution([5, 7, 7, 8, 8, 10], 10) == [5, 5])
assert(searchForRangeFirstSolution([5, 7, 7, 8, 8, 10], 9) == [-1, -1])
assert(searchForRangeFirstSolution([0, 1, 21, 33, 45, 45, 45, 45, 45, 45, 61, 71, 73], 47) == [-1, -1])
assert(searchForRangeFirstSolution([0, 1, 21, 33, 45, 45, 45, 45, 45, 45, 61, 71, 73], -1) == [-1, -1])
assert(searchForRangeFirstSolution([0, 1, 21, 33, 45, 45, 45, 45, 45, 45, 61, 71, 73], 45) == [4, 9])
assert(searchForRangeFirstSolution([0, 1, 21, 33, 45, 45, 45, 45, 45, 45, 45, 45, 45], 45) == [4, 12])

assert(searchForRangeSecondSolution([5, 7, 7, 8, 8, 10], 5) == [0, 0])
assert(searchForRangeSecondSolution([5, 7, 7, 8, 8, 10], 7) == [1, 2])
assert(searchForRangeSecondSolution([5, 7, 7, 8, 8, 10], 8) == [3, 4])
assert(searchForRangeSecondSolution([5, 7, 7, 8, 8, 10], 10) == [5, 5])
assert(searchForRangeSecondSolution([5, 7, 7, 8, 8, 10], 9) == [-1, -1])
assert(searchForRangeSecondSolution([0, 1, 21, 33, 45, 45, 45, 45, 45, 45, 61, 71, 73], 47) == [-1, -1])
assert(searchForRangeSecondSolution([0, 1, 21, 33, 45, 45, 45, 45, 45, 45, 61, 71, 73], -1) == [-1, -1])
assert(searchForRangeSecondSolution([0, 1, 21, 33, 45, 45, 45, 45, 45, 45, 61, 71, 73], 45) == [4, 9])
assert(searchForRangeSecondSolution([0, 1, 21, 33, 45, 45, 45, 45, 45, 45, 45, 45, 45], 45) == [4, 12])
