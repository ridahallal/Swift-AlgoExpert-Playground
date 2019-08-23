//Multi String Search
//Solution #1
//O(bns) time | O(n) space
func multiStringSearch(_ bigString: String, _ smallStrings: [String]) -> [Bool]
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

assert(multiStringSearch("this is a big string", ["this", "yo", "is", "a", "bigger", "string", "kappa"]) == [true, false, true, true, false, true, false])

assert(multiStringSearch("Mary goes to the shopping center every week.", ["to", "Mary", "centers", "shop", "shopping", "string", "kappa"]) == [true, true, false, true, true, false, false])

assert(multiStringSearch("adcb akfkw afnmc fkadn vkaca jdaf dacb cdba cbda", ["abcd", "acbd", "adbc", "dabc", "cbda", "cabd", "cdab"]) == [false, false, false, false, true, false, false])

assert(multiStringSearch("test testing testings tests testers test-takers", ["tests", "testatk", "testiing", "trsatii", "test-taker", "test"]) == [true, false, false, false, true, true])

assert(multiStringSearch("ndbajwhfawkjljkfaopwdlaawjk dawkj awjkawkfjhkawk ahjwkjad jadfljawd", ["abc", "akwbc", "awbc", "abafac", "ajjfbc", "abac", "jadfl"]) == [false, false, false, false, false, false, true])

assert(multiStringSearch("Is this particular test going to pass or is it going to fail? That is the question.", ["that", "the", "questions", "goes", "mountain", "passes", "passed", "going", "is"]) == [false, true, false, false, false, false, false, true, true])

assert(multiStringSearch("Everything in this test should fail.", ["everything", "inn", "that", "testers", "shall", "failure"]) == [false, false, false, false, false, false])
