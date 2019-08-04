//Boggle Board
//Generic Trie Class
class TrieNode
{
    var children: [String: Any] = [:]
}

class Trie
{
    var root: TrieNode
    let endSymbol: String = "*"
    
    init()
    {
        self.root = TrieNode()
    }
    
    func add(_ word: String)
    {
        var current = root
        
        for character in word
        {
            let stringifiedCharacter = String(character)
            
            if !current.children.keys.contains(stringifiedCharacter)
            {
                current.children[stringifiedCharacter] = TrieNode()
            }
            
            let nextNode = current.children[stringifiedCharacter] as! TrieNode
            current = nextNode
        }
        
        current.children[endSymbol] = word
    }
}

//Gets up to eight neighbors of a node
func getNeighbors(_ i: Int, _ j: Int, board: [[String]]) -> [[Int]]
{
    var neighbors = [[Int]]()
    
    //Upper left
    if i > 0 && j > 0
    {
        neighbors.append([i - 1, j - 1])
    }
    
    //Top
    if i > 0
    {
        neighbors.append([i - 1, j])
    }
    
    //Upper right
    if i > 0 && j < board[i].count - 1
    {
        neighbors.append([i - 1, j + 1])
    }
    
    //Right
    if j < board[i].count - 1
    {
        neighbors.append([i, j + 1])
    }
    
    //Bottom right
    if i < board.count - 1 && j < board[i].count - 1
    {
        neighbors.append([i + 1, j + 1])
    }
    
    //Bottom
    if i < board.count - 1
    {
        neighbors.append([i + 1, j])
    }
    
    //Bottom left
    if i < board.count - 1 && j > 0
    {
        neighbors.append([i + 1, j - 1])
    }
    
    //Left
    if j > 0
    {
        neighbors.append([i, j - 1])
    }
    
    return neighbors
}

//Traverse the board and find out if it contains some of the words
//we pass into this function
func boggleBoard(boggleBoard: [[String]], words: [String]) -> [String]
{
    //Create a trie
    let trie = Trie()
    
    //Add the words to our trie
    for word in words
    {
        trie.add(word)
    }
    
    //Generate a dictionary that'll look like Word -> True
    var finalWords = [String: Bool]()
    
    //Generate an auxiliary matrix that'll tell us whether
    //or not we've visited a node
    var visited = boggleBoard.map { row in row.map { column in return false } }
    
    //For each row
    for i in 0 ..< boggleBoard.count
    {
        //For each column
        for j in 0 ..< boggleBoard[i].count
        {
            //Explore the node at these coordinates
            explore(i, j, boggleBoard, trie.root, &visited, &finalWords)
        }
    }
    
    //Return the keys of our finalWords dictionary
    let keys = Array(finalWords.keys)
    return keys
}

//Explores the neighbors at specific corrdinates recursively
//Upon reaching a terminating symbol of a trieNode, adds the word to finalWords
func explore(_ i: Int, _ j: Int, _ board: [[String]], _ trieNode: TrieNode, _ visited: inout [[Bool]], _ finalWords: inout [String: Bool])
{
    //If we've already visited a node, exit
    if visited[i][j]
    {
        return
    }
    
    //Get the current letter
    let letter = board[i][j]
    
    //See if the trieNode at the current level contains the letter
    //so that we can further traverse the trie
    if !trieNode.children.keys.contains(letter)
    {
        //Otherwise, there will be no matching word, exit
        return
    }
    
    //Set visited to true for the current node
    visited[i][j] = true
    
    //Update the current trieNode
    let nextNode = trieNode.children[letter] as! TrieNode
    
    //Check if we've reached the terminating symbol of the trieNode
    if nextNode.children.keys.contains("*")
    {
        if let word = nextNode.children["*"] as? String
        {
            finalWords[word] = true
        }
    }
    
    //Get the neighbors of the current node
    let neighbors = getNeighbors(i, j, board: board)
    
    //Explore each neighbor
    for neighbor in neighbors
    {
        explore(neighbor[0], neighbor[1], board, nextNode, &visited, &finalWords)
    }
    
    //Set visited for the current node to false
    //Because of the recursive nature of this function
    //we will backtrack to the first node and our visited matrix
    //will get reset after we explore each node in our original matrix
    visited[i][j] = false
}

//Tests
var board = [
    ["y", "g", "f", "y", "e", "i"],
    ["c", "o", "r", "p", "o", "u"],
    ["j", "u", "z", "s", "e", "l"],
    ["s", "y", "u", "r", "h", "p"],
    ["e", "a", "e", "g", "n", "d"],
    ["h", "e", "l", "s", "a", "t"],
]
var words = ["san", "sana", "at", "vomit", "yours", "help", "end", "been", "bed", "danger", "calm", "ok", "chaos", "complete", "rear", "going", "storm", "face", "epual", "dangerous"]
var expected = ["yours", "help", "danger", "san", "at"]
var actual = boggleBoard(boggleBoard: board, words: words)
assert(actual.count == expected.count)

for word in actual
{
    assert(expected.contains(word))
}

board = [
    ["a", "b", "c", "d", "e"],
    ["f", "g", "h", "i", "j"],
    ["k", "l", "m", "n", "o"],
    ["p", "q", "r", "s", "t"],
    ["u", "v", "w", "x", "y"],
]
words = ["agmsy", "agmsytojed", "agmsytojedinhcbgl", "agmsytojedinhcbfl"]
expected = ["agmsy", "agmsytojed", "agmsytojedinhcbfl"]
actual = boggleBoard(boggleBoard: board, words: words)
assert(actual.count == expected.count)

for word in actual
{
    assert(expected.contains(word))
}

board = [
    ["a", "b"],
    ["c", "d"],
]
words = ["abcd", "abdc", "acbd", "acdb", "adbc", "adcb", "abca"]
expected = ["abcd", "abdc", "acbd", "acdb", "adbc", "adcb"]
actual = boggleBoard(boggleBoard: board, words: words)
assert(actual.count == expected.count)

for word in actual
{
    assert(expected.contains(word))
}

board = [
    ["f", "t", "r", "o", "p", "i", "k", "b", "o"],
    ["r", "w", "l", "p", "e", "u", "e", "a", "b"],
    ["j", "o", "t", "s", "e", "l", "f", "l", "p"],
    ["s", "z", "u", "t", "h", "u", "o", "p", "i"],
    ["k", "a", "e", "g", "n", "d", "r", "g", "a"],
    ["h", "n", "l", "s", "a", "t", "e", "t", "x"],
]
words = ["frozen", "rotten", "teleport", "city", "zutgatz", "kappa", "before", "rope", "obligate", "annoying"]
expected = ["frozen", "rotten", "teleport", "kappa", "before", "rope", "obligate"]
actual = boggleBoard(boggleBoard: board, words: words)
assert(actual.count == expected.count)

for word in actual
{
    assert(expected.contains(word))
}

board = [
    ["c", "o", "m"],
    ["r", "p", "l"],
    ["c", "i", "t"],
    ["o", "a", "e"],
    ["f", "o", "d"],
    ["z", "r", "b"],
    ["g", "i", "a"],
    ["o", "a", "g"],
    ["f", "s", "z"],
    ["t", "e", "i"],
    ["t", "w", "d"],
]
words = ["commerce", "complicated", "twisted", "zigzag", "comma", "foobar", "baz", "there"]
expected = ["complicated", "twisted", "zigzag", "foobar"]
actual = boggleBoard(boggleBoard: board, words: words)
assert(actual.count == expected.count)

for word in actual
{
    assert(expected.contains(word))
}

board = [
    ["c", "o", "m"],
    ["r", "p", "l"],
    ["c", "i", "t"],
    ["o", "a", "e"],
    ["f", "o", "d"],
    ["z", "r", "b"],
    ["g", "i", "a"],
    ["o", "a", "g"],
    ["f", "s", "z"],
    ["t", "e", "i"],
    ["t", "w", "d"],
]
words = ["cr", "oc", "ml", "iao", "opo", "zrb", "big", "fs", "ogiagao", "dwd", "twt"]
expected = ["cr", "oc", "ml", "iao", "zrb", "big", "fs", "twt"]
actual = boggleBoard(boggleBoard: board, words: words)
assert(actual.count == expected.count)

for word in actual
{
    assert(expected.contains(word))
}

board = [
    ["c", "o", "m"],
    ["r", "p", "l"],
    ["c", "i", "t"],
    ["o", "a", "e"],
    ["f", "o", "d"],
    ["z", "r", "b"],
    ["g", "i", "a"],
    ["o", "a", "g"],
    ["f", "s", "z"],
    ["t", "e", "i"],
    ["t", "w", "d"],
]
words = ["comlpriteacoofziraagsizefttw", "comlpriteacoofzirabagsizefottw", "comlpriteacoofziraagsizefottw", "comlpriteacoofzirabagsizeftttw"]
expected = ["comlpriteacoofziraagsizefttw"]
actual = boggleBoard(boggleBoard: board, words: words)
assert(actual.count == expected.count)

for word in actual
{
    assert(expected.contains(word))
}

board = [
    ["t", "h", "i", "s", "i", "s", "a"],
    ["s", "i", "m", "p", "l", "e", "x"],
    ["b", "x", "x", "x", "x", "e", "b"],
    ["x", "o", "g", "g", "l", "x", "o"],
    ["x", "x", "x", "D", "T", "r", "a"],
    ["R", "E", "P", "E", "A", "d", "x"],
    ["x", "x", "x", "x", "x", "x", "x"],
    ["N", "O", "T", "R", "E", "-", "P"],
    ["x", "x", "D", "E", "T", "A", "E"],
]
words = ["this", "is", "not", "a", "simple", "boggle", "board", "test", "REPEATED", "NOTRE-PEATED"]
expected = ["this", "is", "a", "simple", "boggle", "board", "NOTRE-PEATED"]
actual = boggleBoard(boggleBoard: board, words: words)
assert(actual.count == expected.count)

for word in actual
{
    assert(expected.contains(word))
}
