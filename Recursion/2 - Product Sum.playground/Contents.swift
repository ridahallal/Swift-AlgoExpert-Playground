//Product Sum
//O(n) time | O(d) space
func productSum(_ array: [Any], multiplier: Int) -> Int
{
    var sum = 0
    
    for element in array
    {
        if let elementAsArray = element as? [Any]
        {
            sum += productSum(elementAsArray, multiplier: multiplier + 1)
        }
        else if let elementAsInt = element as? Int
        {
            sum += elementAsInt
        }
    }
    
    return sum * multiplier
}

//Tests
let firstTest: [Any] = [1, 2, 3, 4, 5]
assert(productSum(firstTest, multiplier: 1) == 15)

let secondTest: [Any] = [1, 2, [3], 4, 5]
assert(productSum(secondTest, multiplier: 1) == 18)

let thirdTest: [Any] = [[1, 2], 3, [4, 5]]
assert(productSum(thirdTest, multiplier: 1) == 27)

let fourthTest: [Any] = [[[[[5]]]]]
assert(productSum(fourthTest, multiplier: 1) == 600)

let fifthTest: [Any] = [
    9,
    [2, -3, 4],
    1,
    [1, 1, [1, 1, 1]],
    [[[[3, 4, 1]]], 8],
    [1, 2, 3, 4, 5, [6, 7], -7],
    [1, [2, 3, [4, 5]], [6, 0, [7, 0, -8]], -7],
    [1, -3, 2, [1, -3, 2, [1, -3, 2], [1, -3, 2, [1, -3, 2]], [1, -3, 2]]],
    -3,
]
assert(productSum(fifthTest, multiplier: 1) == 1351)

let sixthTest: [Any] = [5, 2, [7, -1], 3, [6, [-13, 8], 4]]
assert(productSum(sixthTest, multiplier: 1) == 12)
