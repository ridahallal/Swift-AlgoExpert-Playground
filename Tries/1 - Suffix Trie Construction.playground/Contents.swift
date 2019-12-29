//Suffix Trie Construction
class TrieNode
{
    var children: [String: Any] = [:]
}

class SuffixTrie
{
    var root = TrieNode()
    let endSymbol = "*"
    
    init(string: String)
    {
        populateSuffixTrieFrom(string: string)
    }
    
    //O(n^2) time | O(n^2) space
    func populateSuffixTrieFrom(string: String)
    {
        for i in 0 ..< string.count
        {
            insertSubstringStartingAt(index: i, string: string, root: root)
        }
    }
    
    func insertSubstringStartingAt(index: Int, string: String, root: TrieNode)
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
        
        node.children[endSymbol] = true
    }
    
    //O(m) time | O(1) space
    func contains(string: String) -> Bool
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
        
        let reachedTheEnd = node.children[endSymbol] as! Bool
        return reachedTheEnd
    }
}

//Tests
func testTrie(word: String, trie: SuffixTrie) -> Bool
{
    for i in (0 ... word.count - 1).reversed()
    {
        let index = word.index(word.startIndex, offsetBy: i)
        let substring = String(word.suffix(from: index))
        
        if !trie.contains(string: substring)
        {
            return false
        }
    }
    
    return true
}

let firstWord = "test"
let firstTest = SuffixTrie(string: firstWord)
testTrie(word: firstWord, trie: firstTest)

let secondWord = "invisible"
let secondTest = SuffixTrie(string: secondWord)
testTrie(word: secondWord, trie: secondTest)

let thirdWord = "1234556789"
let thirdTest = SuffixTrie(string: thirdWord)
testTrie(word: thirdWord, trie: thirdTest)

let fourthWord = "testtest"
let fourthTest = SuffixTrie(string: fourthWord)
testTrie(word: fourthWord, trie: fourthTest)

let fifthWord = "ttttttttt"
let fifthTest = SuffixTrie(string: fifthWord)
testTrie(word: fifthWord, trie: fifthTest)

let sixthWord = "babc"
let sixthTest = SuffixTrie(string: sixthWord)
testTrie(word: sixthWord, trie: sixthTest)
