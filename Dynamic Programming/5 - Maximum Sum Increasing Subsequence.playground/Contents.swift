//Maximum Sum Increasing Subsequence
//O(n^2) time | O(n) space
func maximumSumIncreasingSubsequence(array: [Int]) -> (Int, [Int])
{
    //Index of the maximum sum thus far
    var maxSumIndex = 0
    
    //Array that will store our maximum sums at each index
    var sums = array.map { $0 }
    
    //Array that will store out previous sequence indices at each index (initial values are nil)
    var previousIndices: [Int?] = Array(repeating: nil, count: array.count)
    
    //Loop around the numbers inside our array
    for i in 0 ..< array.count
    {
        //Get the current number
        let currentNumber = array[i]
        
        //Loop from the beginning of the array up to the current number
        for j in 0 ..< i
        {
            //Get the previous number
            let previousNumber = array[j]
            
            //If the previous number is less than the current number
            //and the sum at the previous index + current number is
            //greater than the sum at out current number's index
            if previousNumber < currentNumber && sums[j] + currentNumber > sums[i]
            {
                //Set the sum at our current index to be the sum
                //at the previous number's index plus our current number
                sums[i] = sums[j] + currentNumber
                
                //Update our previous indices array
                previousIndices[i] = j
            }
        }
        
        //Update our maxSumIndex variable
        if sums[i] > sums[maxSumIndex]
        {
            maxSumIndex = i
        }
    }
    
    return (sums[maxSumIndex], buildSequence(array, maxSumIndex, previousIndices))
}

func buildSequence(_ array: [Int], _ maxSumIndex: Int, _ previousIndices: [Int?]) -> [Int]
{
    var sequence = [Int]()
    var currentIndex: Int? = maxSumIndex
    
    while currentIndex != nil
    {
        sequence.insert(array[currentIndex!], at: 0)
        currentIndex = previousIndices[currentIndex!]
    }
    
    return sequence
}

//Tests
assert(maximumSumIncreasingSubsequence(array: [1]) == (1, [1]))
assert(maximumSumIncreasingSubsequence(array: [-1]) == (-1, [-1]))
assert(maximumSumIncreasingSubsequence(array: [-1, 1]) == (1, [1]))
assert(maximumSumIncreasingSubsequence(array: [5, 4, 3, 2, 1]) == (5, [5]))
assert(maximumSumIncreasingSubsequence(array: [1, 2, 3, 4, 5]) == (15, [1, 2, 3, 4, 5]))
assert(maximumSumIncreasingSubsequence(array: [-5, -4, -3, -2, -1]) == (-1, [-1]))
assert(maximumSumIncreasingSubsequence(array: [10, 70, 20, 30, 50, 11, 30]) == (110, [10, 20, 30, 50]))
assert(maximumSumIncreasingSubsequence(array: [8, 12, 2, 3, 15, 5, 7]) == (35, [8, 12, 15]))
assert(maximumSumIncreasingSubsequence(array: [10, 15, 4, 5, 11, 14, 31, 25, 31, 23, 25, 31, 50]) == (164, [10, 11, 14, 23, 25, 31, 50]))
