//Palindrome Partitioning Min Cuts
//Solution #1
//O(n^3) time | O(n^2) space
func palindromePartitioingMinCutsFirstSolution(_ string: String) -> Int
{
    var palindromes = string.map { _ in return Array(repeating: false, count: string.count) }
    
    for i in 0 ..< string.count
    {
        for j in i ..< string.count
        {
            let leftIndex = string.index(string.startIndex, offsetBy: i)
            let rightIndex = string.index(string.startIndex, offsetBy: j)
            let subString = String(string[leftIndex ... rightIndex])
            
            palindromes[i][j] = isPalindrome(subString)
        }
    }
    
    var cuts = Array(repeating: Int.max, count: string.count)
    
    for i in 0 ..< string.count
    {
        if palindromes[0][i]
        {
            cuts[i] = 0
        }
        else
        {
            cuts[i] = cuts[i - 1] + 1
            
            for j in 1 ..< i
            {
                if palindromes[j][i] && cuts[j - 1] + 1 < cuts[i]
                {
                    cuts[i] = cuts[j - 1] + 1
                }
            }
        }
    }
    
    return cuts[string.count - 1]
}

func isPalindrome(_ string: String) -> Bool
{
    var leftIndex = 0
    var rightIndex = string.count - 1
    
    while leftIndex < rightIndex
    {
        let leftStringIndex = string.index(string.startIndex, offsetBy: leftIndex)
        let rightStringIndex = string.index(string.startIndex, offsetBy: rightIndex)
        
        if string[leftStringIndex] != string[rightStringIndex]
        {
            return false
        }
        
        leftIndex += 1
        rightIndex -= 1
    }
    
    return true
}

//Solution #1
//O(n^3) time | O(n^2) space
func palindromePartitioingMinCutsSecondSolution(_ string: String) -> Int
{
    var palindromes = string.map { _ in return Array(repeating: false, count: string.count) }
    
    for i in 0 ..< string.count
    {
        palindromes[i][i] = true
    }
    
    for length in stride(from: 2, through: string.count, by: 1)
    {
        for i in stride(from: 0, through: string.count - length, by: 1)
        {
            let j = i + length - 1
            
            let iStringIndex = string.index(string.startIndex, offsetBy: i)
            let jStringIndex = string.index(string.startIndex, offsetBy: j)
            
            if length == 2 && string[iStringIndex] == string [jStringIndex]
            {
                palindromes[i][j] = true
            }
            else if palindromes[i + 1][j - 1] && string[iStringIndex] == string [jStringIndex]
            {
                palindromes[i][j] = true
            }
        }
    }
    
    var cuts = Array(repeating: Int.max, count: string.count)
    
    for i in 0 ..< string.count
    {
        if palindromes[0][i]
        {
            cuts[i] = 0
        }
        else
        {
            cuts[i] = cuts[i - 1] + 1
            
            for j in 1 ..< i
            {
                if palindromes[j][i] && cuts[j - 1] + 1 < cuts[i]
                {
                    cuts[i] = cuts[j - 1] + 1
                }
            }
        }
    }
    
    return cuts[string.count - 1]
}

assert(palindromePartitioingMinCutsFirstSolution("a") == 0)
assert(palindromePartitioingMinCutsFirstSolution("abba") == 0)
assert(palindromePartitioingMinCutsFirstSolution("abbba") == 0)
assert(palindromePartitioingMinCutsFirstSolution("abb") == 1)
assert(palindromePartitioingMinCutsFirstSolution("abbb") == 1)
assert(palindromePartitioingMinCutsFirstSolution("noonabbad") == 2)
assert(palindromePartitioingMinCutsFirstSolution("abcbm") == 2)
assert(palindromePartitioingMinCutsFirstSolution("ababbbabbababa") == 3)
assert(palindromePartitioingMinCutsFirstSolution("abbbacecffgbgffab") == 4)
assert(palindromePartitioingMinCutsFirstSolution("abcdefghijklmonpqrstuvwxyz") == 25)
assert(palindromePartitioingMinCutsFirstSolution("abcdefghijklmracecaronpqrstuvwxyz") == 26)

assert(palindromePartitioingMinCutsSecondSolution("a") == 0)
assert(palindromePartitioingMinCutsSecondSolution("abba") == 0)
assert(palindromePartitioingMinCutsSecondSolution("abbba") == 0)
assert(palindromePartitioingMinCutsSecondSolution("abb") == 1)
assert(palindromePartitioingMinCutsSecondSolution("abbb") == 1)
assert(palindromePartitioingMinCutsSecondSolution("noonabbad") == 2)
assert(palindromePartitioingMinCutsSecondSolution("abcbm") == 2)
assert(palindromePartitioingMinCutsSecondSolution("ababbbabbababa") == 3)
assert(palindromePartitioingMinCutsSecondSolution("abbbacecffgbgffab") == 4)
assert(palindromePartitioingMinCutsSecondSolution("abcdefghijklmonpqrstuvwxyz") == 25)
assert(palindromePartitioingMinCutsSecondSolution("abcdefghijklmracecaronpqrstuvwxyz") == 26)
