//Longest Common Subsequence
//Solution #1
//O(nm * min(n, m)) time | O(nm * min(n, m)) space
func longestCommonSubsequence(firstString: String, secondString: String) -> [String]
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

//Tests
assert(longestCommonSubsequence(firstString: "", secondString: "") == [])
assert(longestCommonSubsequence(firstString: "", secondString: "ABCDEFG") == [])
assert(longestCommonSubsequence(firstString: "ABCDEFG", secondString: "") == [])
assert(longestCommonSubsequence(firstString: "ABCDEFG", secondString: "ABCDEFG") == ["A", "B", "C", "D", "E", "F", "G"])
assert(longestCommonSubsequence(firstString: "ABCDEFG", secondString: "APPLES") == ["A", "E"])
assert(longestCommonSubsequence(firstString: "clement", secondString: "antoine") == ["n", "t"])
assert(longestCommonSubsequence(firstString: "ZXVVYZW", secondString: "XKYKZPW") == ["X", "Y", "Z", "W"])
assert(longestCommonSubsequence(firstString: "8111111111111111142", secondString: "222222222822222222222222222222433333333332") == ["8", "4", "2"])
assert(longestCommonSubsequence(firstString: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", secondString: "CCCDDEGDHAGKGLWAJWKJAWGKGWJAKLGGWAFWLFFWAGJWKAG") == ["C", "D", "E", "G", "H", "J", "K", "L", "W"])
assert(longestCommonSubsequence(firstString: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", secondString: "CCCDDEGDHAGKGLWAJWKJAWGKGWJAKLGGWAFWLFFWAGJWKAGTUV") == ["C", "D", "E", "G", "H", "J", "K", "L", "T", "U", "V"])
