//Zigzag Traverse
//O(n) time | O(n) space
func zigZagTraverse(array: [[Int]]) -> [Int]
{
    var result = [Int]()
    
    var goingDown = true
    var currentRow = 0
    var currentColumn = 0
    
    while currentRow < array.count && currentColumn < array[0].count
    {
        result.append(array[currentRow][currentColumn])
        
        //If we're going down
        if goingDown
        {
            //And we're at the left edge or the bottom edge
            if currentColumn == 0 || currentRow == array.count - 1
            {
                goingDown = false
                
                //If we're at the bottom edge
                if currentRow == array.count - 1
                {
                    //Move to the right
                    currentColumn += 1
                }
                //If we're at the left edge
                else
                {
                    //Move one row downwards
                    currentRow += 1
                }
            }
            else
            {
                //Move diagonally downwards
                currentRow += 1
                currentColumn -= 1
            }
        }
        //If we're going upwards
        else
        {
            //If we're at the top edge or the right edge
            if currentRow == 0 || currentColumn == array[0].count - 1
            {
                goingDown = true
                
                //If we're at the right edge
                if currentColumn == array[0].count - 1
                {
                    //Move one row downwards
                    currentRow += 1
                }
                else
                {
                    //Move to the right
                    currentColumn += 1
                }
            }
            else
            {
                //Move diagonally upwards
                currentRow -= 1
                currentColumn += 1
            }
        }
    }
    
    return result
}

let firstTest = [[1]]
assert(zigZagTraverse(array: firstTest) == [1])

let secondTest = [[1, 2, 3, 4, 5]]
assert(zigZagTraverse(array: secondTest) == [1, 2, 3, 4, 5])

let thirdTest = [[1], [2], [3], [4], [5]]
assert(zigZagTraverse(array: thirdTest) == [1, 2, 3, 4, 5])

let fourthTest = [
    [1, 3],
    [2, 4],
    [5, 7],
    [6, 8],
    [9, 10],
]
assert(zigZagTraverse(array: fourthTest) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

let fifthTest = [
    [1, 3, 4, 7, 8],
    [2, 5, 6, 9, 10],
]
assert(zigZagTraverse(array: fifthTest) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

let sixthTest = [
    [1, 3, 4, 10],
    [2, 5, 9, 11],
    [6, 8, 12, 15],
    [7, 13, 14, 16],
]
assert(zigZagTraverse(array: sixthTest) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])

let seventhTest = [
    [1, 3, 4, 10, 11],
    [2, 5, 9, 12, 19],
    [6, 8, 13, 18, 20],
    [7, 14, 17, 21, 24],
    [15, 16, 22, 23, 25],
]
assert(zigZagTraverse(array: seventhTest) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25])

let eighthTest = [
    [1, 3, 4, 10, 11, 20],
    [2, 5, 9, 12, 19, 21],
    [6, 8, 13, 18, 22, 27],
    [7, 14, 17, 23, 26, 28],
    [15, 16, 24, 25, 29, 30],
]
assert(zigZagTraverse(array: eighthTest) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30])

let ninthTest = [
    [1, 3, 4, 10, 11],
    [2, 5, 9, 12, 20],
    [6, 8, 13, 19, 21],
    [7, 14, 18, 22, 27],
    [15, 17, 23, 26, 28],
    [16, 24, 25, 29, 30],
]
assert(zigZagTraverse(array: ninthTest) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30])
