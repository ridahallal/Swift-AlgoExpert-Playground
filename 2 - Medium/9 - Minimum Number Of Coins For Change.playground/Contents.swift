//Minimum Number Of Coins For Change
//O(nd) time | O(n) space
func minimumNumberOfCoinsForChange(target: Int, denominations: [Int]) -> Int
{
    var numberOfCoins = Array(repeating: Int(Int16.max), count: target + 1)
    numberOfCoins[0] = 0
    
    for denomination in denominations
    {
        for amount in 0 ..< numberOfCoins.count
        {
            if denomination <= amount
            {
                numberOfCoins[amount] = min(numberOfCoins[amount], 1 + numberOfCoins[amount - denomination])
            }
        }
    }
    
    return numberOfCoins[target] != Int(Int16.max) ? numberOfCoins[target] : -1
}

//Tests
assert(minimumNumberOfCoinsForChange(target: 0, denominations: [1, 2, 3]) == 0)
assert(minimumNumberOfCoinsForChange(target: 3, denominations: [2, 1]) == 2)
assert(minimumNumberOfCoinsForChange(target: 4, denominations: [1, 5, 10]) == 4)
assert(minimumNumberOfCoinsForChange(target: 10, denominations: [1, 5, 10]) == 1)
assert(minimumNumberOfCoinsForChange(target: 11, denominations: [1, 5, 10]) == 2)
assert(minimumNumberOfCoinsForChange(target: 24, denominations: [1, 5, 10]) == 6)
assert(minimumNumberOfCoinsForChange(target: 25, denominations: [1, 5, 10]) == 3)
assert(minimumNumberOfCoinsForChange(target: 7, denominations: [2, 4]) == -1)
assert(minimumNumberOfCoinsForChange(target: 7, denominations: [3, 7]) == 1)
assert(minimumNumberOfCoinsForChange(target: 9, denominations: [3, 5]) == 3)
assert(minimumNumberOfCoinsForChange(target: 9, denominations: [3, 4, 5]) == 2)
assert(minimumNumberOfCoinsForChange(target: 135, denominations: [39, 45, 130, 40, 4, 1]) == 3)
assert(minimumNumberOfCoinsForChange(target: 135, denominations: [39, 45, 130, 40, 4, 1, 60, 75]) == 2)
