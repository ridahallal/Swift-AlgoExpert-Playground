//Number Of Ways To Make Change
//O(nd) time | O(n) space
func numberOfWaysToMakeChange(target: Int, denominations: [Int]) -> Int
{
    var ways = Array(repeating: 0, count: target + 1)
    ways[0] = 1
    
    for denomination in denominations
    {
        for amount in 1 ..< target + 1
        {
            if denomination <= amount
            {
                ways[amount] = ways[amount] + ways[amount - denomination]
            }
        }
    }
    
    return ways[target]
}

//Tests
assert(numberOfWaysToMakeChange(target: 0, denominations: [2, 3, 4, 7]) == 1)
assert(numberOfWaysToMakeChange(target: 9, denominations: [5]) == 0)
assert(numberOfWaysToMakeChange(target: 7, denominations: [2, 4]) == 0)
assert(numberOfWaysToMakeChange(target: 6, denominations: [1, 5]) == 2)
assert(numberOfWaysToMakeChange(target: 4, denominations: [1, 5, 10, 25]) == 1)
assert(numberOfWaysToMakeChange(target: 5, denominations: [1, 5, 10, 25]) == 2)
assert(numberOfWaysToMakeChange(target: 10, denominations: [1, 5, 10, 25]) == 4)
assert(numberOfWaysToMakeChange(target: 25, denominations: [1, 5, 10, 25]) == 13)
assert(numberOfWaysToMakeChange(target: 12, denominations: [2, 3, 7]) == 4)
assert(numberOfWaysToMakeChange(target: 7, denominations: [2, 3, 4, 7]) == 3)
