//Permutations
//Solution #1
//Upper Bound: O(n^2 * n!) time | O(n * n!) space
//Roughly: O(n * n!) time | O(n * n!) space
func permutationsFirstSolution(array: [Int]) -> [[Int]]
{
    var permutations = [[Int]]()
    permutationsFirstSolutionHelper(array: array, currentPermutation: [], permutations: &permutations)
    
    return permutations
}

func permutationsFirstSolutionHelper(array: [Int], currentPermutation: [Int], permutations: inout [[Int]])
{
    if array.count == 0 && currentPermutation.count > 0
    {
        permutations.append(currentPermutation)
    }
    else
    {
        for i in 0 ..< array.count
        {
            let newArray = Array(array.prefix(upTo: i) + array.suffix(from: i + 1))
            let newPermutation = currentPermutation + [array[i]]
            
            permutationsFirstSolutionHelper(array: newArray, currentPermutation: newPermutation, permutations: &permutations)
        }
    }
}

//Solution #2
//O(n * n!) time | O(n * n!) space
func permutationsSecondSolution(array: [Int])
{
    
}

//Tests
let firstTest: [Int] = []
let firstTestResults = permutationsFirstSolution(array: firstTest)
assert(firstTestResults.count == 0)

let secondTest: [Int] = [1]
let secondTestResults = permutationsFirstSolution(array: secondTest)
assert(secondTestResults.count == 1)
assert(secondTestResults.contains([1]))

let thirdTest: [Int] = [1, 2]
let thirdTestResults = permutationsFirstSolution(array: thirdTest)
assert(thirdTestResults.count == 2)
assert(thirdTestResults.contains([1, 2]))
assert(thirdTestResults.contains([2, 1]))

let fourthTest: [Int] = [1, 2, 3]
let fourthTestResults = permutationsFirstSolution(array: fourthTest)
assert(fourthTestResults.count == 6)
assert(fourthTestResults.contains([1, 2, 3]))
assert(fourthTestResults.contains([1, 3, 2]))
assert(fourthTestResults.contains([2, 1, 3]))
assert(fourthTestResults.contains([2, 3, 1]))
assert(fourthTestResults.contains([3, 1, 2]))
assert(fourthTestResults.contains([3, 2, 1]))

let fifthTest: [Int] = [1, 2, 3, 4]
let fifthTestResults = permutationsFirstSolution(array: fifthTest)
assert(fifthTestResults.count == 24)
assert(fifthTestResults.contains([1, 2, 3, 4]))
assert(fifthTestResults.contains([1, 2, 4, 3]))
assert(fifthTestResults.contains([1, 3, 2, 4]))
assert(fifthTestResults.contains([1, 3, 4, 2]))
assert(fifthTestResults.contains([1, 4, 3, 2]))
assert(fifthTestResults.contains([1, 4, 2, 3]))
assert(fifthTestResults.contains([2, 1, 3, 4]))
assert(fifthTestResults.contains([2, 1, 4, 3]))
assert(fifthTestResults.contains([2, 3, 1, 4]))
assert(fifthTestResults.contains([2, 3, 4, 1]))
assert(fifthTestResults.contains([2, 4, 1, 3]))
assert(fifthTestResults.contains([2, 4, 3, 1]))
assert(fifthTestResults.contains([3, 1, 2, 4]))
assert(fifthTestResults.contains([3, 1, 4, 2]))
assert(fifthTestResults.contains([3, 2, 1, 4]))
assert(fifthTestResults.contains([3, 2, 4, 1]))
assert(fifthTestResults.contains([3, 4, 1, 2]))
assert(fifthTestResults.contains([3, 4, 2, 1]))
assert(fifthTestResults.contains([4, 1, 2, 3]))
assert(fifthTestResults.contains([4, 1, 3, 2]))
assert(fifthTestResults.contains([4, 2, 1, 3]))
assert(fifthTestResults.contains([4, 2, 3, 1]))
assert(fifthTestResults.contains([4, 3, 1, 2]))
assert(fifthTestResults.contains([4, 3, 2, 1]))
