//Powerset
//Solution #1 (Recursive)
//O(n * 2^n) time | O(n * 2^n) space
func powersetFirstSolution(array: [Int], index: Int?) -> [[Int]]
{
    var index = index
    
    if index == nil
    {
        index = array.count - 1
    }
    
    if index! < 0
    {
        return [[]]
    }
    
    //Get element at current index
    let element = array[index!]
    
    //Get the subsets for the elements up to the preceding index
    var subsets = powersetFirstSolution(array: array, index: index! - 1)
    
    //Get the length of the subsets
    let length = subsets.count
    
    //Loop around these subsets
    for i in 0 ..< length
    {
        //Add to each subset the current element and append it to the subsets array
        let currentSubset = subsets[i]
        subsets.append(currentSubset + [element])
    }
    
    return subsets
}

//Solution #2 (Iterative)
//O(n * 2^n) time | O(n * 2^n) space
func powersetSecondSolution(array: [Int]) -> [[Int]]
{
    var subsets: [[Int]] = [[]]
    
    for element in array
    {
        for subset in subsets
        {
            subsets.append(subset + [element])
        }
    }
    
    return subsets
}

//Tests
func sortAndStringify(array: [[Int]]) -> [String]
{
    var result = [String]()
    
    for var set in array
    {
        set = set.sorted()
        
        var string = String()
        
        for item in set
        {
            string.append("\(item)")
            
            if item != set.last
            {
                string.append(", ")
            }
        }
        
        result.append(string)
    }
    
    return result
}


var firstTest = powersetFirstSolution(array: [], index: nil)
var firstTestStringified = sortAndStringify(array: firstTest)
assert(firstTestStringified.count == 1)
assert(firstTestStringified.contains(""))

firstTest = powersetSecondSolution(array: [])
firstTestStringified = sortAndStringify(array: firstTest)
assert(firstTestStringified.count == 1)
assert(firstTestStringified.contains(""))

var secondTest = powersetFirstSolution(array: [1], index: nil)
var secondTestStringified = sortAndStringify(array: secondTest)
assert(secondTestStringified.count == 2)
assert(secondTestStringified.contains(""))
assert(secondTestStringified.contains("1"))

secondTest = powersetSecondSolution(array: [1])
secondTestStringified = sortAndStringify(array: secondTest)
assert(secondTestStringified.count == 2)
assert(secondTestStringified.contains(""))
assert(secondTestStringified.contains("1"))

var thirdTest = powersetFirstSolution(array: [1, 2], index: nil)
var thirdTestStringified = sortAndStringify(array: thirdTest)
assert(thirdTestStringified.count == 4)
assert(thirdTestStringified.contains(""))
assert(thirdTestStringified.contains("1"))
assert(thirdTestStringified.contains("2"))
assert(thirdTestStringified.contains("1, 2"))

thirdTest = powersetSecondSolution(array: [1, 2])
thirdTestStringified = sortAndStringify(array: thirdTest)
assert(thirdTestStringified.count == 4)
assert(thirdTestStringified.contains(""))
assert(thirdTestStringified.contains("1"))
assert(thirdTestStringified.contains("2"))
assert(thirdTestStringified.contains("1, 2"))

var fourthTest = powersetFirstSolution(array: [1, 2, 3], index: nil)
var fourthTestStringified = sortAndStringify(array: fourthTest)
assert(fourthTestStringified.count == 8)
assert(fourthTestStringified.contains(""))
assert(fourthTestStringified.contains("1"))
assert(fourthTestStringified.contains("2"))
assert(fourthTestStringified.contains("1, 2"))
assert(fourthTestStringified.contains("3"))
assert(fourthTestStringified.contains("1, 3"))
assert(fourthTestStringified.contains("2, 3"))
assert(fourthTestStringified.contains("1, 2, 3"))

fourthTest = powersetSecondSolution(array: [1, 2, 3])
fourthTestStringified = sortAndStringify(array: fourthTest)
assert(fourthTestStringified.count == 8)
assert(fourthTestStringified.contains(""))
assert(fourthTestStringified.contains("1"))
assert(fourthTestStringified.contains("2"))
assert(fourthTestStringified.contains("1, 2"))
assert(fourthTestStringified.contains("3"))
assert(fourthTestStringified.contains("1, 3"))
assert(fourthTestStringified.contains("2, 3"))
assert(fourthTestStringified.contains("1, 2, 3"))

var fifthTest = powersetFirstSolution(array: [1, 2, 3, 4], index: nil)
var fifthTestStringified = sortAndStringify(array: fifthTest)
assert(fifthTestStringified.count == 16)
assert(fifthTestStringified.contains(""))
assert(fifthTestStringified.contains("1"))
assert(fifthTestStringified.contains("2"))
assert(fifthTestStringified.contains("1, 2"))
assert(fifthTestStringified.contains("3"))
assert(fifthTestStringified.contains("1, 3"))
assert(fifthTestStringified.contains("2, 3"))
assert(fifthTestStringified.contains("1, 2, 3"))
assert(fifthTestStringified.contains("4"))
assert(fifthTestStringified.contains("1, 4"))
assert(fifthTestStringified.contains("2, 4"))
assert(fifthTestStringified.contains("1, 2, 4"))
assert(fifthTestStringified.contains("3, 4"))
assert(fifthTestStringified.contains("1, 3, 4"))
assert(fifthTestStringified.contains("2, 3, 4"))
assert(fifthTestStringified.contains("1, 2, 3, 4"))

fifthTest = powersetSecondSolution(array: [1, 2, 3, 4])
fifthTestStringified = sortAndStringify(array: fifthTest)
assert(fifthTestStringified.count == 16)
assert(fifthTestStringified.contains(""))
assert(fifthTestStringified.contains("1"))
assert(fifthTestStringified.contains("2"))
assert(fifthTestStringified.contains("1, 2"))
assert(fifthTestStringified.contains("3"))
assert(fifthTestStringified.contains("1, 3"))
assert(fifthTestStringified.contains("2, 3"))
assert(fifthTestStringified.contains("1, 2, 3"))
assert(fifthTestStringified.contains("4"))
assert(fifthTestStringified.contains("1, 4"))
assert(fifthTestStringified.contains("2, 4"))
assert(fifthTestStringified.contains("1, 2, 4"))
assert(fifthTestStringified.contains("3, 4"))
assert(fifthTestStringified.contains("1, 3, 4"))
assert(fifthTestStringified.contains("2, 3, 4"))
assert(fifthTestStringified.contains("1, 2, 3, 4"))
