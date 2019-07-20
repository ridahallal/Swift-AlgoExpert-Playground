//Single Cycle Check
//O(n) time | O(1) space
func hasSingleCycle(array: [Int]) -> Bool
{
    var currentIndex = 0
    var numberOfElementsVisited = 0
    
    while numberOfElementsVisited < array.count
    {
        if currentIndex == 0 && numberOfElementsVisited > 0
        {
            return false
        }
        
        numberOfElementsVisited += 1
        currentIndex = getNextIndex(&currentIndex, array: array)
    }
    
    return currentIndex == 0
}

func getNextIndex(_ currentIndex: inout Int, array: [Int]) -> Int
{
    let jump = array[currentIndex]
    let nextIndex = (jump + currentIndex) % array.count
    
    if nextIndex >= 0
    {
        return nextIndex
    }
    else
    {
        return nextIndex + array.count
    }
}

//Tests
assert(hasSingleCycle(array: [2, 2, -1]) == true)
assert(hasSingleCycle(array: [2, 2, 2]) == true)
assert(hasSingleCycle(array: [1, 1, 1, 1, 1]) == true)
assert(hasSingleCycle(array: [-1, 2, 2]) == true)
assert(hasSingleCycle(array: [0, 1, 1, 1, 1]) == false)
assert(hasSingleCycle(array: [1, 1, 0, 1, 1]) == false)
assert(hasSingleCycle(array: [1, 1, 1, 1, 2]) == false)
assert(hasSingleCycle(array: [3, 5, 6, -5, -2, -5, -12, -2, -1, 2, -6, 1, 1, 2, -5, 2]) == true)
assert(hasSingleCycle(array: [3, 5, 5, -5, -2, -5, -12, -2, -1, 2, -6, 1, 1, 2, -5, 2]) == false)
assert(hasSingleCycle(array: [1, 2, 3, 4, -2, 3, 7, 8, 1]) == true)
assert(hasSingleCycle(array: [1, 2, 3, 4, -2, 3, 7, 8, -8]) == true)
assert(hasSingleCycle(array: [1, 2, 3, 4, -2, 3, 7, 8, -26]) == true)
assert(hasSingleCycle(array: [10, 11, -6, -23, -2, 3, 88, 908, -26]) == true)
assert(hasSingleCycle(array: [10, 11, -6, -23, -2, 3, 88, 909, -26]) == false)
assert(hasSingleCycle(array: [2, 3, 1, -4, -4, 2]) == true)
