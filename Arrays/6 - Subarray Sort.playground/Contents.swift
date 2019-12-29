//Subarray Sort
//O(n) time | O(1) space
func subarraySort(array: [Int]) -> [Int]
{
    var minimumOutOfOrder = Int(Int16.max)
    var maximumOutOfOrder = -Int(Int16.max)
    
    for i in 0 ..< array.count
    {
        let currentNumber = array[i]
        
        if isOutOfOrder(i, array, currentNumber)
        {
            minimumOutOfOrder = min(currentNumber, minimumOutOfOrder)
            maximumOutOfOrder = max(currentNumber, maximumOutOfOrder)
        }
    }
    
    if minimumOutOfOrder == Int(Int16.max)
    {
        return [-1, -1]
    }
    
    var subarrayLeftIndex = 0
    while minimumOutOfOrder >= array[subarrayLeftIndex]
    {
        subarrayLeftIndex += 1
    }
    
    var subarrayRightIndex = array.count - 1
    while maximumOutOfOrder <= array[subarrayRightIndex]
    {
        subarrayRightIndex -= 1
    }
    
    return[subarrayLeftIndex, subarrayRightIndex]
}

func isOutOfOrder(_ i: Int, _ array: [Int], _ currentNumber: Int) -> Bool
{
    if i == 0
    {
        return currentNumber > array[i + 1]
    }
    else if i == array.count - 1
    {
        return currentNumber < array[i - 1]
    }
    else
    {
        return currentNumber > array[i + 1] || currentNumber < array[i - 1]
    }
}

//Tests
assert(subarraySort(array: [1, 2]) == [-1, -1])
assert(subarraySort(array: [2, 1]) == [0, 1])
assert(subarraySort(array: [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19]) == [3, 9])
assert(subarraySort(array: [1, 2, 4, 7, 10, 11, 7, 12, 7, 7, 16, 18, 19]) == [4, 9])
assert(subarraySort(array: [1, 2, 4, 7, 10, 11, 7, 12, 13, 14, 16, 18, 19]) == [4, 6])
assert(subarraySort(array: [1, 2, 8, 4, 5]) == [2, 4])
assert(subarraySort(array: [4, 8, 7, 12, 11, 9, -1, 3, 9, 16, -15, 51, 7]) == [0, 12])
assert(subarraySort(array: [4, 8, 7, 12, 11, 9, -1, 3, 9, 16, -15, 11, 57]) == [0, 11])
assert(subarraySort(array: [-41, 8, 7, 12, 11, 9, -1, 3, 9, 16, -15, 11, 57]) == [1, 11])
assert(subarraySort(array: [-41, 8, 7, 12, 11, 9, -1, 3, 9, 16, -15, 51, 7]) == [1, 12])
assert(subarraySort(array: [1, 2, 3, 4, 5, 6, 8, 7, 9, 10, 11]) == [6, 7])
assert(subarraySort(array: [1, 2, 3, 4, 5, 6, 18, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19]) == [6, 16])
assert(subarraySort(array: [1, 2, 3, 4, 5, 6, 18, 21, 22, 7, 14, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 4, 14, 11, 6, 33, 35, 41, 55]) == [4, 24])
assert(subarraySort(array: [1, 2, 20, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]) == [2, 19])
assert(subarraySort(array: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 2]) == [2, 19])
assert(subarraySort(array: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]) == [-1, -1])
assert(subarraySort(array: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]) == [-1, -1])
