//Disk Stacking
//O(n^2) time | O(1) space
func diskStacking(disks: inout [[Int]]) -> [[Int]]
{
    disks.sort(by: {$0[2] < $1[2]})
    
    var heights = disks.map({$0[2]})
    var previousIndices = Array(repeating: -1, count: disks.count)
    var maximumHeightIndex = 0
    
    for i in 1 ..< disks.count
    {
        let currentDisk = disks[i]
        
        for j in 0 ..< i
        {
            let previousDisk = disks[j]
            
            if areValidDimensions(previousDisk, currentDisk)
            {
                if heights[i] <= heights[j] + currentDisk[2]
                {
                    heights[i] = heights[j] + currentDisk[2]
                    previousIndices[i] = j
                }
            }
        }
        
        if heights[i] >= heights[maximumHeightIndex]
        {
            maximumHeightIndex = i
        }
    }
    
    return buildSequence(disks, previousIndices, &maximumHeightIndex)
}

func areValidDimensions(_ previousDisk: [Int], _ currentDisk: [Int]) -> Bool
{
    return previousDisk[0] < currentDisk[0] && previousDisk[1] < currentDisk[1] && previousDisk[2] < currentDisk[2]
}

func buildSequence(_ disks: [[Int]], _ previousIndices: [Int], _ currentIndex: inout Int) -> [[Int]]
{
    var sequence = [[Int]]()
    
    while currentIndex != -1
    {
        sequence.insert(disks[currentIndex], at: 0)
        currentIndex = previousIndices[currentIndex]
    }
    
    return sequence
}

//Tests
var firstTest = [[2, 1, 2]]
let firstExpectedResults = [[2, 1, 2]]
assert(diskStacking(disks: &firstTest) == firstExpectedResults)

var secondTest = [[2, 1, 2], [3, 2, 3]]
let secondExpectedResults = [[2, 1, 2], [3, 2, 3]]
assert(diskStacking(disks: &secondTest) == secondExpectedResults)

var thirdTest = [[2, 1, 2], [3, 2, 3], [2, 2, 8]]
let thirdExpectedResults = [[2, 2, 8]]
assert(diskStacking(disks: &thirdTest) == thirdExpectedResults)

var fourthTest = [[2, 1, 2], [3, 2, 3], [2, 3, 4]]
let fourthExpectedResults = [[2, 1, 2], [3, 2, 3]]
assert(diskStacking(disks: &fourthTest) == fourthExpectedResults)

var fifthTest = [[2, 1, 2], [3, 2, 3], [2, 2, 8], [2, 3, 4], [2, 2, 1], [4, 4, 5]]
let fifthExpectedResults = [[2, 1, 2], [3, 2, 3], [4, 4, 5]]
assert(diskStacking(disks: &fifthTest) == fifthExpectedResults)

var sixthTest = [[2, 1, 2], [3, 2, 5], [2, 2, 8], [2, 3, 4], [2, 2, 1], [4, 4, 5]]
let sixthExpectedResults = [[2, 3, 4], [4, 4, 5]]
assert(diskStacking(disks: &sixthTest) == sixthExpectedResults)

var seventhTest = [[2, 1, 2], [3, 2, 3], [2, 2, 8], [2, 3, 4], [1, 2, 1], [4, 4, 5], [1, 1, 4]]
let seventhExpectedResults = [[1, 1, 4], [2, 2, 8]]
assert(diskStacking(disks: &seventhTest) == seventhExpectedResults)

var eighthTest = [[3, 3, 4], [2, 1, 2], [3, 2, 3], [2, 2, 8], [2, 3, 4], [5, 5, 6], [1, 2, 1], [4, 4, 5], [1, 1, 4], [2, 2, 3]]
let eighthExpectedResults = [[2, 2, 3], [3, 3, 4], [4, 4, 5], [5, 5, 6]]
assert(diskStacking(disks: &eighthTest) == eighthExpectedResults)
