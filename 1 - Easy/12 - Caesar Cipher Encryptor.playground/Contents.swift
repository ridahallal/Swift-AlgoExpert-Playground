//Caesar Cipher Encryptor
//Solution #1
//O(n) time | O(n) space
func caesarCipherEncryptorFirstSolution(string: String, key: UInt32) -> String
{
    var newLetters = [Character]()
    let newKey = key % 26
    
    for letter in string
    {
        newLetters.append(getNewLetterFirstSolution(letter, newKey))
    }
    
    return String(newLetters)
}

func getNewLetterFirstSolution(_ letter: Character, _ key: UInt32) -> Character
{
    let newLetterCode = letter.unicodeScalars.first!.value + key
    
    let code: UnicodeScalar?
    
    if newLetterCode <= 122
    {
        code = UnicodeScalar(newLetterCode)
    }
    else
    {
        code = UnicodeScalar(96 + newLetterCode % 122)
    }
    
    return Character(code!)
}

//Solution #2
//O(n) time | O(n) space
func caesarCipherEncryptorSecondSolution(string: String, key: Int) -> String
{
    var newLetters = [Character]()
    let newKey = key % 26
    
    let alphabet = Array("abcdefghijklmnopqrstuvwxyz")
    
    for letter in string
    {
        newLetters.append(getNewLetterSecondSolution(letter, newKey, alphabet))
    }
    
    return String(newLetters)
}

func getNewLetterSecondSolution(_ letter: Character, _ key: Int, _ alphabet: [Character]) -> Character
{
    let newLetterCode = alphabet.firstIndex(of: letter)! + key
    
    if newLetterCode <= 25
    {
        return alphabet[newLetterCode]
    }
    else
    {
        return alphabet[-1 + newLetterCode % 25]
    }
}

//Tests
//Solution #1
assert(caesarCipherEncryptorFirstSolution(string: "abc", key: 0) == "abc")
assert(caesarCipherEncryptorFirstSolution(string: "abc", key: 3) == "def")
assert(caesarCipherEncryptorFirstSolution(string: "xyz", key: 2) == "zab")
assert(caesarCipherEncryptorFirstSolution(string: "xyz", key: 5) == "cde")
assert(caesarCipherEncryptorFirstSolution(string: "abc", key: 26) == "abc")
assert(caesarCipherEncryptorFirstSolution(string: "abc", key: 52) == "abc")
assert(caesarCipherEncryptorFirstSolution(string: "abc", key: 57) == "fgh")

//Solution #2
assert(caesarCipherEncryptorSecondSolution(string: "abc", key: 0) == "abc")
assert(caesarCipherEncryptorSecondSolution(string: "abc", key: 3) == "def")
assert(caesarCipherEncryptorSecondSolution(string: "xyz", key: 2) == "zab")
assert(caesarCipherEncryptorSecondSolution(string: "xyz", key: 5) == "cde")
assert(caesarCipherEncryptorSecondSolution(string: "abc", key: 26) == "abc")
assert(caesarCipherEncryptorSecondSolution(string: "abc", key: 52) == "abc")
assert(caesarCipherEncryptorSecondSolution(string: "abc", key: 57) == "fgh")
