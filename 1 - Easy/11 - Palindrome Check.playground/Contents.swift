//Palindrom Check
//Solution #1
//O(n^2) time | O(n) space
func isPalindromeFirstSolution(string: String) -> Bool
{
    var reversedString = ""
    
    for i in (0..<string.count).reversed()
    {
        let startIndex = string.index(string.startIndex, offsetBy: i)
        
        let currentChar = string[startIndex]
        reversedString.append(currentChar)
    }
    
    return string == reversedString
}

//Solution #2
//O(n) time | O(n) space
func isPalindromeSecondSolution(string: String) -> Bool
{
    var reversedChars = [Character]()
    
    for i in (0..<string.count).reversed()
    {
        let startIndex = string.index(string.startIndex, offsetBy: i)
        
        let currentChar = string[startIndex]
        reversedChars.append(currentChar)
    }
    
    let reversedString = String(reversedChars)
    
    return string == reversedString
}

//Solution #3
//O(n) time | O(n) space
func isPalindromeThirdSolution(string: String, firstIndex: Int) -> Bool
{
    let lastIndex = string.count - 1 - firstIndex
    
    if firstIndex >= lastIndex
    {
        return true
    }
    
    let startIndex = string.index(string.startIndex, offsetBy: firstIndex)
    let endIndex = string.index(string.startIndex, offsetBy: lastIndex)
    
    let firstAndLastAreEqual = string[startIndex] == string[endIndex]
    let isPalindrome = isPalindromeThirdSolution(string: string, firstIndex: firstIndex + 1)
    
    return firstAndLastAreEqual && isPalindrome
}

//O(n) time | O(1) space
func isPalindromeThirdSolutionWithTailRecursion(string: String, firstIndex: Int) -> Bool
{
    let lastIndex = string.count - 1 - firstIndex
    
    if firstIndex >= lastIndex
    {
        return true
    }
    
    let startIndex = string.index(string.startIndex, offsetBy: firstIndex)
    let endIndex = string.index(string.startIndex, offsetBy: lastIndex)
        
    if string[startIndex] != string[endIndex]
    {
        return false
    }
    
    return isPalindromeThirdSolutionWithTailRecursion(string: string, firstIndex: firstIndex + 1)
}

//Solution #4
//O(n) time | O(1) space
func isPalindromeFourthSolution(string: String) -> Bool
{
    var leftPointer = 0
    var rightPointer = string.count - 1
    var leftIndex = string.index(string.startIndex, offsetBy: leftPointer)
    var rightIndex = string.index(string.startIndex, offsetBy: rightPointer)
    
    while leftIndex < rightIndex
    {
        if string[leftIndex] != string[rightIndex]
        {
            return false
        }
        
        leftPointer = leftPointer + 1
        rightPointer = rightPointer - 1
        leftIndex = string.index(string.startIndex, offsetBy: leftPointer)
        rightIndex = string.index(string.startIndex, offsetBy: rightPointer)
    }
    
    return true
}

isPalindromeFirstSolution(string: "abccba")
isPalindromeSecondSolution(string: "abccba")
isPalindromeThirdSolution(string: "abccba", firstIndex: 0)
isPalindromeThirdSolutionWithTailRecursion(string: "abccba", firstIndex: 0)
isPalindromeFourthSolution(string: "abccba")
