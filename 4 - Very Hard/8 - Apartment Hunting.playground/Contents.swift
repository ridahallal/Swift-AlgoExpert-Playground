//Apartment Hunting
//Solution #1
//O(b^2 * r) time | O(b) space
func apartmentHuntingFirstSolution(_ blocks: [[String: Bool]], _ requirements: [String]) -> Int
{
    //Array that will contain the max distance for each block
    var maxDistancesAtBlocks = Array(repeating: -Int.max, count: blocks.count)
    
    //For each block
    for i in 0 ..< blocks.count
    {
        //For each requirement
        for requirement in requirements
        {
            //Closest requirement distance
            var closestReqDistance = Int.max
            
            //For each block again
            for j in 0 ..< blocks.count
            {
                //Update closest requirement if block contains it
                if let requirementAvailable = blocks[j][requirement], requirementAvailable
                {
                    closestReqDistance = min(closestReqDistance, distanceBetween(i, j))
                }
            }
            
            //Update our max distances array
            maxDistancesAtBlocks[i] = max(maxDistancesAtBlocks[i], closestReqDistance)
        }
    }
    
    return getIndexAtMinValue(maxDistancesAtBlocks)
}

//Solution #2
func apartmentHuntingSecondSolution(_ blocks: [[String: Bool]], _ requirements: [String]) -> Int
{
    let minDistancesFromBlocks = requirements.map { getMinDistances(blocks, $0) }
    let maxDistancesAtBlocks = getMaxDistancesAtBlocks(blocks, minDistancesFromBlocks)
    
    return getIndexAtMinValue(maxDistancesAtBlocks)
}

func getMinDistances(_ blocks: [[String: Bool]], _ requirement: String) -> [Int]
{
    var minDistances = Array(repeating: -1, count: blocks.count)
    var closestRequirementIndex = Int.max
    
    for i in 0 ..< blocks.count
    {
        if let requirementAvailable = blocks[i][requirement], requirementAvailable
        {
            closestRequirementIndex = i
        }
        
        minDistances[i] = distanceBetween(i, closestRequirementIndex)
    }
    
    for i in (0 ..< blocks.count).reversed()
    {
        if let requirementAvailable = blocks[i][requirement], requirementAvailable
        {
            closestRequirementIndex = i
        }
        
        minDistances[i] = min(minDistances[i], distanceBetween(i, closestRequirementIndex))
    }
    
    return minDistances
}

func getMaxDistancesAtBlocks(_ blocks: [[String: Bool]], _ minDistancesFromBlocks: [[Int]]) -> [Int]
{
    var maxDistancesAtBlocks = Array(repeating: -1, count: blocks.count)
    
    for i in 0 ..< blocks.count
    {
        let minDistancesAtBlock = minDistancesFromBlocks.map { $0[i] }
        
        if let max = minDistancesAtBlock.max()
        {
            maxDistancesAtBlocks[i] = max
        }
    }
    
    return maxDistancesAtBlocks
}

//Common Functions
func getIndexAtMinValue(_ array: [Int]) -> Int
{
    var indexAtMinValue = 0
    var minValue = Int.max
    
    for i in 0 ..< array.count
    {
        let currentValue = array[i]
        
        if currentValue < minValue
        {
            minValue = currentValue
            indexAtMinValue = i
        }
    }
    
    return indexAtMinValue
}

func distanceBetween(_ a: Int, _ b: Int) -> Int
{
    return abs(a - b)
}

//Tests
let firstRequirements = ["gym", "school", "store"]
let firstBlocks = [
    [
        "gym": false,
        "school": true,
        "store": false
    ],
    [
        "gym": true,
        "school": false,
        "store": false
    ],
    [
        "gym": true,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "school": true,
        "store": true
    ]
]

assert(apartmentHuntingFirstSolution(firstBlocks, firstRequirements) == 3)
assert(apartmentHuntingSecondSolution(firstBlocks, firstRequirements) == 3)

let secondRequirements = ["gym", "office", "school", "store"]
let secondBlocks = [
    [
        "gym": false,
        "office": true,
        "school": true,
        "store": false
    ],
    [
        "gym": true,
        "office": false,
        "school": false,
        "store": false
    ],
    [
        "gym": true,
        "office": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "school": true,
        "store": true
    ]
]

assert(apartmentHuntingFirstSolution(secondBlocks, secondRequirements) == 2)
assert(apartmentHuntingSecondSolution(secondBlocks, secondRequirements) == 2)

let thirdRequirements = ["gym", "office", "school", "store"]
let thirdBlocks = [
    [
        "gym": false,
        "office": true,
        "school": true,
        "store": false
    ],
    [
        "gym": true,
        "office": false,
        "school": false,
        "store": false
    ],
    [
        "gym": true,
        "office": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "school": true,
        "store": true
    ]
]

assert(apartmentHuntingFirstSolution(thirdBlocks, thirdRequirements) == 2)
assert(apartmentHuntingSecondSolution(thirdBlocks, thirdRequirements) == 2)

let fourthRequirements = ["gym", "school", "store"]
let fourthBlocks = [
    [
        "foo": true,
        "gym": false,
        "kappa": false,
        "office": true,
        "school": true,
        "store": false
    ],
    [
        "foo": true,
        "gym": true,
        "kappa": false,
        "office": false,
        "school": false,
        "store": false
    ],
    [
        "foo": true,
        "gym": true,
        "kappa": false,
        "office": false,
        "school": true,
        "store": false
    ],
    [
        "foo": true,
        "gym": false,
        "kappa": false,
        "office": false,
        "school": true,
        "store": false
    ],
    [
        "foo": true,
        "gym": true,
        "kappa": false,
        "office": false,
        "school": true,
        "store": false
    ],
    [
        "foo": true,
        "gym": false,
        "kappa": false,
        "office": false,
        "school": true,
        "store": true
    ]
]

assert(apartmentHuntingFirstSolution(fourthBlocks, fourthRequirements) == 4)
assert(apartmentHuntingSecondSolution(fourthBlocks, fourthRequirements) == 4)

let fifthRequirements = ["gym", "school", "store"]
let fifthBlocks = [
    [
        "gym": true,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "school": false,
        "store": true
    ],
    [
        "gym": true,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "school": true,
        "store": false
    ]
]

assert(apartmentHuntingFirstSolution(fifthBlocks, fifthRequirements) == 2)
assert(apartmentHuntingSecondSolution(fifthBlocks, fifthRequirements) == 2)

let sixthRequirements = ["gym", "pool", "school", "store"]
let sixthBlocks = [
    [
        "gym": true,
        "pool": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "pool": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "pool": false,
        "school": false,
        "store": true
    ],
    [
        "gym": true,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "pool": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "pool": true,
        "school": false,
        "store": false
    ]
]

assert(apartmentHuntingFirstSolution(sixthBlocks, sixthRequirements) == 7)
assert(apartmentHuntingSecondSolution(sixthBlocks, sixthRequirements) == 7)

let seventhRequirements = ["gym", "pool", "school", "store"]
let seventhBlocks = [
    [
        "gym": true,
        "office": false,
        "pool": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "office": true,
        "pool": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "office": true,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "pool": false,
        "school": false,
        "store": true
    ],
    [
        "gym": true,
        "office": true,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "pool": true,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "pool": false,
        "school": false,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "pool": false,
        "school": true,
        "store": false
    ],
    [
        "gym": false,
        "office": false,
        "pool": true,
        "school": false,
        "store": false
    ]
]

assert(apartmentHuntingFirstSolution(seventhBlocks, seventhRequirements) == 4)
assert(apartmentHuntingSecondSolution(seventhBlocks, seventhRequirements) == 4)
