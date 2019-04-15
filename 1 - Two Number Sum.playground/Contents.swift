//Two Number Sum

//Solution #1
//O(n^2) time | O(1) space
func twoNumberSumFirstSolution(array: [Int], targetSum: Int) -> [Int]
{
    for i in 0..<array.count - 1
    {
        let firstNumber = array[i]
        
        for j in i + 1..<array.count
        {
            let secondNumber = array[j]

            if firstNumber + secondNumber == targetSum
            {
                return [firstNumber, secondNumber].sorted()
            }
        }
    }

    return []
}

assert(twoNumberSumFirstSolution(array: [4, 6], targetSum: 10) == [4, 6])
assert(twoNumberSumFirstSolution(array: [4, 6, 1], targetSum: 5) == [1, 4])
assert(twoNumberSumFirstSolution(array: [4, 6, 1, -3], targetSum: 3) == [-3, 6])
assert(twoNumberSumFirstSolution(array: [3, 5, -4, 8, 11, 1, -1, 6], targetSum: 10) == [-1, 11])
assert(twoNumberSumFirstSolution(array: [1, 2, 3, 4, 5, 6, 7, 8, 9], targetSum: 17) == [8, 9])
assert(twoNumberSumFirstSolution(array: [1, 2, 3, 4, 5, 6, 7, 8, 9, 15], targetSum: 18) == [3, 15])
assert(twoNumberSumFirstSolution(array: [-7, -5, -3, -1, 0, 1, 3, 5, 7], targetSum: -5) == [-5, 0])
assert(twoNumberSumFirstSolution(array: [-21, 301, 12, 4, 65, 56, 210, 356, 9, -47], targetSum: 163) == [-47, 210])
assert(twoNumberSumFirstSolution(array: [-21, 301, 12, 4, 65, 56, 210, 356, 9, -47], targetSum: 164) == [])
assert(twoNumberSumFirstSolution(array: [3, 5, -4, 8, 11, 1, -1, 6], targetSum: 15) == [])

//Solution #2
//O(n) time | O(n) space
func twoNumberSumSecondSolution(array: [Int], targetSum: Int) -> [Int]
{
    var numbersHashMap = [Int: Bool]()
    
    for number in array
    {
        let potentialMatch = targetSum - number
        
        if let exists = numbersHashMap[potentialMatch], exists
        {
            return [potentialMatch, number].sorted()
        }
        else
        {
            numbersHashMap[number] = true
        }
    }
    
    return []
}

assert(twoNumberSumSecondSolution(array: [4, 6], targetSum: 10) == [4, 6])
assert(twoNumberSumSecondSolution(array: [4, 6, 1], targetSum: 5) == [1, 4])
assert(twoNumberSumSecondSolution(array: [4, 6, 1, -3], targetSum: 3) == [-3, 6])
assert(twoNumberSumSecondSolution(array: [3, 5, -4, 8, 11, 1, -1, 6], targetSum: 10) == [-1, 11])
assert(twoNumberSumSecondSolution(array: [1, 2, 3, 4, 5, 6, 7, 8, 9], targetSum: 17) == [8, 9])
assert(twoNumberSumSecondSolution(array: [1, 2, 3, 4, 5, 6, 7, 8, 9, 15], targetSum: 18) == [3, 15])
assert(twoNumberSumSecondSolution(array: [-7, -5, -3, -1, 0, 1, 3, 5, 7], targetSum: -5) == [-5, 0])
assert(twoNumberSumSecondSolution(array: [-21, 301, 12, 4, 65, 56, 210, 356, 9, -47], targetSum: 163) == [-47, 210])
assert(twoNumberSumSecondSolution(array: [-21, 301, 12, 4, 65, 56, 210, 356, 9, -47], targetSum: 164) == [])
assert(twoNumberSumSecondSolution(array: [3, 5, -4, 8, 11, 1, -1, 6], targetSum: 15) == [])

//Solution #3
//O(nlog(n)) time | O(1) space
func twoNumberSumThirdSolution(array: [Int], targetSum: Int) -> [Int]
{
    var array = array.sorted()
    
    var leftPointer = 0
    var rightPointer = array.count - 1
    
    while leftPointer < rightPointer
    {
        let leftMost = array[leftPointer]
        let rightMost = array[rightPointer]
        
        let currentSum = leftMost + rightMost
        
        if currentSum == targetSum
        {
            return [leftMost, rightMost]
        }
        else if currentSum < targetSum
        {
            leftPointer = leftPointer + 1
        }
        else if currentSum > targetSum
        {
            rightPointer = rightPointer - 1
        }
    }
    
    return []
}

assert(twoNumberSumThirdSolution(array: [4, 6], targetSum: 10) == [4, 6])
assert(twoNumberSumThirdSolution(array: [4, 6, 1], targetSum: 5) == [1, 4])
assert(twoNumberSumThirdSolution(array: [4, 6, 1, -3], targetSum: 3) == [-3, 6])
assert(twoNumberSumThirdSolution(array: [3, 5, -4, 8, 11, 1, -1, 6], targetSum: 10) == [-1, 11])
assert(twoNumberSumThirdSolution(array: [1, 2, 3, 4, 5, 6, 7, 8, 9], targetSum: 17) == [8, 9])
assert(twoNumberSumThirdSolution(array: [1, 2, 3, 4, 5, 6, 7, 8, 9, 15], targetSum: 18) == [3, 15])
assert(twoNumberSumThirdSolution(array: [-7, -5, -3, -1, 0, 1, 3, 5, 7], targetSum: -5) == [-5, 0])
assert(twoNumberSumThirdSolution(array: [-21, 301, 12, 4, 65, 56, 210, 356, 9, -47], targetSum: 163) == [-47, 210])
assert(twoNumberSumThirdSolution(array: [-21, 301, 12, 4, 65, 56, 210, 356, 9, -47], targetSum: 164) == [])
assert(twoNumberSumThirdSolution(array: [3, 5, -4, 8, 11, 1, -1, 6], targetSum: 15) == [])
