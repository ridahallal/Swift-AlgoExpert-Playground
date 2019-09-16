//Apartment Hunting
//Solution #1
//O(b^2 * r) time | O(b) space
func apartmentHunting(_ blocks: [[String: Bool]], _ requirements: [String]) -> Int
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

assert(apartmentHunting(firstBlocks, firstRequirements) == 3)

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

assert(apartmentHunting(secondBlocks, secondRequirements) == 2)

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

assert(apartmentHunting(thirdBlocks, thirdRequirements) == 2)

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

assert(apartmentHunting(fourthBlocks, fourthRequirements) == 4)

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

assert(apartmentHunting(fifthBlocks, fifthRequirements) == 2)

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

assert(apartmentHunting(sixthBlocks, sixthRequirements) == 7)

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

assert(apartmentHunting(seventhBlocks, seventhRequirements) == 7)
