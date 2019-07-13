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

func stringifiedPowersetFirstSolution(array: [Int])
{
    let output = powersetFirstSolution(array: array, index: nil)
    print(output)
}

stringifiedPowersetFirstSolution(array: [1, 2])
