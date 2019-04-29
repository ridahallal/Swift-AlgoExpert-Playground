//Binary Search

//Solution #1
//O(Log(n)) time | O(Log(n)) space
func binarySearchFirstSolution(array: [Int], target: Int) -> Int
{
    return binarySearchFirstSolutionHelper(array: array, target: target, leftPointer: 0, rightPointer: array.count - 1)
}

func binarySearchFirstSolutionHelper(array: [Int], target: Int, leftPointer: Int, rightPointer: Int) -> Int
{
    //This means we didn't find any matches
    if leftPointer > rightPointer
    {
        return -1
    }
    
    //Sum up the pointers and find the middle pointer
    let middle = (leftPointer + rightPointer) / 2
    
    //Potential match is the element at the middle index
    let potentialMatch = array[middle]
    
    //If the target and the potential match are equal
    if target == potentialMatch
    {
        //Return the index of our match
        return middle
    }
    //If the target is less than the potential match
    else if target < potentialMatch
    {
        //Update our right pointer (eliminate the right half)
        return binarySearchFirstSolutionHelper(array: array, target: target, leftPointer: leftPointer, rightPointer: middle - 1)
    }
    //If the target is greater than the potential match
    else
    {
        //Update our left pointer (eliminate the left half)
        return binarySearchFirstSolutionHelper(array: array, target: target, leftPointer: middle + 1, rightPointer: rightPointer)
    }
}

//Solution #2
//O(Log(n)) time | O(1) space
func binarySearchSecondSolution(array: [Int], target: Int) -> Int
{
    var leftPointer = 0
    var rightPointer = array.count - 1
    return binarySearchSecondSolutionHelper(array: array, target: target, leftPointer: &leftPointer, rightPointer: &rightPointer)
}

func binarySearchSecondSolutionHelper(array: [Int], target: Int, leftPointer: inout Int, rightPointer: inout Int) -> Int
{
    //Using a while loop will reduce the number of calls on the call stack compared to the recursive algorithm
    while leftPointer <= rightPointer
    {
        //Sum up the pointers and find the middle pointer
        let middle = (leftPointer + rightPointer) / 2
        
        //Potential match is the element at the middle index
        let potentialMatch = array[middle]
        
        //If the target and the potential match are equal
        if target == potentialMatch
        {
            //Return the index of our match
            return middle
        }
        //If the target is less than the potential match
        else if target < potentialMatch
        {
            //Update our right pointer (eliminate the right half)
            rightPointer = middle - 1
        }
        //If the target is greater than the potential match
        else
        {
            //Update our left pointer (eliminate the left half)
            leftPointer = middle + 1
        }
    }
    
    return -1
}

//Tests
//First Solution
assert(binarySearchFirstSolution(array: [1, 5, 23, 111], target: 111) == 3)
assert(binarySearchFirstSolution(array: [1, 5, 23, 111], target: 5) == 1)
assert(binarySearchFirstSolution(array: [1, 5, 23, 111], target: 35) == -1)
assert(binarySearchFirstSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73], target: 33) == 3)
assert(binarySearchFirstSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73], target: 72) == 8)
assert(binarySearchFirstSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73], target: 73) == 9)
assert(binarySearchFirstSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73], target: 70) == -1)
assert(binarySearchFirstSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73, 355], target: 355) == 10)
assert(binarySearchFirstSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73, 355], target: 354) == -1)

//Second Solution
assert(binarySearchSecondSolution(array: [1, 5, 23, 111], target: 111) == 3)
assert(binarySearchSecondSolution(array: [1, 5, 23, 111], target: 5) == 1)
assert(binarySearchSecondSolution(array: [1, 5, 23, 111], target: 35) == -1)
assert(binarySearchSecondSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73], target: 33) == 3)
assert(binarySearchSecondSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73], target: 72) == 8)
assert(binarySearchSecondSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73], target: 73) == 9)
assert(binarySearchSecondSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73], target: 70) == -1)
assert(binarySearchSecondSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73, 355], target: 355) == 10)
assert(binarySearchSecondSolution(array: [0, 1, 21, 33, 45, 45, 61, 71, 72, 73, 355], target: 354) == -1)
