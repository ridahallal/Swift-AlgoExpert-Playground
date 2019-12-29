//Shifted Binary Search Solution #1
//O(log(n)) time | O(log(n)) space
func shiftedBinarySearchFirstSolution(_ array: [Int], _ target: Int) -> Int
{
    return shiftedBinarySearchFirstSolutionHelper(array, target, 0, array.count - 1)
}

func shiftedBinarySearchFirstSolutionHelper(_ array: [Int], _ target: Int, _ leftPointer: Int, _ rightPointer: Int) -> Int
{
    if leftPointer > rightPointer
    {
        return -1
    }
    
    let middle = (leftPointer + rightPointer) / 2
    let potentialMatch = array[middle]
    let leftNumber = array[leftPointer]
    let rightNumber = array[rightPointer]
    
    if target == potentialMatch
    {
        return middle
    }
    else if leftNumber < potentialMatch
    {
        if target < potentialMatch && target >= leftNumber
        {
            return shiftedBinarySearchFirstSolutionHelper(array, target, leftPointer, middle - 1)
        }
        else
        {
            return shiftedBinarySearchFirstSolutionHelper(array, target, middle + 1, rightPointer)
        }
    }
    else
    {
        if target <= rightNumber && target > potentialMatch
        {
            return shiftedBinarySearchFirstSolutionHelper(array, target, middle + 1, rightPointer)
        }
        else
        {
            return shiftedBinarySearchFirstSolutionHelper(array, target, leftPointer, middle - 1)
        }
    }
}

//Shifted Binary Search Solution #2
//O(log(n)) time | O(1) space
func shiftedBinarySearchSecondSolution(_ array: [Int], _ target: Int) -> Int
{
    var leftPointer = 0
    var rightPointer = array.count - 1
    
    return shiftedBinarySearchSecondSolutionHelper(array, target, &leftPointer, &rightPointer)
}

func shiftedBinarySearchSecondSolutionHelper(_ array: [Int], _ target: Int, _ leftPointer: inout Int, _ rightPointer: inout Int) -> Int
{
    while leftPointer <= rightPointer
    {
        let middle = (leftPointer + rightPointer) / 2
        let potentialMatch = array[middle]
        let leftNumber = array[leftPointer]
        let rightNumber = array[rightPointer]
        
        if target == potentialMatch
        {
            return middle
        }
        else if leftNumber < potentialMatch
        {
            if target < potentialMatch && target >= leftNumber
            {
                rightPointer = middle - 1
            }
            else
            {
                leftPointer = middle + 1
            }
        }
        else
        {
            if target <= rightNumber && target > potentialMatch
            {
                leftPointer = middle + 1
            }
            else
            {
                rightPointer = middle - 1
            }
        }
    }
    
    return -1
}

//Tests
//First Solution
assert(shiftedBinarySearchFirstSolution([5, 23, 111, 1], 111) == 2)
assert(shiftedBinarySearchFirstSolution([111, 1, 5, 23], 5) == 2)
assert(shiftedBinarySearchFirstSolution([23, 111, 1, 5], 35) == -1)
assert(shiftedBinarySearchFirstSolution([45, 61, 71, 72, 73, 0, 1, 21, 33, 45], 33) == 8)
assert(shiftedBinarySearchFirstSolution([61, 71, 72, 73, 0, 1, 21, 33, 45, 45], 33) == 7)
assert(shiftedBinarySearchFirstSolution([72, 73, 0, 1, 21, 33, 45, 45, 61, 71], 72) == 0)
assert(shiftedBinarySearchFirstSolution([71, 72, 73, 0, 1, 21, 33, 45, 45, 61], 73) == 2)
assert(shiftedBinarySearchFirstSolution([73, 0, 1, 21, 33, 45, 45, 61, 71, 72], 70) == -1)
assert(shiftedBinarySearchFirstSolution([33, 45, 45, 61, 71, 72, 73, 355, 0, 1, 21], 355) == 7)
assert(shiftedBinarySearchFirstSolution([33, 45, 45, 61, 71, 72, 73, 355, 0, 1, 21], 354) == -1)

//Second Solution
assert(shiftedBinarySearchSecondSolution([5, 23, 111, 1], 111) == 2)
assert(shiftedBinarySearchSecondSolution([111, 1, 5, 23], 5) == 2)
assert(shiftedBinarySearchSecondSolution([23, 111, 1, 5], 35) == -1)
assert(shiftedBinarySearchSecondSolution([45, 61, 71, 72, 73, 0, 1, 21, 33, 45], 33) == 8)
assert(shiftedBinarySearchSecondSolution([61, 71, 72, 73, 0, 1, 21, 33, 45, 45], 33) == 7)
assert(shiftedBinarySearchSecondSolution([72, 73, 0, 1, 21, 33, 45, 45, 61, 71], 72) == 0)
assert(shiftedBinarySearchSecondSolution([71, 72, 73, 0, 1, 21, 33, 45, 45, 61], 73) == 2)
assert(shiftedBinarySearchSecondSolution([73, 0, 1, 21, 33, 45, 45, 61, 71, 72], 70) == -1)
assert(shiftedBinarySearchSecondSolution([33, 45, 45, 61, 71, 72, 73, 355, 0, 1, 21], 355) == 7)
assert(shiftedBinarySearchSecondSolution([33, 45, 45, 61, 71, 72, 73, 355, 0, 1, 21], 354) == -1)
