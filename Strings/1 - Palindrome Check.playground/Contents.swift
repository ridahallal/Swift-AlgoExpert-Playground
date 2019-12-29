//Palindrome Check
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

//Solution #3 with tail recursion
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

//Tests
//Solution #1
assert(isPalindromeFirstSolution(string: "a") == true)
assert(isPalindromeFirstSolution(string: "ab") == false)
assert(isPalindromeFirstSolution(string: "aba") == true)
assert(isPalindromeFirstSolution(string: "abb") == false)
assert(isPalindromeFirstSolution(string: "abba") == true)
assert(isPalindromeFirstSolution(string: "abcdcba") == true)
assert(isPalindromeFirstSolution(string: "abcdefghhgfedcba") == true)
assert(isPalindromeFirstSolution(string: "abcdefghihgfedcba") == true)
assert(isPalindromeFirstSolution(string: "abcdefghihgfeddcba") == false)

//Solution #2
assert(isPalindromeSecondSolution(string: "a") == true)
assert(isPalindromeSecondSolution(string: "ab") == false)
assert(isPalindromeSecondSolution(string: "aba") == true)
assert(isPalindromeSecondSolution(string: "abb") == false)
assert(isPalindromeSecondSolution(string: "abba") == true)
assert(isPalindromeSecondSolution(string: "abcdcba") == true)
assert(isPalindromeSecondSolution(string: "abcdefghhgfedcba") == true)
assert(isPalindromeSecondSolution(string: "abcdefghihgfedcba") == true)
assert(isPalindromeSecondSolution(string: "abcdefghihgfeddcba") == false)

//Solution #3
assert(isPalindromeThirdSolution(string: "a", firstIndex: 0) == true)
assert(isPalindromeThirdSolution(string: "ab", firstIndex: 0) == false)
assert(isPalindromeThirdSolution(string: "aba", firstIndex: 0) == true)
assert(isPalindromeThirdSolution(string: "abb", firstIndex: 0) == false)
assert(isPalindromeThirdSolution(string: "abba", firstIndex: 0) == true)
assert(isPalindromeThirdSolution(string: "abcdcba", firstIndex: 0) == true)
assert(isPalindromeThirdSolution(string: "abcdefghhgfedcba", firstIndex: 0) == true)
assert(isPalindromeThirdSolution(string: "abcdefghihgfedcba", firstIndex: 0) == true)
assert(isPalindromeThirdSolution(string: "abcdefghihgfeddcba", firstIndex: 0) == false)

//Solution #3 with tail recursion
assert(isPalindromeThirdSolutionWithTailRecursion(string: "a", firstIndex: 0) == true)
assert(isPalindromeThirdSolutionWithTailRecursion(string: "ab", firstIndex: 0) == false)
assert(isPalindromeThirdSolutionWithTailRecursion(string: "aba", firstIndex: 0) == true)
assert(isPalindromeThirdSolutionWithTailRecursion(string: "abb", firstIndex: 0) == false)
assert(isPalindromeThirdSolutionWithTailRecursion(string: "abba", firstIndex: 0) == true)
assert(isPalindromeThirdSolutionWithTailRecursion(string: "abcdcba", firstIndex: 0) == true)
assert(isPalindromeThirdSolutionWithTailRecursion(string: "abcdefghhgfedcba", firstIndex: 0) == true)
assert(isPalindromeThirdSolutionWithTailRecursion(string: "abcdefghihgfedcba", firstIndex: 0) == true)
assert(isPalindromeThirdSolutionWithTailRecursion(string: "abcdefghihgfeddcba", firstIndex: 0) == false)

//Solution #4
assert(isPalindromeFourthSolution(string: "a") == true)
assert(isPalindromeFourthSolution(string: "ab") == false)
assert(isPalindromeFourthSolution(string: "aba") == true)
assert(isPalindromeFourthSolution(string: "abb") == false)
assert(isPalindromeFourthSolution(string: "abba") == true)
assert(isPalindromeFourthSolution(string: "abcdcba") == true)
assert(isPalindromeFourthSolution(string: "abcdefghhgfedcba") == true)
assert(isPalindromeFourthSolution(string: "abcdefghihgfedcba") == true)
assert(isPalindromeFourthSolution(string: "abcdefghihgfeddcba") == false)
