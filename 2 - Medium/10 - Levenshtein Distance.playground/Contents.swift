//Levenshtein Distance
//Solution #1
//O(nd) time | O(nm) space)
func levenshteinDistanceFirstSolution(firstString: String, secondString: String) -> Int
{
    var edits = [[Int]]()
    
    for i in 0 ..< firstString.count + 1
    {
        var row = [Int]()
        
        for j in 0 ..< secondString.count + 1
        {
            row.append(j)
        }
        
        row[0] = i
        edits.append(row)
    }
    
    for i in 1 ..< firstString.count + 1
    {
        for j in 1 ..< secondString.count + 1
        {
            let firstIndex = firstString.index(firstString.startIndex, offsetBy: i - 1)
            let secondIndex = secondString.index(secondString.startIndex, offsetBy: j - 1)
            
            if firstString[firstIndex] == secondString[secondIndex]
            {
                edits[i][j] = edits[i - 1][j - 1]
            }
            else
            {
                edits[i][j] = 1 + min(edits[i - 1][j - 1], min(edits[i][j - 1], edits[i - 1][j]))
            }
        }
    }
    
    return edits[firstString.count][secondString.count]
}

//Solution #2
//O(nd) time | O(min(n, m) space)
func levenshteinDistanceSecondSolution(firstString: String, secondString: String) -> Int
{
    let small = firstString.count < secondString.count ? firstString : secondString
    let big = firstString.count >= secondString.count ? firstString : secondString
    
    var evenEdits = [Int]()
    var oddEdits = Array(repeating: 0, count: small.count + 1)
    
    for i in 0 ..< small.count + 1
    {
        evenEdits.append(i)
    }
    
    for i in 1 ..< big.count + 1
    {
        if i % 2 == 1
        {
            optimizedLevenshteinHelper(bigIndex: i, smallString: small, bigString: big, currentEdits: &oddEdits, previousEdits: &evenEdits)
        }
        else
        {
            optimizedLevenshteinHelper(bigIndex: i, smallString: small, bigString: big, currentEdits: &evenEdits, previousEdits: &oddEdits)
        }
    }
    
    return big.count % 2 == 0 ? evenEdits[small.count] : oddEdits[small.count]
}

func optimizedLevenshteinHelper(bigIndex: Int, smallString: String, bigString: String, currentEdits: inout [Int], previousEdits: inout [Int])
{
    currentEdits[0] = bigIndex
    
    for j in 1 ..< smallString.count + 1
    {
        let firstIndex = bigString.index(bigString.startIndex, offsetBy: bigIndex - 1)
        let secondIndex = smallString.index(smallString.startIndex, offsetBy: j - 1)
        
        if bigString[firstIndex] == smallString[secondIndex]
        {
            currentEdits[j] = previousEdits[j - 1]
        }
        else
        {
            currentEdits[j] = 1 + min(previousEdits[j], min(previousEdits[j - 1], currentEdits[j - 1]))
        }
    }
}

//Tests
assert(levenshteinDistanceFirstSolution(firstString: "", secondString: "") == 0)
assert(levenshteinDistanceFirstSolution(firstString: "", secondString: "abc") == 3)
assert(levenshteinDistanceFirstSolution(firstString: "abc", secondString: "abc") == 0)
assert(levenshteinDistanceFirstSolution(firstString: "abc", secondString: "abx") == 1)
assert(levenshteinDistanceFirstSolution(firstString: "abc", secondString: "abcx") == 1)
assert(levenshteinDistanceFirstSolution(firstString: "abc", secondString: "yabcx") == 2)
assert(levenshteinDistanceFirstSolution(firstString: "algoexpert", secondString: "algozexpert") == 1)
assert(levenshteinDistanceFirstSolution(firstString: "abcdefghij", secondString: "1234567890") == 10)
assert(levenshteinDistanceFirstSolution(firstString: "abcdefghij", secondString: "a234567890") == 9)
assert(levenshteinDistanceFirstSolution(firstString: "biting", secondString: "mitten") == 4)
assert(levenshteinDistanceFirstSolution(firstString: "cereal", secondString: "saturday") == 6)
assert(levenshteinDistanceFirstSolution(firstString: "cereal", secondString: "saturdzz") == 7)
assert(levenshteinDistanceFirstSolution(firstString: "abbbbbbbbb", secondString: "bbbbbbbbba") == 2)
assert(levenshteinDistanceFirstSolution(firstString: "abc", secondString: "yabd") == 2)
assert(levenshteinDistanceFirstSolution(firstString: "xabc", secondString: "abcx") == 2)

assert(levenshteinDistanceSecondSolution(firstString: "", secondString: "") == 0)
assert(levenshteinDistanceSecondSolution(firstString: "", secondString: "abc") == 3)
assert(levenshteinDistanceSecondSolution(firstString: "abc", secondString: "abc") == 0)
assert(levenshteinDistanceSecondSolution(firstString: "abc", secondString: "abx") == 1)
assert(levenshteinDistanceSecondSolution(firstString: "abc", secondString: "abcx") == 1)
assert(levenshteinDistanceSecondSolution(firstString: "abc", secondString: "yabcx") == 2)
assert(levenshteinDistanceSecondSolution(firstString: "algoexpert", secondString: "algozexpert") == 1)
assert(levenshteinDistanceSecondSolution(firstString: "abcdefghij", secondString: "1234567890") == 10)
assert(levenshteinDistanceSecondSolution(firstString: "abcdefghij", secondString: "a234567890") == 9)
assert(levenshteinDistanceSecondSolution(firstString: "biting", secondString: "mitten") == 4)
assert(levenshteinDistanceSecondSolution(firstString: "cereal", secondString: "saturday") == 6)
assert(levenshteinDistanceSecondSolution(firstString: "cereal", secondString: "saturdzz") == 7)
assert(levenshteinDistanceSecondSolution(firstString: "abbbbbbbbb", secondString: "bbbbbbbbba") == 2)
assert(levenshteinDistanceSecondSolution(firstString: "abc", secondString: "yabd") == 2)
assert(levenshteinDistanceSecondSolution(firstString: "xabc", secondString: "abcx") == 2)
