//Find Three Largest Numbers
func findThreeLargestNumbers(array: [Int]) -> [Int]
{
    var threeLargest: [Int?] = [nil, nil, nil]
    
    for number in array
    {
        updateLargest(&threeLargest, number)
    }
    
    //Remove nils and return results
    let threeLargestWithoutOptionals = threeLargest.compactMap( {$0} )
    return threeLargestWithoutOptionals
}

func updateLargest(_ threeLargest: inout [Int?], _ number: Int)
{
    if threeLargest[2] == nil
    {
        shiftAndupdate(&threeLargest, number, 2)
    }
    else if threeLargest[1] == nil
    {
        shiftAndupdate(&threeLargest, number, 1)
    }
    else if threeLargest[0] == nil
    {
        shiftAndupdate(&threeLargest, number, 0)
    }
    
    if let thirdNumber = threeLargest[2], number > thirdNumber
    {
        shiftAndupdate(&threeLargest, number, 2)
    }
    else if let secondNumber = threeLargest[1], number > secondNumber
    {
        shiftAndupdate(&threeLargest, number, 1)
    }
    else if let firstNumber = threeLargest[0], number > firstNumber
    {
        shiftAndupdate(&threeLargest, number, 0)
    }
}

func shiftAndupdate(_ threeLargest: inout [Int?], _ number: Int, _ index: Int)
{
    for i in 0...index
    {
        if i == index
        {
            threeLargest[i] = number
        }
        else
        {
            threeLargest[i] = threeLargest[i + 1]
        }
    }
}

//Tests
assert(findThreeLargestNumbers(array: [55, 7, 8]) == [7, 8, 55])
assert(findThreeLargestNumbers(array: [55, 43, 11, 3, -3, 10]) == [11, 43, 55])
assert(findThreeLargestNumbers(array: [7, 8, 3, 11, 43, 55]) == [11, 43, 55])
assert(findThreeLargestNumbers(array: [55, 7, 8, 3, 43, 11]) == [11, 43, 55])
assert(findThreeLargestNumbers(array: [7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7]) == [7, 7, 7])
assert(findThreeLargestNumbers(array: [141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7]) == [18, 141, 541])
assert(findThreeLargestNumbers(array: [-1, -2, -3, -7, -17, -27, -18, -541, -8, -7, 7]) == [-2, -1, 7])
