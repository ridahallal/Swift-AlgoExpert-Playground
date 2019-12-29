//Multi String Search
//Solution #1
//O(bns) time | O(n) space
func multiStringSearchFirstSolution(_ bigString: String, _ smallStrings: [String]) -> [Bool]
{
    return smallStrings.map { isInBigString($0, bigString) }
}

func isInBigString(_ smallString: String, _ bigString: String) -> Bool
{
    for i in 0 ..< bigString.count
    {
        if i + smallString.count > bigString.count
        {
            break
        }
        
        if isInBigStringHelper(i, smallString, bigString)
        {
            return true
        }
    }
    
    return false
}

func isInBigStringHelper(_ startIndex: Int, _ smallString: String, _ bigString: String) -> Bool
{
    var leftSmallIndex = 0
    var rightSmallIndex = smallString.count - 1
    
    var leftBigIndex = startIndex
    var rightBigIndex = startIndex + smallString.count - 1
    
    while leftBigIndex < rightBigIndex
    {
        let leftSmallStringIndex = smallString.index(smallString.startIndex, offsetBy: leftSmallIndex)
        let rightSmallStringIndex = smallString.index(smallString.startIndex, offsetBy: rightSmallIndex)
        
        let leftBigStringIndex = bigString.index(bigString.startIndex, offsetBy: leftBigIndex)
        let rightBigStringIndex = bigString.index(bigString.startIndex, offsetBy: rightBigIndex)
        
        if smallString[leftSmallStringIndex] != bigString[leftBigStringIndex] || smallString[rightSmallStringIndex] != bigString[rightBigStringIndex]
        {
            return false
        }
        
        leftSmallIndex += 1
        rightSmallIndex -= 1
        leftBigIndex += 1
        rightBigIndex -= 1
    }
    
    return true
}

//Solution #2
//O(b ^ 2 + ns) time | O(b ^ 2 + n) space
func multiStringSearchSecondSolution(_ bigString: String, _ smallStrings: [String]) -> [Bool]
{
    let modifiedSuffixTrie = ModifiedSuffixTrie(string: bigString)
    
    return smallStrings.map { modifiedSuffixTrie.contains($0) }
}

class TrieNode
{
    var children: [String: Any] = [:]
}

class ModifiedSuffixTrie
{
    var root = TrieNode()
    
    init(string: String)
    {
        populateModifiedSuffixTrieFrom(string)
    }
    
    func populateModifiedSuffixTrieFrom(_ string: String)
    {
        for i in 0 ..< string.count
        {
            insertSubstringStartingAt(i, string, root)
        }
    }
    
    func insertSubstringStartingAt(_ index: Int, _ string: String, _ root: TrieNode)
    {
        var node = root
        
        for j in index ..< string.count
        {
            let jStringIndex = string.index(string.startIndex, offsetBy: j)
            let jthCharacter = String(string[jStringIndex])
            
            if !node.children.keys.contains(jthCharacter)
            {
                node.children[jthCharacter] = TrieNode()
            }
            
            let nextNode = node.children[jthCharacter] as! TrieNode
            node = nextNode
        }
    }
    
    func contains(_ string: String) -> Bool
    {
        var node = root
        
        for character in string
        {
            let stringifiedCharacter = String(character)
            
            if !node.children.keys.contains(stringifiedCharacter)
            {
                return false
            }
            
            let nextNode = node.children[stringifiedCharacter] as! TrieNode
            node = nextNode
        }
        
        return true
    }
}

//Solution #3
//O(ns + bs) time | O(ns) space
func multiStringSearchThirdSolution(_ bigString: String, _ smallStrings: [String]) -> [Bool]
{
    let trie = Trie()
    
    for string in smallStrings
    {
        trie.insert(string)
    }
    
    var containedStrings = [String: Bool]()
    
    for i in 0 ..< bigString.count
    {
        findSmallStringInBigString(bigString, i, trie, &containedStrings)
    }
    
    return smallStrings.map { containedStrings.keys.contains($0) }
}

func findSmallStringInBigString(_ string: String, _ startIndex: Int, _ trie: Trie, _ containedStrings: inout [String: Bool])
{
    var currentNode = trie.root
    
    for i in startIndex ..< string.count
    {
        let currentStringIndex = string.index(string.startIndex, offsetBy: i)
        let currentCharacter = String(string[currentStringIndex])
        
        if !currentNode.children.keys.contains(currentCharacter)
        {
            break
        }
        
        let nextNode = currentNode.children[currentCharacter] as! TrieNode
        currentNode = nextNode
        
        if currentNode.children.keys.contains(trie.endSymbol)
        {
            let resultString = currentNode.children[trie.endSymbol] as! String
            containedStrings[resultString] = true
        }
    }
}

class Trie
{
    var root = TrieNode()
    let endSymbol = "*"
    
    func insert(_ string: String)
    {
        var node = root
        
        for i in 0 ..< string.count
        {
            let iStringIndex = string.index(string.startIndex, offsetBy: i)
            let ithCharacter = String(string[iStringIndex])
            
            if !node.children.keys.contains(ithCharacter)
            {
                node.children[ithCharacter] = TrieNode()
            }
            
            let nextNode = node.children[ithCharacter] as! TrieNode
            node = nextNode
        }
        
        node.children[endSymbol] = string
    }
}

//Tests
//Solution #1
assert(multiStringSearchFirstSolution("this is a big string", ["this", "yo", "is", "a", "bigger", "string", "kappa"]) == [true, false, true, true, false, true, false])

assert(multiStringSearchFirstSolution("Mary goes to the shopping center every week.", ["to", "Mary", "centers", "shop", "shopping", "string", "kappa"]) == [true, true, false, true, true, false, false])

assert(multiStringSearchFirstSolution("adcb akfkw afnmc fkadn vkaca jdaf dacb cdba cbda", ["abcd", "acbd", "adbc", "dabc", "cbda", "cabd", "cdab"]) == [false, false, false, false, true, false, false])

assert(multiStringSearchFirstSolution("test testing testings tests testers test-takers", ["tests", "testatk", "testiing", "trsatii", "test-taker", "test"]) == [true, false, false, false, true, true])

assert(multiStringSearchFirstSolution("ndbajwhfawkjljkfaopwdlaawjk dawkj awjkawkfjhkawk ahjwkjad jadfljawd", ["abc", "akwbc", "awbc", "abafac", "ajjfbc", "abac", "jadfl"]) == [false, false, false, false, false, false, true])

assert(multiStringSearchFirstSolution("Is this particular test going to pass or is it going to fail? That is the question.", ["that", "the", "questions", "goes", "mountain", "passes", "passed", "going", "is"]) == [false, true, false, false, false, false, false, true, true])

assert(multiStringSearchFirstSolution("Everything in this test should fail.", ["everything", "inn", "that", "testers", "shall", "failure"]) == [false, false, false, false, false, false])

//Solution #2
assert(multiStringSearchSecondSolution("this is a big string", ["this", "yo", "is", "a", "bigger", "string", "kappa"]) == [true, false, true, true, false, true, false])

assert(multiStringSearchSecondSolution("Mary goes to the shopping center every week.", ["to", "Mary", "centers", "shop", "shopping", "string", "kappa"]) == [true, true, false, true, true, false, false])

assert(multiStringSearchSecondSolution("adcb akfkw afnmc fkadn vkaca jdaf dacb cdba cbda", ["abcd", "acbd", "adbc", "dabc", "cbda", "cabd", "cdab"]) == [false, false, false, false, true, false, false])

assert(multiStringSearchSecondSolution("test testing testings tests testers test-takers", ["tests", "testatk", "testiing", "trsatii", "test-taker", "test"]) == [true, false, false, false, true, true])

assert(multiStringSearchSecondSolution("ndbajwhfawkjljkfaopwdlaawjk dawkj awjkawkfjhkawk ahjwkjad jadfljawd", ["abc", "akwbc", "awbc", "abafac", "ajjfbc", "abac", "jadfl"]) == [false, false, false, false, false, false, true])

assert(multiStringSearchSecondSolution("Is this particular test going to pass or is it going to fail? That is the question.", ["that", "the", "questions", "goes", "mountain", "passes", "passed", "going", "is"]) == [false, true, false, false, false, false, false, true, true])

assert(multiStringSearchSecondSolution("Everything in this test should fail.", ["everything", "inn", "that", "testers", "shall", "failure"]) == [false, false, false, false, false, false])

//Solution #3
assert(multiStringSearchThirdSolution("this is a big string", ["this", "yo", "is", "a", "bigger", "string", "kappa"]) == [true, false, true, true, false, true, false])

assert(multiStringSearchThirdSolution("Mary goes to the shopping center every week.", ["to", "Mary", "centers", "shop", "shopping", "string", "kappa"]) == [true, true, false, true, true, false, false])

assert(multiStringSearchThirdSolution("adcb akfkw afnmc fkadn vkaca jdaf dacb cdba cbda", ["abcd", "acbd", "adbc", "dabc", "cbda", "cabd", "cdab"]) == [false, false, false, false, true, false, false])

assert(multiStringSearchThirdSolution("test testing testings tests testers test-takers", ["tests", "testatk", "testiing", "trsatii", "test-taker", "test"]) == [true, false, false, false, true, true])

assert(multiStringSearchThirdSolution("ndbajwhfawkjljkfaopwdlaawjk dawkj awjkawkfjhkawk ahjwkjad jadfljawd", ["abc", "akwbc", "awbc", "abafac", "ajjfbc", "abac", "jadfl"]) == [false, false, false, false, false, false, true])

assert(multiStringSearchThirdSolution("Is this particular test going to pass or is it going to fail? That is the question.", ["that", "the", "questions", "goes", "mountain", "passes", "passed", "going", "is"]) == [false, true, false, false, false, false, false, true, true])

assert(multiStringSearchThirdSolution("Everything in this test should fail.", ["everything", "inn", "that", "testers", "shall", "failure"]) == [false, false, false, false, false, false])
