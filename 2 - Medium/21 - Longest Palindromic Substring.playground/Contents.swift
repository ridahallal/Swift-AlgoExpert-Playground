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

func longestPalindromicSubstringSecondSolution() -> String
{
    var longest = ""
    
    return longest
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
