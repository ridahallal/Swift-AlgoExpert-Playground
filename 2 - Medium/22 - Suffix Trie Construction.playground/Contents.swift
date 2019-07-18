//Suffix Trie Construction
class SuffixTrie
{
    var root = [String: Any]()
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
            insertSubstringStartingAt(index: i, string: string, root: &root)
        }
    }
    
    func insertSubstringStartingAt(index: Int, string: String, root: inout [String: Any])
    {
        var node = root
        
        for j in index ..< string.count
        {
            let added = addCharToNode(j: j, index: index, string: string, node: &node)
            
            print(added)
            root = added
        }
    }
    
    func addCharToNode(j: Int, index: Int, string: String, node: inout [String: Any]) -> [String: Any]
    {
        let jStringIndex = string.index(string.startIndex, offsetBy: j)
        let jthCharacter = String(string[jStringIndex])
        
        if !node.keys.contains(jthCharacter)
        {
            node[jthCharacter] = [String: Any]()
        }
        
        return node
    }
    
    //O(m) time | O(1) space
    func contains(string: String) -> Bool
    {
        var node = root
        
        for character in string
        {
            let stringifiedCharacter = String(character)
            
            if !node.keys.contains(stringifiedCharacter)
            {
                return false
            }
            
            let nextNode = root[stringifiedCharacter] as! [String: Any]
            node = nextNode
        }
        
        let reachedTheEnd = node[endSymbol] as! Bool
        return reachedTheEnd
    }
}

//Tests
let firstWord = "test"
let firstTest = SuffixTrie(string: firstWord)
let firstTrie =
    [
        "t":
            [
                "*": true,
                "e":
                    [
                        "s":
                            [
                                "t":
                                    [
                                        "*": true
                                ]
                        ]
                    ],
            ],
        "e":
            [
                "s":
                    [
                        "t":
                            [
                                "*": true
                            ]
                    ]
            ],
        "s":
            [
                "t":
                    [
                        "*": true
                    ]
            ]
    ]

print(firstTest.root)
