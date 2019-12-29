//Search In Sorted Matrix
func searchInSortedMatrix(matrix: [[Int]], target: Int) -> [Int]
{
    var row = 0
    var column = matrix[0].count - 1
    
    while row < matrix.count && column >= 0
    {
        if matrix[row][column] > target
        {
            column = column - 1
        }
        else if matrix[row][column] < target
        {
            row = row + 1
        }
        else
        {
            return [row, column]
        }
    }
    
    return [-1, -1]
}

//Tests
var matrix =
[
    [1, 4, 7, 12, 15, 1000],
    [2, 5, 19, 31, 32, 1001],
    [3, 8, 24, 33, 35, 1002],
    [40, 41, 42, 44, 45, 1003],
    [99, 100, 103, 106, 128, 1004],
]

assert(searchInSortedMatrix(matrix: matrix, target: 1) == [0, 0])
assert(searchInSortedMatrix(matrix: matrix, target: 2) == [1, 0])
assert(searchInSortedMatrix(matrix: matrix, target: 4) == [0, 1])
assert(searchInSortedMatrix(matrix: matrix, target: 15) == [0, 4])
assert(searchInSortedMatrix(matrix: matrix, target: 12) == [0, 3])
assert(searchInSortedMatrix(matrix: matrix, target: 32) == [1, 4])
assert(searchInSortedMatrix(matrix: matrix, target: 99) == [4, 0])
assert(searchInSortedMatrix(matrix: matrix, target: 100) == [4, 1])
assert(searchInSortedMatrix(matrix: matrix, target: 40) == [3, 0])
assert(searchInSortedMatrix(matrix: matrix, target: 128) == [4, 4])
assert(searchInSortedMatrix(matrix: matrix, target: 106) == [4, 3])
assert(searchInSortedMatrix(matrix: matrix, target: 45) == [3, 4])
assert(searchInSortedMatrix(matrix: matrix, target: 24) == [2, 2])
assert(searchInSortedMatrix(matrix: matrix, target: 44) == [3, 3])
assert(searchInSortedMatrix(matrix: matrix, target: 43) == [-1, -1])
assert(searchInSortedMatrix(matrix: matrix, target: -1) == [-1, -1])
assert(searchInSortedMatrix(matrix: matrix, target: 1000) == [0, 5])
assert(searchInSortedMatrix(matrix: matrix, target: 1004) == [4, 5])
