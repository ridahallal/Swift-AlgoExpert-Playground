//Longest Common Subsequence
//Solution #1
//O(nm * min(n, m)) time | O(nm * min(n, m)) space
func longestCommonSubsequenceFirstSolution(firstString: String, secondString: String) -> [String]
{
    var lcs = [[[String]]]()
    
    for _ in 0 ..< firstString.count + 1
    {
        let row = Array(repeating: [String](), count: secondString.count + 1)
        lcs.append(row)
    }
    
    for i in stride(from: 1, to: firstString.count + 1, by: 1)
    {
        for j in stride(from: 1, to: secondString.count + 1, by: 1)
        {
            let firstIndex = firstString.index(firstString.startIndex, offsetBy: i - 1)
            let secondIndex = secondString.index(secondString.startIndex, offsetBy: j - 1)
            
            if firstString[firstIndex] == secondString[secondIndex]
            {
                var diagonal = lcs[i - 1][j - 1]
                let char = String(firstString[firstIndex])
                diagonal.append(char)
                
                lcs[i][j] = diagonal
            }
            else
            {
                let left = lcs[i][j - 1]
                let top = lcs[i - 1][j]
                
                lcs[i][j] = left.count > top.count ? left : top
            }
        }
    }
    
    return lcs[firstString.count][secondString.count]
}

//Solution #2
//O(nm * min(n, m)) time | O(min(n, m)^2) space
func longestCommonSubsequenceSecondSolution(firstString: String, secondString: String) -> [String]
{
    let smallestString = firstString.count < secondString.count ? firstString : secondString
    let biggestString = firstString.count >= secondString.count ? firstString : secondString
    
    //Keep the last two rows only, as they're the only ones we need
    var evenLCS = Array(repeating: [String](), count: smallestString.count + 1)
    var oddLCS = Array(repeating: [String](), count: smallestString.count + 1)
    
    for i in stride(from: 1, to: biggestString.count + 1, by: 1)
    {
        if i % 2 == 0
        {
            secondSolutionHelper(i, biggestString, smallestString, currentLCS: &evenLCS, previousLCS: &oddLCS)
        }
        else
        {
            secondSolutionHelper(i, biggestString, smallestString, currentLCS: &oddLCS, previousLCS: &evenLCS)
        }
    }
    
    return biggestString.count % 2 == 0 ? evenLCS[smallestString.count] : oddLCS[smallestString.count]
}

func secondSolutionHelper(_ i: Int, _ biggestString: String, _ smallestString: String, currentLCS: inout [[String]], previousLCS: inout [[String]])
{
    for j in stride(from: 1, to: smallestString.count + 1, by: 1)
    {
        let firstIndex = biggestString.index(biggestString.startIndex, offsetBy: i - 1)
        let secondIndex = smallestString.index(smallestString.startIndex, offsetBy: j - 1)
        
        if biggestString[firstIndex] == smallestString[secondIndex]
        {
            var diagonal = previousLCS[j - 1]
            let char = String(smallestString[secondIndex])
            diagonal.append(char)
            
            currentLCS[j] = diagonal
        }
        else
        {
            let top = previousLCS[j]
            let left = currentLCS[j - 1]
            
            if top.count > left.count
            {
                currentLCS[j] = top
            }
            else
            {
                currentLCS[j] = left
            }
        }
    }
}

//Solution #3
//O(nm) time | O(nm) space
func longestCommonSubsequenceThirdSolution(firstString: String, secondString: String) -> [String]
{
    //Matrix of tuples (character, count, previous x, previous y)
    var lcs = [[(String, Int, Int, Int)]]()
    
    for _ in stride(from: 0, to: firstString.count + 1, by: 1)
    {
        var row = [(String, Int, Int, Int)]()
        
        for _ in stride(from: 0, to: secondString.count + 1, by: 1)
        {
            let tuple = ("", 0, 0, 0)
            row.append(tuple)
        }
        
        lcs.append(row)
    }
    
    for i in stride(from: 1, to: firstString.count + 1, by: 1)
    {
        for j in stride(from: 1, to: secondString.count + 1, by: 1)
        {
            let firstIndex = firstString.index(firstString.startIndex, offsetBy: i - 1)
            let secondIndex = secondString.index(secondString.startIndex, offsetBy: j - 1)
            
            if firstString[firstIndex] == secondString[secondIndex]
            {
                let char = String(firstString[firstIndex])
                lcs[i][j] = (char, lcs[i - 1][j - 1].1 + 1, i - 1, j - 1)
            }
            else
            {
                if (lcs[i - 1][j].1 > lcs[i][j - 1].1)
                {
                    lcs[i][j] = ("", lcs[i - 1][j].1, i - 1, j)
                }
                else
                {
                    lcs[i][j] = ("", lcs[i][j - 1].1, i, j - 1)
                }
            }
        }
    }
    
    return buildSequence(lcs: lcs)
}

//Traverse our matrix and build our lcs
func buildSequence(lcs: [[(String, Int, Int, Int)]]) -> [String]
{
    var sequence = [String]()
    
    var i = lcs.count - 1
    var j = lcs[0].count - 1
    
    while i != 0 && j != 0
    {
        let currentEntry = lcs[i][j]
        
        if currentEntry.0 != ""
        {
            sequence.insert(currentEntry.0, at: 0)
        }
        
        i = currentEntry.2
        j = currentEntry.3
    }
    
    return sequence
}

//Solution #4
//O(nm) time | O(nm) space
func longestCommonSubsequenceFourthSolution(firstString: String, secondString: String) -> [String]
{
    var lengths = [[Int]]()
    
    for _ in stride(from: 0, to: firstString.count + 1, by: 1)
    {
        let row = Array(repeating: 0, count: secondString.count + 1)
        lengths.append(row)
    }
    
    for i in stride(from: 1, to: firstString.count + 1, by: 1)
    {
        for j in stride(from: 1, to: secondString.count + 1, by: 1)
        {
            let firstIndex = firstString.index(firstString.startIndex, offsetBy: i - 1)
            let secondIndex = secondString.index(secondString.startIndex, offsetBy: j - 1)
            
            if firstString[firstIndex] == secondString[secondIndex]
            {
                lengths[i][j] = lengths[i - 1][j - 1] + 1
            }
            else
            {
                lengths[i][j] = max(lengths[i - 1][j], lengths[i][j - 1])
            }
        }
    }
    
    return buildSequence(lengths: lengths, string: secondString)
}

//Build lcs from lengths array and initial string
func buildSequence(lengths: [[Int]], string: String) -> [String]
{
    var sequence = [String]()
    
    var i = lengths.count - 1
    var j = lengths[0].count - 1
    
    while i != 0 && j != 0
    {
        if (lengths[i][j] == lengths[i - 1][j])
        {
            i -= 1
        }
        else if (lengths[i][j] == lengths[i][j - 1])
        {
            j -= 1
        }
        else
        {
            let index = string.index(string.startIndex, offsetBy: j - 1)
            let char = String(string[index])
            
            sequence.insert(char, at: 0)
            i -= 1
            j -= 1
        }
    }
    
    return sequence
}

//Tests
assert(longestCommonSubsequenceFirstSolution(firstString: "", secondString: "") == [])
assert(longestCommonSubsequenceFirstSolution(firstString: "", secondString: "ABCDEFG") == [])
assert(longestCommonSubsequenceFirstSolution(firstString: "ABCDEFG", secondString: "") == [])
assert(longestCommonSubsequenceFirstSolution(firstString: "ABCDEFG", secondString: "ABCDEFG") == ["A", "B", "C", "D", "E", "F", "G"])
assert(longestCommonSubsequenceFirstSolution(firstString: "ABCDEFG", secondString: "APPLES") == ["A", "E"])
assert(longestCommonSubsequenceFirstSolution(firstString: "clement", secondString: "antoine") == ["n", "t"])
assert(longestCommonSubsequenceFirstSolution(firstString: "ZXVVYZW", secondString: "XKYKZPW") == ["X", "Y", "Z", "W"])
assert(longestCommonSubsequenceFirstSolution(firstString: "8111111111111111142", secondString: "222222222822222222222222222222433333333332") == ["8", "4", "2"])
assert(longestCommonSubsequenceFirstSolution(firstString: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", secondString: "CCCDDEGDHAGKGLWAJWKJAWGKGWJAKLGGWAFWLFFWAGJWKAG") == ["C", "D", "E", "G", "H", "J", "K", "L", "W"])
assert(longestCommonSubsequenceFirstSolution(firstString: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", secondString: "CCCDDEGDHAGKGLWAJWKJAWGKGWJAKLGGWAFWLFFWAGJWKAGTUV") == ["C", "D", "E", "G", "H", "J", "K", "L", "T", "U", "V"])

assert(longestCommonSubsequenceSecondSolution(firstString: "", secondString: "") == [])
assert(longestCommonSubsequenceSecondSolution(firstString: "", secondString: "ABCDEFG") == [])
assert(longestCommonSubsequenceSecondSolution(firstString: "ABCDEFG", secondString: "") == [])
assert(longestCommonSubsequenceSecondSolution(firstString: "ABCDEFG", secondString: "ABCDEFG") == ["A", "B", "C", "D", "E", "F", "G"])
assert(longestCommonSubsequenceSecondSolution(firstString: "ABCDEFG", secondString: "APPLES") == ["A", "E"])
assert(longestCommonSubsequenceSecondSolution(firstString: "clement", secondString: "antoine") == ["n", "t"])
assert(longestCommonSubsequenceSecondSolution(firstString: "ZXVVYZW", secondString: "XKYKZPW") == ["X", "Y", "Z", "W"])
assert(longestCommonSubsequenceSecondSolution(firstString: "8111111111111111142", secondString: "222222222822222222222222222222433333333332") == ["8", "4", "2"])
assert(longestCommonSubsequenceSecondSolution(firstString: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", secondString: "CCCDDEGDHAGKGLWAJWKJAWGKGWJAKLGGWAFWLFFWAGJWKAG") == ["C", "D", "E", "G", "H", "J", "K", "L", "W"])
assert(longestCommonSubsequenceSecondSolution(firstString: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", secondString: "CCCDDEGDHAGKGLWAJWKJAWGKGWJAKLGGWAFWLFFWAGJWKAGTUV") == ["C", "D", "E", "G", "H", "J", "K", "L", "T", "U", "V"])

assert(longestCommonSubsequenceThirdSolution(firstString: "", secondString: "") == [])
assert(longestCommonSubsequenceThirdSolution(firstString: "", secondString: "ABCDEFG") == [])
assert(longestCommonSubsequenceThirdSolution(firstString: "ABCDEFG", secondString: "") == [])
assert(longestCommonSubsequenceThirdSolution(firstString: "ABCDEFG", secondString: "ABCDEFG") == ["A", "B", "C", "D", "E", "F", "G"])
assert(longestCommonSubsequenceThirdSolution(firstString: "ABCDEFG", secondString: "APPLES") == ["A", "E"])
assert(longestCommonSubsequenceThirdSolution(firstString: "clement", secondString: "antoine") == ["n", "t"])
assert(longestCommonSubsequenceThirdSolution(firstString: "ZXVVYZW", secondString: "XKYKZPW") == ["X", "Y", "Z", "W"])
assert(longestCommonSubsequenceThirdSolution(firstString: "8111111111111111142", secondString: "222222222822222222222222222222433333333332") == ["8", "4", "2"])
assert(longestCommonSubsequenceThirdSolution(firstString: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", secondString: "CCCDDEGDHAGKGLWAJWKJAWGKGWJAKLGGWAFWLFFWAGJWKAG") == ["C", "D", "E", "G", "H", "J", "K", "L", "W"])
assert(longestCommonSubsequenceThirdSolution(firstString: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", secondString: "CCCDDEGDHAGKGLWAJWKJAWGKGWJAKLGGWAFWLFFWAGJWKAGTUV") == ["C", "D", "E", "G", "H", "J", "K", "L", "T", "U", "V"])

assert(longestCommonSubsequenceFourthSolution(firstString: "", secondString: "") == [])
assert(longestCommonSubsequenceFourthSolution(firstString: "", secondString: "ABCDEFG") == [])
assert(longestCommonSubsequenceFourthSolution(firstString: "ABCDEFG", secondString: "") == [])
assert(longestCommonSubsequenceFourthSolution(firstString: "ABCDEFG", secondString: "ABCDEFG") == ["A", "B", "C", "D", "E", "F", "G"])
assert(longestCommonSubsequenceFourthSolution(firstString: "ABCDEFG", secondString: "APPLES") == ["A", "E"])
assert(longestCommonSubsequenceFourthSolution(firstString: "clement", secondString: "antoine") == ["n", "t"])
assert(longestCommonSubsequenceFourthSolution(firstString: "ZXVVYZW", secondString: "XKYKZPW") == ["X", "Y", "Z", "W"])
assert(longestCommonSubsequenceFourthSolution(firstString: "8111111111111111142", secondString: "222222222822222222222222222222433333333332") == ["8", "4", "2"])
assert(longestCommonSubsequenceFourthSolution(firstString: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", secondString: "CCCDDEGDHAGKGLWAJWKJAWGKGWJAKLGGWAFWLFFWAGJWKAG") == ["C", "D", "E", "G", "H", "J", "K", "L", "W"])
assert(longestCommonSubsequenceFourthSolution(firstString: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", secondString: "CCCDDEGDHAGKGLWAJWKJAWGKGWJAKLGGWAFWLFFWAGJWKAGTUV") == ["C", "D", "E", "G", "H", "J", "K", "L", "T", "U", "V"])
