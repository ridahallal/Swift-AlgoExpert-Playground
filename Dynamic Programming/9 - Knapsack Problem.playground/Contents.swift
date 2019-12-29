//Knapsack Problem
//O(nc) time | O(nc) space
func knapsackProblem(_ items: [[Int]], _ capacity: Int) -> (Int, [Int])
{
    var knapsackValues = [[Int]]()
    
    for _ in 0 ..< items.count + 1
    {
        let row = Array(repeating: 0, count: capacity + 1)
        knapsackValues.append(row)
    }
    
    for currentItemIndex in 1 ..< items.count + 1
    {
        let currentValue = items[currentItemIndex - 1][0]
        let currentWeight = items[currentItemIndex - 1][1]
        
        for currentCapacity in 0 ..< capacity + 1
        {
            //If we can fit the item in our current bag
            if currentWeight <= currentCapacity
            {
                knapsackValues[currentItemIndex][currentCapacity] = max(knapsackValues[currentItemIndex - 1][currentCapacity], knapsackValues[currentItemIndex - 1][currentCapacity - currentWeight] + currentValue)
            }
            //Otherwise
            else
            {
                knapsackValues[currentItemIndex][currentCapacity] = knapsackValues[currentItemIndex - 1][currentCapacity]
            }
        }
    }
    
    return (knapsackValues[items.count][capacity], getKnapsackItems(items, knapsackValues))
}

func getKnapsackItems(_ items: [[Int]], _ knapsackValues: [[Int]]) -> [Int]
{
    var sequence = [Int]()
    
    var currentItemIndex = knapsackValues.count - 1
    var currentCapacity = knapsackValues[0].count - 1
    
    while currentItemIndex > 0
    {
        if knapsackValues[currentItemIndex][currentCapacity] == knapsackValues[currentItemIndex - 1][currentCapacity]
        {
            currentItemIndex -= 1
        }
        else
        {
            sequence.insert(currentItemIndex - 1, at: 0)
            
            currentCapacity -= items[currentItemIndex - 1][1]
            currentItemIndex -= 1
        }
        
        if currentCapacity == 0
        {
            break
        }
    }
    
    return sequence
}

//Tests
assert(knapsackProblem([[1, 2], [4, 3], [5, 6], [6, 7]], 10) == (10, [1, 3]))
assert(knapsackProblem([[465, 100], [400, 85], [255, 55], [350, 45], [650, 130], [1000, 190], [455, 100], [100, 25], [1200, 190], [320, 65], [750, 100], [50, 45], [550, 65], [100, 50], [600, 70], [240, 40]], 200) == (1500, [3, 12, 14]))
assert(knapsackProblem([[465, 100], [400, 85], [255, 55], [350, 45], [650, 130], [1000, 190], [455, 100], [100, 25], [1200, 190], [320, 65], [750, 100], [50, 45], [550, 65], [100, 50], [600, 70], [255, 40]], 200) == (1505, [7, 12, 14, 15]))
assert(knapsackProblem([[2, 1], [70, 70], [30, 30], [69, 69], [100, 100]], 100) == (101, [0, 2, 3]))
assert(knapsackProblem([[1, 2], [70, 70], [30, 30], [69, 69], [100, 100]], 100) == (100, [1, 2]))
assert(knapsackProblem([[2, 1], [70, 70], [30, 30], [69, 69], [100, 100]], 0) == (0, []))
