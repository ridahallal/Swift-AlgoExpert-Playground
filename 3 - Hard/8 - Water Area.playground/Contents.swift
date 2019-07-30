//Water Area
//O(n) time | O(n) space
func waterArea(heights: [Int]) -> Int
{
    var maxes = Array(repeating: 0, count: heights.count)
    var leftMax = 0
    
    for i in 0 ..< heights.count
    {
        let currentHeight = heights[i]
        
        maxes[i] = leftMax
        leftMax = max(leftMax, currentHeight)
    }
    
    var rightMax = 0
    
    for i in (0 ..< heights.count).reversed()
    {
        let currentHeight = heights[i]
        
        let minMax = min(rightMax, maxes[i])
        
        if currentHeight < minMax
        {
            maxes[i] = minMax - currentHeight
        }
        else
        {
            maxes[i] = 0
        }
        
        rightMax = max(rightMax, currentHeight)
    }
    
    return maxes.reduce(0,
    {
        x, y in
        
        x + y
    })
}

//Tests
assert(waterArea(heights: [0]) == 0)
assert(waterArea(heights: [0, 0, 0, 0, 0]) == 0)
assert(waterArea(heights: [0, 1, 0, 0, 0]) == 0)
assert(waterArea(heights: [0, 1, 1, 0, 0]) == 0)
assert(waterArea(heights: [0, 1, 2, 1, 1]) == 0)
assert(waterArea(heights: [0, 1, 0, 1, 0]) == 1)
assert(waterArea(heights: [0, 1, 0, 1, 0, 2, 0, 3]) == 4)
assert(waterArea(heights: [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3]) == 48)
assert(waterArea(heights: [0, 8, 0, 0, 10, 0, 0, 10, 0, 0, 1, 1, 0, 3]) == 49)
assert(waterArea(heights: [0, 100, 0, 0, 10, 1, 1, 10, 1, 0, 1, 1, 0, 100]) == 1075)
assert(waterArea(heights: [0, 100, 0, 0, 10, 1, 1, 10, 1, 0, 1, 1, 0, 0]) == 39)
