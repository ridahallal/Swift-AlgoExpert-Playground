//O(n) time | O(n) space
func largestRange(array: [Int]) -> [Int]
{
    var longestLength = 0
    var bestRange = [Int]()
    var hash = [Int: Bool]()
    
    for number in array
    {
        hash[number] = true
    }
    
    for number in array
    {
        if let hashAtNumber = hash[number], !hashAtNumber
        {
            continue
        }
        
        var currentLength = 1
        var left = number - 1
        var right = number + 1
        
        while hash.keys.contains(left)
        {
            hash[left] = false
            currentLength += 1
            left -= 1
        }
        
        while hash.keys.contains(right)
        {
            hash[right] = false
            currentLength += 1
            right += 1
        }
        
        if currentLength > longestLength
        {
            bestRange = [left + 1, right - 1]
            longestLength = currentLength
        }
    }
    
    return bestRange
}

//Tests
assert(largestRange(array: [1]) == [1, 1])
assert(largestRange(array: [1, 2]) == [1, 2])
assert(largestRange(array: [4, 2, 1, 3]) == [1, 4])
assert(largestRange(array: [4, 2, 1, 3, 6]) == [1, 4])
assert(largestRange(array: [8, 4, 2, 10, 3, 6, 7, 9, 1]) == [6, 10])
assert(largestRange(array: [1, 11, 3, 0, 15, 5, 2, 4, 10, 7, 12, 6]) == [0, 7])
assert(largestRange(array: [19, -1, 18, 17, 2, 10, 3, 12, 5, 16, 4, 11, 8, 7, 6, 15, 12, 12, 2, 1, 6, 13, 14]) == [10, 19])
assert(largestRange(array: [0, 9, 19, -1, 18, 17, 2, 10, 3, 12, 5, 16, 4, 11, 8, 7, 6, 15, 12, 12, 2, 1, 6, 13, 14]) == [-1, 19])
assert(largestRange(array: [0, -5, 9, 19, -1, 18, 17, 2, -4, -3, 10, 3, 12, 5, 16, 4, 11, 7, -6, -7, 6, 15, 12, 12, 2, 1, 6, 13, 14, -2]) == [-7, 7])
assert(largestRange(array: [-7, -7, -7, -7, 8, -8, 0, 9, 19, -1, -3, 18, 17, 2, 10, 3, 12, 5, 16, 4, 11, -6, 8, 7, 6, 15, 12, 12, -5, 2, 1, 6, 13, 14, -4, -2]) == [-8, 19])
