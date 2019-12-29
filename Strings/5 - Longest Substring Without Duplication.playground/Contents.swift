//Longest Substring Without Duplication
//O(n) time | O(min(n, a)) space
func longestSubstringWithoutDuplication(_ string: String) -> String
{
    var startingPointer = 0
    var indicesOfLongestSubstring = [0, 1]
    var indicesDictionary = [Character: Int]()
    
    for (index, character) in string.enumerated()
    {
        if let index = indicesDictionary[character]
        {
            startingPointer = max(startingPointer, index + 1)
        }
        
        if indicesOfLongestSubstring[1] - indicesOfLongestSubstring[0] < index + 1 - startingPointer
        {
            indicesOfLongestSubstring = [startingPointer, index + 1]
        }
        
        indicesDictionary[character] = index
    }
    
    let start = indicesOfLongestSubstring[0]
    let startingIndex = string.index(string.startIndex, offsetBy: start)
    
    let end = indicesOfLongestSubstring[1]
    let endingIndex = string.index(string.startIndex, offsetBy: end)
    
    return String(string[startingIndex ..< endingIndex])
}

assert(longestSubstringWithoutDuplication("a") == "a")
assert(longestSubstringWithoutDuplication("abc") == "abc")
assert(longestSubstringWithoutDuplication("abcb") == "abc")
assert(longestSubstringWithoutDuplication("abcdeabcdefc") == "abcdef")
assert(longestSubstringWithoutDuplication("abccdeaabbcddef") == "cdea")
assert(longestSubstringWithoutDuplication("abacacacaaabacaaaeaaafa") == "bac")
assert(longestSubstringWithoutDuplication("abcdabcef") == "dabcef")
assert(longestSubstringWithoutDuplication("abcbde") == "cbde")
assert(longestSubstringWithoutDuplication("clementisacap") == "mentisac")
assert(longestSubstringWithoutDuplication("clementisanarm") == "mentisa")
