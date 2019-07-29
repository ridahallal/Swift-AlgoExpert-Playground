//Min Number Of Jumps
//Solution #1
//O(n^2) time | O(n) space
func minNumberOfJumpsFirstSolution(array: [Int]) -> Int
{
    var jumps = Array(repeating: Int.max, count: array.count)
    
    jumps[0] = 0
    
    for i in 0 ..< array.count
    {
        for j in 0 ..< i
        {
            //If we can jump to or past the index
            if array[j] + j >= i
            {
                //Select the min value between the current jump value
                //and the earlier jump value plus 1
                jumps[i] = min(jumps[i], jumps[j] + 1)
            }
        }
    }
    
    return jumps[jumps.count - 1]
}

//Solution #2
func minNumberOfJumpsSecondSolution(array: [Int]) -> Int
{
    if array.count == 1
    {
        return 0
    }
    
    var jumps = 0
    var steps = array[0]
    var maximumReach = array[0]
    
    for i in 1 ..< array.count - 1
    {
        maximumReach = max(maximumReach, array[i] + i)
        steps -= 1
        
        if steps == 0
        {
            jumps += 1
            steps = maximumReach - i
        }
    }
    
    return jumps + 1
}

//Tests
assert(minNumberOfJumpsFirstSolution(array: [1]) == 0)
assert(minNumberOfJumpsFirstSolution(array: [1, 1]) == 1)
assert(minNumberOfJumpsFirstSolution(array: [3, 1]) == 1)
assert(minNumberOfJumpsFirstSolution(array: [1, 1, 1]) == 2)
assert(minNumberOfJumpsFirstSolution(array: [2, 1, 1]) == 1)
assert(minNumberOfJumpsFirstSolution(array: [2, 1, 2, 3, 1]) == 2)
assert(minNumberOfJumpsFirstSolution(array: [2, 1, 2, 3, 1, 1, 1]) == 3)
assert(minNumberOfJumpsFirstSolution(array: [2, 1, 2, 2, 1, 1, 1]) == 4)
assert(minNumberOfJumpsFirstSolution(array: [3, 4, 2, 1, 2, 3, 7, 1, 1, 1, 3]) == 4)
assert(minNumberOfJumpsFirstSolution(array: [3, 4, 2, 1, 2, 3, 7, 1, 1, 1, 3, 2, 6, 2, 1, 1, 1, 1]) == 5)
assert(minNumberOfJumpsFirstSolution(array: [3, 4, 2, 1, 2, 3, 7, 1, 1, 1, 3, 2, 3, 2, 1, 1, 1, 1]) == 7)
assert(minNumberOfJumpsFirstSolution(array: [3, 10, 2, 1, 2, 3, 7, 1, 1, 1, 3, 2, 3, 2, 1, 1, 1, 1]) == 6)
assert(minNumberOfJumpsFirstSolution(array: [3, 12, 2, 1, 2, 3, 7, 1, 1, 1, 3, 2, 3, 2, 1, 1, 1, 1]) == 5)
assert(minNumberOfJumpsFirstSolution(array: [3, 12, 2, 1, 2, 3, 15, 1, 1, 1, 3, 2, 3, 2, 1, 1, 1, 1]) == 3)

assert(minNumberOfJumpsSecondSolution(array: [1]) == 0)
assert(minNumberOfJumpsSecondSolution(array: [1, 1]) == 1)
assert(minNumberOfJumpsSecondSolution(array: [3, 1]) == 1)
assert(minNumberOfJumpsSecondSolution(array: [1, 1, 1]) == 2)
assert(minNumberOfJumpsSecondSolution(array: [2, 1, 1]) == 1)
assert(minNumberOfJumpsSecondSolution(array: [2, 1, 2, 3, 1]) == 2)
assert(minNumberOfJumpsSecondSolution(array: [2, 1, 2, 3, 1, 1, 1]) == 3)
assert(minNumberOfJumpsSecondSolution(array: [2, 1, 2, 2, 1, 1, 1]) == 4)
assert(minNumberOfJumpsSecondSolution(array: [3, 4, 2, 1, 2, 3, 7, 1, 1, 1, 3]) == 4)
assert(minNumberOfJumpsSecondSolution(array: [3, 4, 2, 1, 2, 3, 7, 1, 1, 1, 3, 2, 6, 2, 1, 1, 1, 1]) == 5)
assert(minNumberOfJumpsSecondSolution(array: [3, 4, 2, 1, 2, 3, 7, 1, 1, 1, 3, 2, 3, 2, 1, 1, 1, 1]) == 7)
assert(minNumberOfJumpsSecondSolution(array: [3, 10, 2, 1, 2, 3, 7, 1, 1, 1, 3, 2, 3, 2, 1, 1, 1, 1]) == 6)
assert(minNumberOfJumpsSecondSolution(array: [3, 12, 2, 1, 2, 3, 7, 1, 1, 1, 3, 2, 3, 2, 1, 1, 1, 1]) == 5)
assert(minNumberOfJumpsSecondSolution(array: [3, 12, 2, 1, 2, 3, 15, 1, 1, 1, 3, 2, 3, 2, 1, 1, 1, 1]) == 3)
