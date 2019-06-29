//Maximum Subset Sum With No Adjacent Elements
//O(n) time | O(n) space
func maximumSubsetSumWithNoAdjacentElements(array: [Int]) -> Int
{
    if array.count == 0
    {
        return 0
    }
    
    if array.count == 1
    {
        return array.first!
    }
    
    var maxSums = array
    maxSums[1] = max(maxSums[0], maxSums[1])
    
    for i in 2 ..< array.count
    {
        maxSums[i] = max(maxSums[i - 1], maxSums[i - 2] + array[i])
    }
    
    return maxSums[maxSums.count - 1]
}

//Tests
assert(maximumSubsetSumWithNoAdjacentElements(array: []) == 0)
assert(maximumSubsetSumWithNoAdjacentElements(array: [1]) == 1)
assert(maximumSubsetSumWithNoAdjacentElements(array: [1, 2]) == 2)
assert(maximumSubsetSumWithNoAdjacentElements(array: [1, 2 , 3]) == 4)
assert(maximumSubsetSumWithNoAdjacentElements(array: [1, 15, 3]) == 15)
assert(maximumSubsetSumWithNoAdjacentElements(array: [7, 10, 12, 7, 9, 14]) == 33)
assert(maximumSubsetSumWithNoAdjacentElements(array: [4, 3, 5, 200, 5, 3]) == 207)
assert(maximumSubsetSumWithNoAdjacentElements(array: [10, 5, 20, 25, 15, 5, 5, 15, 3, 15, 5, 5, 15]) == 90)
assert(maximumSubsetSumWithNoAdjacentElements(array: [125, 210, 250, 120, 150, 300]) == 675)
assert(maximumSubsetSumWithNoAdjacentElements(array: [30, 25, 50, 55, 100]) == 180)
assert(maximumSubsetSumWithNoAdjacentElements(array: [30, 25, 50, 55, 100, 120]) == 205)
assert(maximumSubsetSumWithNoAdjacentElements(array: [7, 10, 12, 7, 9, 14, 15, 16, 25, 20, 4]) == 72)
