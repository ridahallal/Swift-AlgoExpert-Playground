//Kadane's Algorithm
//O(n) time | O(1) space)
func kadanesAlgorithm(array: [Int]) -> Int
{
    if array.count > 0
    {
        var maxEndingHere = array.first
        var maxSoFar = array.first
        
        for i in 1 ..< array.count
        {
            let currentNumber = array[i]
            
            maxEndingHere = max(currentNumber, currentNumber + maxEndingHere!)
            maxSoFar = max(maxSoFar!, maxEndingHere!)
        }
        
        return maxSoFar!
    }
    else
    {
        return -1
    }
}

//Tests
assert(kadanesAlgorithm(array: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == 55)
assert(kadanesAlgorithm(array: [-1, -2, -3, -4, -5, -6, -7, -8, -9, -10]) == -1)
assert(kadanesAlgorithm(array: [-10, -2, -9, -4, -8, -6, -7, -1, -3, -5]) == -1)
assert(kadanesAlgorithm(array: [1, 2, 3, 4, 5, 6, -20, 7, 8, 9, 10]) == 35)
assert(kadanesAlgorithm(array: [1, 2, 3, 4, 5, 6, -22, 7, 8, 9, 10]) == 34)
assert(kadanesAlgorithm(array: [1, 2, -4, 3, 5, -9, 8, 1, 2]) == 11)
assert(kadanesAlgorithm(array: [3, 4, -6, 7, 8]) == 16)
assert(kadanesAlgorithm(array: [3, 5, -9, 1, 3, -2, 3, 4, 7, 2, -9, 6, 3, 1, -5, 4]) == 19)
assert(kadanesAlgorithm(array: [8, 5, -9, 1, 3, -2, 3, 4, 7, 2, -9, 6, 3, 1, -5, 4]) == 23)
assert(kadanesAlgorithm(array: [8, 5, -9, 1, 3, -2, 3, 4, 7, 2, -9, 6, 3, 1, -5, 6]) == 24)
assert(kadanesAlgorithm(array: [8, 5, -9, 1, 3, -2, 3, 4, 7, 2, -18, 6, 3, 1, -5, 6]) == 22)
assert(kadanesAlgorithm(array: [8, 5, -9, 1, 3, -2, 3, 4, 7, 2, -18, 6, 3, 1, -5, 6, 20, -23, 15, 1, -3, 4]) == 35)
assert(kadanesAlgorithm(array: [100, 8, 5, -9, 1, 3, -2, 3, 4, 7, 2, -18, 6, 3, 1, -5, 6, 20, -23, 15, 1, -3, 4]) == 135)
