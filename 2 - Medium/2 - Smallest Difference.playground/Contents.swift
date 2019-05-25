//Smallest Difference
func smallestDifference(arrayOne: inout [Int], arrayTwo: inout [Int]) -> [Int]
{
    arrayOne.sort()
    arrayTwo.sort()
    
    var idxOne = 0
    var idxTwo = 0
    
    var current = Int.max
    var smallest = Int.max
    
    var smallestPair: [Int] = []
    
    while idxOne < arrayOne.count && idxTwo < arrayTwo.count
    {
        let firstNum = arrayOne[idxOne]
        let secondNum = arrayTwo[idxTwo]
        
        if firstNum < secondNum
        {
            current = secondNum - firstNum
            idxOne = idxOne + 1
        }
        else if firstNum > secondNum
        {
            current = firstNum - secondNum
            idxTwo = idxTwo + 1
        }
        else
        {
            return [firstNum, secondNum]
        }
        
        if smallest > current
        {
            smallest = current
            smallestPair = [firstNum, secondNum]
        }
    }
    
    return smallestPair
}

//Tests
var firstArray = [-1, 5, 10, 20, 3]
var secondArray = [26, 134, 135, 15, 17]
var difference = smallestDifference(arrayOne: &firstArray, arrayTwo: &secondArray)
assert(difference == [20, 17])

firstArray = [-1, 5, 10, 20, 28, 3]
secondArray = [26, 134, 135, 15, 17]
difference = smallestDifference(arrayOne: &firstArray, arrayTwo: &secondArray)
assert(difference == [28, 26])

firstArray = [10, 0, 20, 25]
secondArray = [1005, 1006, 1014, 1032, 1031]
difference = smallestDifference(arrayOne: &firstArray, arrayTwo: &secondArray)
assert(difference == [25, 1005])

firstArray = [10, 0, 20, 25, 2200]
secondArray = [1005, 1006, 1014, 1032, 1031]
difference = smallestDifference(arrayOne: &firstArray, arrayTwo: &secondArray)
assert(difference == [25, 1005])

firstArray = [10, 0, 20, 25, 2000]
secondArray = [1005, 1006, 1014, 1032, 1031]
difference = smallestDifference(arrayOne: &firstArray, arrayTwo: &secondArray)
assert(difference == [2000, 1032])

firstArray = [240, 124, 86, 111, 2, 84, 954, 27, 89]
secondArray = [1, 3, 954, 19, 8]
difference = smallestDifference(arrayOne: &firstArray, arrayTwo: &secondArray)
assert(difference == [954, 954])

firstArray = [0, 20]
secondArray = [21, -2]
difference = smallestDifference(arrayOne: &firstArray, arrayTwo: &secondArray)
assert(difference == [20, 21])

firstArray = [10, 1000]
secondArray = [-1441, -124, -25, 1014, 1500, 660, 410, 245, 530]
difference = smallestDifference(arrayOne: &firstArray, arrayTwo: &secondArray)
assert(difference == [1000, 1014])

firstArray = [10, 1000, 9124, 2142, 59, 24, 596, 591, 124, -123]
secondArray = [-1441, -124, -25, 1014, 1500, 660, 410, 245, 530]
difference = smallestDifference(arrayOne: &firstArray, arrayTwo: &secondArray)
assert(difference == [-123, -124])

firstArray = [10, 1000, 9124, 2142, 59, 24, 596, 591, 124, -123, 530]
secondArray = [-1441, -124, -25, 1014, 1500, 660, 410, 245, 530]
difference = smallestDifference(arrayOne: &firstArray, arrayTwo: &secondArray)
assert(difference == [530, 530])
