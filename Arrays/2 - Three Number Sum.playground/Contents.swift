//Three Number Sum
func threeNumberSum(array: inout [Int], targetSum: Int) -> [[Int]]
{
    array.sort()
    
    var triplets: [[Int]] = []
    
    for i in 0..<array.count - 2
    {
        var left = i + 1
        var right = array.count - 1
        
        while left < right
        {
            let currentSum = array[i] + array[left] + array[right]
            
            if currentSum == targetSum
            {
                triplets.append([array[i], array[left], array[right]])
                
                left = left + 1
                right = right - 1
            }
            else if currentSum < targetSum
            {
                left = left + 1
            }
            else if currentSum > targetSum
            {
                right = right - 1
            }
        }
    }
    
    return triplets
}

//Tests
var array = [1, 2, 3]
var threeNumberSumResult = threeNumberSum(array: &array, targetSum: 6)
assert(threeNumberSumResult == [[1, 2, 3]])

array = [1, 2, 3]
threeNumberSumResult = threeNumberSum(array: &array, targetSum: 7)
assert(threeNumberSumResult == [])

array = [8, 10, -2, 49, 14]
threeNumberSumResult = threeNumberSum(array: &array, targetSum: 57)
assert(threeNumberSumResult == [[-2, 10, 49]])

array = [12, 3, 1, 2, -6, 5, -8, 6]
threeNumberSumResult = threeNumberSum(array: &array, targetSum: 0)
assert(threeNumberSumResult == [[-8, 2, 6], [-8, 3, 5], [-6, 1, 5]])

array = [12, 3, 1, 2, -6, 5, 0, -8, -1]
threeNumberSumResult = threeNumberSum(array: &array, targetSum: 0)
assert(threeNumberSumResult == [[-8, 3, 5], [-6, 1, 5], [-1, 0, 1]])

array = [12, 3, 1, 2, -6, 5, 0, -8, -1, 6]
threeNumberSumResult = threeNumberSum(array: &array, targetSum: 0)
assert(threeNumberSumResult == [[-8, 2, 6], [-8, 3, 5], [-6, 0, 6], [-6, 1, 5], [-1, 0, 1]])

array = [12, 3, 1, 2, -6, 5, 0, -8, -1, 6, -5]
threeNumberSumResult = threeNumberSum(array: &array, targetSum: 0)
assert(threeNumberSumResult == [[-8, 2, 6], [-8, 3, 5], [-6, 0, 6], [-6, 1, 5], [-5, -1, 6], [-5, 0, 5], [-5, 2, 3], [-1, 0, 1]])

array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 15]
threeNumberSumResult = threeNumberSum(array: &array, targetSum: 18)
assert(threeNumberSumResult == [[1, 2, 15], [1, 8, 9], [2, 7, 9], [3, 6, 9], [3, 7, 8], [4, 5, 9], [4, 6, 8], [5, 6, 7]])

array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 15]
threeNumberSumResult = threeNumberSum(array: &array, targetSum: 32)
assert(threeNumberSumResult == [[8, 9, 15]])

array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 15]
threeNumberSumResult = threeNumberSum(array: &array, targetSum: 33)
assert(threeNumberSumResult == [])

array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 15]
threeNumberSumResult = threeNumberSum(array: &array, targetSum: 5)
assert(threeNumberSumResult == [])
