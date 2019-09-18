//Rectangle Mania

//Common
let UP = "up"
let DOWN = "down"
let LEFT = "left"
let RIGHT = "right"

func coordToString(_ coord: [Int]) -> String
{
    let x = coord[0]
    let y = coord[1]
    
    return "\(x)-\(y)"
}

//Solution #1
//O(n^2) time | O(n^2) space
func rectangleManiaFirstSolution(_ coords: [[Int]]) -> Int
{
    let coordsTable = getCoordsTableFirstSolution(coords)
    return getRectangleCountFirstSolution(coords, coordsTable)
}

func getCoordsTableFirstSolution(_ coords: [[Int]]) -> [String: [String: [[Int]]]]
{
    var coordsTable = [String: [String: [[Int]]]]()
    
    for coord1 in coords
    {
        var coord1Directions: [String: [[Int]]] = [UP: [], DOWN: [], LEFT: [], RIGHT: []]
        
        for coord2 in coords
        {
            let coord2Direction = getCoordDirection(coord1, coord2)
            
            if var coordinatesForDirection = coord1Directions[coord2Direction]
            {
                coordinatesForDirection.append(coord2)
                coord1Directions[coord2Direction] = coordinatesForDirection
            }
        }
        
        let coords1String = coordToString(coord1)
        coordsTable[coords1String] = coord1Directions
    }
    
    return coordsTable
}

func getCoordDirection(_ coord1: [Int], _ coord2: [Int]) -> String
{
    let x1 = coord1[0]
    let y1 = coord1[1]
    
    let x2 = coord2[0]
    let y2 = coord2[1]
    
    if y1 == y2
    {
        if x1 < x2
        {
            return RIGHT
        }
        else
        {
            return LEFT
        }
    }
    else if x1 == x2
    {
        if y1 < y2
        {
            return UP
        }
        else
        {
            return DOWN
        }
    }
    
    return ""
}

func getRectangleCountFirstSolution(_ coords: [[Int]], _ coordsTable: [String: [String: [[Int]]]]) -> Int
{
    var rectangleCount = 0
    
    for coord in coords
    {
        rectangleCount += clockwiseCountRectanglesFirstSolution(coord, coordsTable, UP, coord)
    }
    
    return rectangleCount
}

func clockwiseCountRectanglesFirstSolution(_ coord: [Int], _ coordsTable: [String: [String: [[Int]]]], _ direction: String, _ origin: [Int]) -> Int
{
    let coordString = coordToString(coord)
    
    if direction == LEFT
    {
        if let directionsForCoordinate = coordsTable[coordString], let coordinatesForDirection = directionsForCoordinate[direction], coordinatesForDirection.contains(origin)
        {
            return 1
        }
        else
        {
            return 0
        }
    }
    else
    {
        var rectangleCount = 0
        let nextDirection = getNextClockwiseDirection(direction)
        
        if let directionsForCoordinate = coordsTable[coordString], let coordinatesForDirection = directionsForCoordinate[direction]
        {
            for nextCoord in coordinatesForDirection
            {
                rectangleCount += clockwiseCountRectanglesFirstSolution(nextCoord, coordsTable, nextDirection, origin)
            }
        }
        
        return rectangleCount
    }
}

func getNextClockwiseDirection(_ direction: String) -> String
{
    if direction == UP
    {
        return RIGHT
    }
    
    if direction == RIGHT
    {
        return DOWN
    }
    
    if direction == DOWN
    {
        return LEFT
    }
    
    return ""
}

//Solution #2
//O(n^2) time | O(n) space
func rectangleManiaSecondSolution(_ coords: [[Int]]) -> Int
{
    let coordsTable = getCoordsTableSecondSolution(coords)
    return getRectangleCountSecondSolution(coords, coordsTable)
}

func getCoordsTableSecondSolution(_ coords: [[Int]]) -> [String: [Int: [[Int]]]]
{
    var coordsTable: [String: [Int: [[Int]]]] = ["x": [:], "y": [:]]

    for coord in coords
    {
        let x = coord[0]
        let y = coord[1]
        
        if var tableAtX = coordsTable["x"], var coordinatesForX = tableAtX[x]
        {
            coordinatesForX.append(coord)
            tableAtX[x] = coordinatesForX
            coordsTable["x"] = tableAtX
        }
        else if var tableAtX = coordsTable["x"]
        {
            tableAtX[x] = [coord]
            coordsTable["x"] = tableAtX
        }
        
        if var tableAtY = coordsTable["y"], var coordinatesForY = tableAtY[y]
        {
            coordinatesForY.append(coord)
            tableAtY[y] = coordinatesForY
            coordsTable["y"] = tableAtY
        }
        else if var tableAtY = coordsTable["y"]
        {
            tableAtY[y] = [coord]
            coordsTable["y"] = tableAtY
        }
    }

    return coordsTable
}

func getRectangleCountSecondSolution(_ coords: [[Int]], _ coordsTable: [String: [Int: [[Int]]]]) -> Int
{
    var rectangleCount = 0
    
    for coord in coords
    {
        let lowerLeftY = coord[1]
        rectangleCount += clockwiseCountRectanglesSecondSolution(coord, coordsTable, UP, lowerLeftY)
    }
    
    return rectangleCount
}

func clockwiseCountRectanglesSecondSolution(_ coord: [Int], _ coordsTable: [String: [Int: [[Int]]]], _ direction: String, _ lowerLeftY: Int) -> Int
{
    let x1 = coord[0]
    let y1 = coord[1]
    
    if direction == DOWN
    {
        if let tableAtX = coordsTable["x"], let relevantCoordinates = tableAtX[x1]
        {
            for coord2 in relevantCoordinates
            {
                let lowerRightY = coord2[1]
                if lowerLeftY == lowerRightY
                {
                    return 1
                }
            }
        }
        
        return 0
    }
    else
    {
        var rectangleCount = 0
        
        if direction == UP
        {
            if let tableAtX = coordsTable["x"], let relevantCoordinates = tableAtX[x1]
            {
                for coord2 in relevantCoordinates
                {
                    let y2 = coord2[1]
                    
                    let isAbove = y2 > y1
                    
                    if isAbove
                    {
                        rectangleCount += clockwiseCountRectanglesSecondSolution(coord2, coordsTable, RIGHT, lowerLeftY)
                    }
                }
            }
        }
        else if direction == RIGHT
        {
            if let tableAtY = coordsTable["y"], let relevantCoordinates = tableAtY[y1]
            {
                for coord2 in relevantCoordinates
                {
                    let x2 = coord2[0]
                    
                    let isRight = x2 > x1
                    
                    if isRight
                    {
                        rectangleCount += clockwiseCountRectanglesSecondSolution(coord2, coordsTable, DOWN, lowerLeftY)
                    }
                }
            }
        }
        
        return rectangleCount
    }
}

//Solution #3
//O(n^2) time | O(n) space
func rectangleManiaThirdSolution(_ coords: [[Int]]) -> Int
{
    let coordsTable = getCoordsTableThirdSolution(coords)
    return getRectangleCountThirdSolution(coords, coordsTable)
}

func getCoordsTableThirdSolution(_ coords: [[Int]]) -> [String: Bool]
{
    var coordsTable = [String: Bool]()
    
    for coord in coords
    {
        let coordString = coordToString(coord)
        coordsTable[coordString] = true
    }
    
    return coordsTable
}

func getRectangleCountThirdSolution(_ coords: [[Int]], _ coordsTable: [String: Bool]) -> Int
{
    var rectangleCount = 0
    
    for coord1 in coords
    {
        let x1 = coord1[0]
        let y1 = coord1[1]
        
        for coord2 in coords
        {
            let x2 = coord2[0]
            let y2 = coord2[1]
            
            if !isInUpperRightCorner(coord1, coord2)
            {
                continue
            }
            
            let leftCoordString = coordToString([x1, y2])
            let bottomCoordString = coordToString([x2, y1])
            
            if coordsTable.keys.contains(leftCoordString) && coordsTable.keys.contains(bottomCoordString)
            {
                rectangleCount += 1
            }
        }
    }
    
    return rectangleCount
}

func isInUpperRightCorner(_ coord1: [Int], _ coord2: [Int]) -> Bool
{
    let x1 = coord1[0]
    let y1 = coord1[1]
    
    let x2 = coord2[0]
    let y2 = coord2[1]
    
    return x2 > x1 && y2 > y1
}

//Tests
let firstCoords = [[0, 0], [0, 1], [1, 1], [1, 0]]
assert(rectangleManiaFirstSolution(firstCoords) == 1)
assert(rectangleManiaSecondSolution(firstCoords) == 1)
assert(rectangleManiaThirdSolution(firstCoords) == 1)

let secondCoords = [[0, 0], [0, 1], [1, 1], [1, 0], [2, 1], [2, 0]]
assert(rectangleManiaFirstSolution(secondCoords) == 3)
assert(rectangleManiaSecondSolution(secondCoords) == 3)
assert(rectangleManiaThirdSolution(secondCoords) == 3)

let thirdCoords = [[0, 0], [0, 1], [1, 1], [1, 0], [2, 1], [2, 0], [3, 1], [3, 0]]
assert(rectangleManiaFirstSolution(thirdCoords) == 6)
assert(rectangleManiaSecondSolution(thirdCoords) == 6)
assert(rectangleManiaThirdSolution(thirdCoords) == 6)

let fourthCoords = [[0, 0], [0, 1], [1, 1], [1, 0], [2, 1], [2, 0], [3, 1], [3, 0], [1, 3], [3, 3]]
assert(rectangleManiaFirstSolution(fourthCoords) == 8)
assert(rectangleManiaSecondSolution(fourthCoords) == 8)
assert(rectangleManiaThirdSolution(fourthCoords) == 8)

let fifthCoords = [[0, 0], [0, 1], [1, 1], [1, 0], [2, 1], [2, 0], [3, 1], [3, 0], [1, 3], [3, 3], [0, -4], [3, -4]]
assert(rectangleManiaFirstSolution(fifthCoords) == 10)
assert(rectangleManiaSecondSolution(fifthCoords) == 10)
assert(rectangleManiaThirdSolution(fifthCoords) == 10)

let sixthCoords = [[0, 0], [0, 1], [1, 1], [1, 0], [2, 1], [2, 0], [3, 1], [3, 0], [1, 3], [3, 3], [0, -4], [3, -4], [1, -3], [3, -3]]
assert(rectangleManiaFirstSolution(sixthCoords) == 13)
assert(rectangleManiaSecondSolution(sixthCoords) == 13)
assert(rectangleManiaThirdSolution(sixthCoords) == 13)

let seventhCoords = [[0, 0], [0, 1], [1, 1], [1, 0], [2, 1], [2, 0], [3, 1], [3, 0], [1, 3], [3, 3], [0, -4], [3, -4], [1, -3], [3, -3], [-1, 0], [-10, 0], [-1, -1], [2, -2]]
assert(rectangleManiaFirstSolution(seventhCoords) == 13)
assert(rectangleManiaSecondSolution(seventhCoords) == 13)
assert(rectangleManiaThirdSolution(seventhCoords) == 13)

let eighthCoords = [[0, 0], [0, 1], [1, 1], [1, 0], [2, 1], [2, 0], [3, 1], [3, 0], [1, 3], [3, 3], [0, -4], [3, -4], [1, -3], [3, -3], [-1, 0], [-10, 0], [-1, -1], [2, -2], [0, -1], [1, -4], [-10, -4]]
assert(rectangleManiaFirstSolution(eighthCoords) == 23)
assert(rectangleManiaSecondSolution(eighthCoords) == 23)
assert(rectangleManiaThirdSolution(eighthCoords) == 23)

let ninthCoords = [[0, 0], [0, 1], [1, 0], [2, 1], [1, 3], [3, 3], [0, -4], [3, -5], [1, -3], [3, -2], [-1, 0], [-10, 0], [-1, -1], [2, -2]]
assert(rectangleManiaFirstSolution(ninthCoords) == 0)
assert(rectangleManiaSecondSolution(ninthCoords) == 0)
assert(rectangleManiaThirdSolution(ninthCoords) == 0)

let tenthCoords = [[0, 0], [0, 1], [1, 1]]
assert(rectangleManiaFirstSolution(tenthCoords) == 0)
assert(rectangleManiaSecondSolution(tenthCoords) == 0)
assert(rectangleManiaThirdSolution(tenthCoords) == 0)
