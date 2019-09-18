//Longest Increasing Subsequence
//Solution #1
//O(n^2) time | O(n) space
func longestIncreasingSubsequenceFirstSolution(_ array: [Int]) -> [Int]
{
    var indexOfMaxLength: Int? = 0
    var lengths = Array(repeating: 1, count: array.count)
    var sequences: [Int?] = Array(repeating: nil, count: array.count)
    
    for i in 0 ..< array.count
    {
        let currentNumber = array[i]
        
        for j in 0 ..< i
        {
            let otherNumber = array[j]
            
            if otherNumber < currentNumber && lengths[i] <= lengths[j] + 1
            {
                lengths[i] = lengths[j] + 1
                sequences[i] = j
            }
        }
        
        if lengths[i] > lengths[indexOfMaxLength!]
        {
            indexOfMaxLength = i
        }
    }
    
    return buildSequence(array, sequences, &indexOfMaxLength)
}

//Solution #2
//O(nlogn) time | O(n) space
func longestIncreasingSubsequenceSecondSolution(_ array: [Int]) -> [Int]
{
    var length = 0
    var indices: [Int?] = Array(repeating: nil, count: array.count + 1)
    var sequences: [Int?] = Array(repeating: nil, count: array.count)
    
    for i in 0 ..< array.count
    {
        var startIndex = 1
        var endIndex = length
        let number = array[i]
        let newLength = binarySearch(&startIndex, &endIndex, indices, array, number)
        
        indices[newLength] = i
        sequences[i] = indices[newLength - 1]
        length = max(length, newLength)
    }
    
    return buildSequence(array, sequences, &indices[length])
}

func binarySearch(_ startIndex: inout Int, _ endIndex: inout Int, _ indices: [Int?], _ array: [Int], _ number: Int) -> Int
{
    if startIndex > endIndex
    {
        return startIndex
    }
    
    var middleIndex = Double(startIndex + endIndex) / 2
    middleIndex = middleIndex.rounded(.down)
    let intMiddle = Int(middleIndex)
    
    if let index = indices[intMiddle]
    {
        let numberToCompare = array[index]
        
        if numberToCompare < number
        {
            startIndex = intMiddle + 1
        }
        else
        {
            endIndex = intMiddle - 1
        }
    }
    
    return binarySearch(&startIndex, &endIndex, indices, array, number)
}

//Common
func buildSequence(_ array: [Int], _ sequences: [Int?], _ currentIndex: inout Int?) -> [Int]
{
    var sequence = [Int]()
    
    while currentIndex != nil
    {
        sequence.insert(array[currentIndex!], at: 0)
        currentIndex = sequences[currentIndex!]
    }
    
    return sequence
}

//Tests
assert(longestIncreasingSubsequenceFirstSolution([-1]) == [-1])
assert(longestIncreasingSubsequenceFirstSolution([-1, 2]) == [-1, 2])
assert(longestIncreasingSubsequenceFirstSolution([-1, 2, 1, 2]) == [-1, 1, 2])
assert(longestIncreasingSubsequenceFirstSolution([1, 5, -1, 10]) == [1, 5, 10])
assert(longestIncreasingSubsequenceFirstSolution([1, 5, -1, 0, 6, 2, 4]) == [-1, 0, 2, 4])
assert(longestIncreasingSubsequenceFirstSolution([3, 4, -1]) == [3, 4])
assert(longestIncreasingSubsequenceFirstSolution([29, 2, 20, 12, 30, 31]) == [2, 12, 30, 31])
assert(longestIncreasingSubsequenceFirstSolution([5, 7, -24, 12, 10, 2, 3, 12, 5, 6, 35]) == [-24, 2, 3, 5, 6, 35])
assert(longestIncreasingSubsequenceFirstSolution([10, 22, 9, 33, 21, 50, 41, 60, 80]) == [10, 22, 33, 41, 60, 80])
assert(longestIncreasingSubsequenceFirstSolution([100, 1, 2, 3, 4, 101]) == [1, 2, 3, 4, 101])

assert(longestIncreasingSubsequenceSecondSolution([-1]) == [-1])
assert(longestIncreasingSubsequenceSecondSolution([-1, 2]) == [-1, 2])
assert(longestIncreasingSubsequenceSecondSolution([-1, 2, 1, 2]) == [-1, 1, 2])
assert(longestIncreasingSubsequenceSecondSolution([1, 5, -1, 10]) == [1, 5, 10])
assert(longestIncreasingSubsequenceSecondSolution([1, 5, -1, 0, 6, 2, 4]) == [-1, 0, 2, 4])
assert(longestIncreasingSubsequenceSecondSolution([3, 4, -1]) == [3, 4])
assert(longestIncreasingSubsequenceSecondSolution([29, 2, 20, 12, 30, 31]) == [2, 12, 30, 31])
assert(longestIncreasingSubsequenceSecondSolution([5, 7, -24, 12, 10, 2, 3, 12, 5, 6, 35]) == [-24, 2, 3, 5, 6, 35])
assert(longestIncreasingSubsequenceSecondSolution([10, 22, 9, 33, 21, 50, 41, 60, 80]) == [10, 22, 33, 41, 60, 80])
assert(longestIncreasingSubsequenceSecondSolution([100, 1, 2, 3, 4, 101]) == [1, 2, 3, 4, 101])
