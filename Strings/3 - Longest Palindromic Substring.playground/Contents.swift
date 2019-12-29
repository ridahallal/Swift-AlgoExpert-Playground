//Longest Palindromic Substring
//Solution #1
func longestPalindromicSubstringFirstSolution(string: String) -> String
{
    var longest = ""
    
    for i in 0 ..< string.count
    {
        for j in i ..< string.count
        {
            let leftIndex = string.index(string.startIndex, offsetBy: i)
            let rightIndex = string.index(string.startIndex, offsetBy: j + 1)
            let substring = String(string[leftIndex ..< rightIndex])
            
            if substring.count > longest.count && isPalindrome(string: substring)
            {
                longest = substring
            }
        }
    }
    
    return longest
}

//O(n) time | O(1) space
func isPalindrome(string: String) -> Bool
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

func longestPalindromicSubstringSecondSolution(string: String) -> String
{
    var currentLongest = [0, 1]
    
    for i in 0 ..< string.count
    {
        var oddLeftIndex = i - 1
        var oddRightIndex = i + 1
        let odd = getLongestPalindromeFrom(string: string, leftIndex: &oddLeftIndex, rightIndex: &oddRightIndex)
        
        var evenLeftIndex = i - 1
        var evenRightIndex = i
        let even = getLongestPalindromeFrom(string: string, leftIndex: &evenLeftIndex, rightIndex: &evenRightIndex)
        
        var temporaryLongest = [Int]()
        
        if let oddFirst = odd.first, let oddLast = odd.last, let evenFirst = even.first, let evenLast = even.last
        {
            if oddLast - oddFirst > evenLast - evenFirst
            {
                temporaryLongest = odd
            }
            else
            {
                temporaryLongest = even
            }
        }
        
        if let temporaryFirst = temporaryLongest.first, let temporaryLast = temporaryLongest.last, let currentFirst = currentLongest.first, let currentLast = currentLongest.last
        {
            if temporaryLast - temporaryFirst > currentLast - currentFirst
            {
                currentLongest = temporaryLongest
            }
        }
    }
    
    let firstIndex = string.index(string.startIndex, offsetBy: currentLongest.first!)
    let lastIndex = string.index(string.startIndex, offsetBy: currentLongest.last!)
    let result = String(string[firstIndex ..< lastIndex])
    
    return result
}

func getLongestPalindromeFrom(string: String, leftIndex: inout Int, rightIndex: inout Int) -> [Int]
{
    while leftIndex >= 0 && rightIndex < string.count
    {
        let leftStringIndex = string.index(string.startIndex, offsetBy: leftIndex)
        let rightStringIndex = string.index(string.startIndex, offsetBy: rightIndex)
        
        if string[leftStringIndex] != string[rightStringIndex]
        {
            break
        }
        
        leftIndex -= 1
        rightIndex += 1
    }
    
    return [leftIndex + 1, rightIndex]
}

//Tests
assert(longestPalindromicSubstringFirstSolution(string: "a") == "a")
assert(longestPalindromicSubstringFirstSolution(string: "it's highnoon") == "noon")
assert(longestPalindromicSubstringFirstSolution(string: "noon high it is") == "noon")
assert(longestPalindromicSubstringFirstSolution(string: "abccbait's highnoon") == "abccba")
assert(longestPalindromicSubstringFirstSolution(string: "abaxyzzyxf") == "xyzzyx")
assert(longestPalindromicSubstringFirstSolution(string: "abcdefgfedcbazzzzzzzzzzzzzzzzzzzz") == "zzzzzzzzzzzzzzzzzzzz")
assert(longestPalindromicSubstringFirstSolution(string: "abcdefgfedcba") == "abcdefgfedcba")
assert(longestPalindromicSubstringFirstSolution(string: "abcdefghfedcbaa") == "aa")
assert(longestPalindromicSubstringFirstSolution(string: "abcdefggfedcba") == "abcdefggfedcba")
assert(longestPalindromicSubstringFirstSolution(string: "zzzzzzz2345abbbba5432zzbbababa") == "zz2345abbbba5432zz")
assert(longestPalindromicSubstringFirstSolution(string: "z234a5abbbba54a32z") == "5abbbba5")
assert(longestPalindromicSubstringFirstSolution(string: "z234a5abbba54a32z") == "5abbba5")

assert(longestPalindromicSubstringSecondSolution(string: "a") == "a")
assert(longestPalindromicSubstringSecondSolution(string: "it's highnoon") == "noon")
assert(longestPalindromicSubstringSecondSolution(string: "noon high it is") == "noon")
assert(longestPalindromicSubstringSecondSolution(string: "abccbait's highnoon") == "abccba")
assert(longestPalindromicSubstringSecondSolution(string: "abaxyzzyxf") == "xyzzyx")
assert(longestPalindromicSubstringSecondSolution(string: "abcdefgfedcbazzzzzzzzzzzzzzzzzzzz") == "zzzzzzzzzzzzzzzzzzzz")
assert(longestPalindromicSubstringSecondSolution(string: "abcdefgfedcba") == "abcdefgfedcba")
assert(longestPalindromicSubstringSecondSolution(string: "abcdefghfedcbaa") == "aa")
assert(longestPalindromicSubstringSecondSolution(string: "abcdefggfedcba") == "abcdefggfedcba")
assert(longestPalindromicSubstringSecondSolution(string: "zzzzzzz2345abbbba5432zzbbababa") == "zz2345abbbba5432zz")
assert(longestPalindromicSubstringSecondSolution(string: "z234a5abbbba54a32z") == "5abbbba5")
assert(longestPalindromicSubstringSecondSolution(string: "z234a5abbba54a32z") == "5abbba5")
