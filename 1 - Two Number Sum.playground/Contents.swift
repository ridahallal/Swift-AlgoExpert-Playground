//Two Number Sum

//Solution #1
//O(n^2) time | O(1) space
func twoNumberSumFirstSolution(array: [Int], targetSum: Int) -> [Int]?
{
    for i in 0..<array.count
    {
        let firstNumber = array[i]
        
        for j in 1..<array.count
        {
            let secondNumber = array[j]
            
            if firstNumber + secondNumber == targetSum
            {
                return [firstNumber, secondNumber].sorted()
            }
        }
    }
    
    return nil
}

//Solution #2
//O(n) time | O(n) space
func twoNumberSumSecondSolution(array: [Int], targetSum: Int) -> [Int]?
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
            numbersHashMap[potentialMatch] = true
        }
    }
    
    return nil
}

//Solution #3
//O(nlog(n)) time | O(1) space
func twoNumberSumThirdSolution(array: inout [Int], targetSum: Int) -> [Int]?
{
    array.sort()
    
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
    
    return nil
}
