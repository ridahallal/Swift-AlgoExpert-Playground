//Max Profit With K Transactions
//Solution #1
//O(nk) time | O(nk) space
func maxProfitWithKTransactionsFirstSolution(_ prices: [Int], _ k: Int) -> Int
{
    if prices.count == 0
    {
        return 0
    }
    
    //Initialize our matrix
    var profits = [[Int]]()
    
    //For each transaction + 1 (if we have 2 transactions then we want three rows)
    for _ in stride(from: 0, through: k, by: 1)
    {
        let row = Array(repeating: 0, count: prices.count)
        profits.append(row)
    }
    
    //Start at the first transaction and go through the last
    for transaction in stride(from: 1, through: k, by: 1)
    {
        var maxProfitThusFar = Int.min
        
        for day in stride(from: 1, to: prices.count, by: 1)
        {
            maxProfitThusFar = max(maxProfitThusFar, profits[transaction - 1][day - 1] - prices[day - 1])
            profits[transaction][day] = max(profits[transaction][day - 1], maxProfitThusFar + prices[day])
        }
    }
    
    return profits[k][prices.count - 1]
}

//Solution #2
//O(nk) time | O(n) space
func maxProfitWithKTransactionsSecondSolution(_ prices: [Int], _ k: Int) -> Int
{
    if prices.count == 0
    {
        return 0
    }
    
    //Initialize the last two rows of the matrix from the previous solution
    var evenProfits = Array(repeating: 0, count: prices.count)
    var oddProfits = Array(repeating: 0, count: prices.count)
    
    //Start at the first transaction and go through the last\
    for transaction in stride(from: 1, through: k, by: 1)
    {
        var maxProfitThusFar = Int.min
        
        if transaction % 2 == 0
        {
            secondSolutionHelper(&evenProfits, &oddProfits, &maxProfitThusFar, prices)
        }
        else
        {
            secondSolutionHelper(&oddProfits, &evenProfits, &maxProfitThusFar, prices)
        }
    }
    
    if k % 2 == 0
    {
        return evenProfits[prices.count - 1]
    }
    else
    {
        return oddProfits[prices.count - 1]
    }
}

func secondSolutionHelper(_ currentProfits: inout [Int], _ previousProfits: inout [Int], _ maxProfitThusFar: inout Int, _ prices: [Int])
{
    for day in stride(from: 1, to: prices.count, by: 1)
    {
        maxProfitThusFar = max(maxProfitThusFar, previousProfits[day - 1] - prices[day - 1])
        currentProfits[day] = max(currentProfits[day - 1], maxProfitThusFar + prices[day])
    }
}

//Tests
assert(maxProfitWithKTransactionsFirstSolution([], 1) == 0)
assert(maxProfitWithKTransactionsSecondSolution([], 1) == 0)

assert(maxProfitWithKTransactionsFirstSolution([1], 1) == 0)
assert(maxProfitWithKTransactionsSecondSolution([1], 1) == 0)

assert(maxProfitWithKTransactionsFirstSolution([1, 10], 3) == 9)
assert(maxProfitWithKTransactionsSecondSolution([1, 10], 3) == 9)

assert(maxProfitWithKTransactionsFirstSolution([1, 10], 3) == 9)
assert(maxProfitWithKTransactionsSecondSolution([1, 10], 3) == 9)

assert(maxProfitWithKTransactionsFirstSolution([3, 2, 5, 7, 1, 3, 7], 1) == 6)
assert(maxProfitWithKTransactionsSecondSolution([3, 2, 5, 7, 1, 3, 7], 1) == 6)

assert(maxProfitWithKTransactionsFirstSolution([5, 11, 3, 50, 60, 90], 2) == 93)
assert(maxProfitWithKTransactionsSecondSolution([5, 11, 3, 50, 60, 90], 2) == 93)

assert(maxProfitWithKTransactionsFirstSolution([5, 11, 3, 50, 60, 90], 3) == 93)
assert(maxProfitWithKTransactionsSecondSolution([5, 11, 3, 50, 60, 90], 3) == 93)

assert(maxProfitWithKTransactionsFirstSolution([5, 11, 3, 50, 40, 90], 2) == 97)
assert(maxProfitWithKTransactionsSecondSolution([5, 11, 3, 50, 40, 90], 2) == 97)

assert(maxProfitWithKTransactionsFirstSolution([5, 11, 3, 50, 40, 90], 3) == 103)
assert(maxProfitWithKTransactionsSecondSolution([5, 11, 3, 50, 40, 90], 3) == 103)

assert(maxProfitWithKTransactionsFirstSolution([50, 25, 12, 4, 3, 10, 1, 100], 2) == 106)
assert(maxProfitWithKTransactionsSecondSolution([50, 25, 12, 4, 3, 10, 1, 100], 2) == 106)

assert(maxProfitWithKTransactionsFirstSolution([100, 99, 98, 97, 1], 5) == 0)
assert(maxProfitWithKTransactionsSecondSolution([100, 99, 98, 97, 1], 5) == 0)

assert(maxProfitWithKTransactionsFirstSolution([1, 100, 2, 200, 3, 300, 4, 400, 5, 500], 5) == 1485)
assert(maxProfitWithKTransactionsSecondSolution([1, 100, 2, 200, 3, 300, 4, 400, 5, 500], 5) == 1485)

assert(maxProfitWithKTransactionsFirstSolution([1, 100, 101, 200, 201, 300, 301, 400, 401, 500], 5) == 499)
assert(maxProfitWithKTransactionsSecondSolution([1, 100, 101, 200, 201, 300, 301, 400, 401, 500], 5) == 499)

assert(maxProfitWithKTransactionsFirstSolution([1, 25, 24, 23, 12, 36, 14, 40, 31, 41, 5], 4) == 84)
assert(maxProfitWithKTransactionsSecondSolution([1, 25, 24, 23, 12, 36, 14, 40, 31, 41, 5], 4) == 84)

assert(maxProfitWithKTransactionsFirstSolution([1, 25, 24, 23, 12, 36, 14, 40, 31, 41, 5], 2) == 62)
assert(maxProfitWithKTransactionsSecondSolution([1, 25, 24, 23, 12, 36, 14, 40, 31, 41, 5], 2) == 62)
