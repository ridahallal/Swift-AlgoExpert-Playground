//Quickselect
//Best: O(n) time | O(1) space
//Average: O(n) time | O(1) space
//Worst: O(n ^ 2) time | O(1) space
enum QuickSelectError: String, Error
{
    case outOfBoundsError = "Your algorithm should never arrive here!"
}

func quickSelect(_ array: [Int], _ k: Int) -> Int?
{
    let position = k - 1
    var startIndex = 0
    var endIndex = array.count - 1
    var variableArray = array
    
    do
    {
        return try quickSelectHelper(&variableArray, &startIndex, &endIndex, position)
    }
    catch QuickSelectError.outOfBoundsError
    {
        QuickSelectError.outOfBoundsError
        return nil
    }
    catch
    {
        print(error)
        return -1
    }
}

func quickSelectHelper(_ array: inout [Int], _ startIndex: inout Int, _ endIndex: inout Int, _ position: Int) throws -> Int
{
    while true
    {
        if startIndex > endIndex
        {
            throw QuickSelectError.outOfBoundsError
        }
        
        let pivotIndex = startIndex
        var leftPointer = startIndex + 1
        var rightPointer = endIndex
        
        while leftPointer <= rightPointer
        {
            if array[leftPointer] > array[pivotIndex] && array[rightPointer] < array[pivotIndex]
            {
                swap(&array, leftPointer, rightPointer)
            }
            
            if array[leftPointer] <= array[pivotIndex]
            {
                leftPointer += 1
            }
            
            if array[rightPointer] >= array[pivotIndex]
            {
                rightPointer -= 1
            }
        }
        
        swap(&array, pivotIndex, rightPointer)
        
        if rightPointer == position
        {
            return array[rightPointer]
        }
        else if rightPointer < position
        {
            startIndex = rightPointer +  1
        }
        else
        {
            endIndex = rightPointer - 1
        }
    }
}

func swap(_ array: inout [Int], _ leftPointer: Int, _ rightPointer: Int)
{
    let temp = array[leftPointer]
    
    array[leftPointer] = array[rightPointer]
    array[rightPointer] = temp
}

//Tests
assert(quickSelect([1], 1) == 1)
assert(quickSelect([43, 24, 37], 1) == 24)
assert(quickSelect([43, 24, 37], 2) == 37)
assert(quickSelect([43, 24, 37], 3) == 43)
assert(quickSelect([8, 5, 2, 9, 7, 6, 3], 3) == 5)
assert(quickSelect([8, 3, 2, 5, 1, 7, 4, 6], 1) == 1)
assert(quickSelect([8, 3, 2, 5, 1, 7, 4, 6], 2) == 2)
assert(quickSelect([8, 3, 2, 5, 1, 7, 4, 6], 3) == 3)
assert(quickSelect([8, 3, 2, 5, 1, 7, 4, 6], 4) == 4)
assert(quickSelect([8, 3, 2, 5, 1, 7, 4, 6], 5) == 5)
assert(quickSelect([8, 3, 2, 5, 1, 7, 4, 6], 6) == 6)
assert(quickSelect([8, 3, 2, 5, 1, 7, 4, 6], 7) == 7)
assert(quickSelect([8, 3, 2, 5, 1, 7, 4, 6], 8) == 8)
assert(quickSelect([102, 41, 58, 81, 2, -5, 1000, 10021, 181, -14515, 25, 15], 5) == 25)
assert(quickSelect([102, 41, 58, 81, 2, -5, 1000, 10021, 181, -14515, 25, 15], 4) == 15)
assert(quickSelect([102, 41, 58, 81, 2, -5, 1000, 10021, 181, -14515, 25, 15], 9) == 102)
assert(quickSelect([1, 3, 71, 123, 124, 156, 814, 1294, 10024, 110000, 985181, 55516151125], 12) == 55516151125)
assert(quickSelect([1, 3, 71, 123, 124, 156, 814, 1294, 10024, 110000, 985181, 55516151125], 4) == 123)
