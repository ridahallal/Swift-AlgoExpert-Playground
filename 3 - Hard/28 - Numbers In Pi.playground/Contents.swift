//Number In Pi
//O(n^3 + m) time | O(n + m) space
func numbersInPiFirstSolution(_ pi: String, _ favoriteNumbers: [String]) -> Int
{
    //Create a numbers dictionary to easily figure out if a number is in our favorite numbers
    var numbersDictionary = [String: Bool]()
    
    //For each number in our favorite numbers
    for number in favoriteNumbers
    {
        //Set its dictionary value to true
        numbersDictionary[number] = true
    }
    
    //This cache will store the results of calling getMinimumNumberOfSpaces at a specific index in our string
    var cache = [Int: Int]()
    
    //Minimum number of spaces starting at index 0, for the whole given pi
    let minimumNumberOfSpaces = getMinimumNumberOfSpaces(pi, numbersDictionary, &cache, 0)
    
    if minimumNumberOfSpaces == Int(Int32.max)
    {
        return -1
    }
    else
    {
        return minimumNumberOfSpaces
    }
}

//O(n^3 + m) time | O(n + m) space
func numbersInPiSecondSolution(_ pi: String, _ favoriteNumbers: [String]) -> Int
{
    //Create a numbers dictionary to easily figure out if a number is in our favorite numbers
    var numbersDictionary = [String: Bool]()
    
    //For each number in our favorite numbers
    for number in favoriteNumbers
    {
        //Set its dictionary value to true
        numbersDictionary[number] = true
    }
    
    //This cache will store the results of calling getMinimumNumberOfSpaces at a specific index in our string
    var cache = [Int: Int]()
    
    for i in stride(from: pi.count - 1, through: 0, by: -1)
    {
        getMinimumNumberOfSpaces(pi, numbersDictionary, &cache, i)
    }
    
    if cache[0] == Int(Int32.max)
    {
        return -1
    }
    else
    {
        return cache[0]!
    }
}

func getMinimumNumberOfSpaces(_ pi: String, _ numbersDictionary: [String: Bool], _ cache: inout [Int: Int], _ index: Int) -> Int
{
    //If we've reached the last index of the string, this means we can't add spaces
    if index == pi.count
    {
        return -1
    }
    
    //If we've already calculated the minimum number of spaces at this index, return it
    if let minimumNumberOfSpaces = cache[index]
    {
        return minimumNumberOfSpaces
    }
    
    //Initialize the minimum number of spaces to the maximum int value
    var minimumNumberOfSpaces = Int(Int32.max)
    
    //For each index from the given index to the end of the string
    for i in index ..< pi.count
    {
        //Create starting index
        let startingIndex = pi.index(pi.startIndex, offsetBy: index)
        
        //Create ending index
        let endingIndex = pi.index(pi.startIndex, offsetBy: i + 1)
        
        //Slice the string
        let prefix = String(pi[startingIndex ..< endingIndex])
        
        //If the sliced string is in out numbers dictionary
        if (numbersDictionary.keys.contains(prefix))
        {
            //Figure out the minimum number of spaces in the suffix
            let minimumNumberOfSpacesInSuffix = getMinimumNumberOfSpaces(pi, numbersDictionary, &cache, i + 1)
            
            //Compare the current minimum number of spaces to the minimum number of spaces in the suffix
            minimumNumberOfSpaces = min(minimumNumberOfSpaces, minimumNumberOfSpacesInSuffix + 1)
        }
    }
    
    //Cache the minimum number of spaces for this specific index
    cache[index] = minimumNumberOfSpaces
    
    return minimumNumberOfSpaces
}

let pi = "3141592653589793238462643383279"
let firstTest = ["314159265358979323846264338327", "9"]
assert(numbersInPiFirstSolution(pi, firstTest) == 1)
assert(numbersInPiSecondSolution(pi, firstTest) == 1)

let secondTest = ["3", "314", "49", "9001", "15926535897", "14", "9323", "8462643383279", "4", "793"]
assert(numbersInPiFirstSolution(pi, secondTest) == 3)
assert(numbersInPiSecondSolution(pi, secondTest) == 3)

let thirdTest = ["3141592653589793238462643383279"]
assert(numbersInPiFirstSolution(pi, thirdTest) == 0)
assert(numbersInPiSecondSolution(pi, thirdTest) == 0)

let fourthTest = ["3141", "1512", "159", "793", "12412451", "8462643383279"]
assert(numbersInPiFirstSolution(pi, fourthTest) == -1)
assert(numbersInPiSecondSolution(pi, fourthTest) == -1)

let fifthTest = ["314159265358979323846", "26433", "8", "3279", "314159265", "35897932384626433832", "79"]
assert(numbersInPiFirstSolution(pi, fifthTest) == 2)
assert(numbersInPiSecondSolution(pi, fifthTest) == 2)

let sixthTest = ["314159265358979323846", "327", "26433", "8", "3279", "9", "314159265", "35897932384626433832", "79"]
assert(numbersInPiFirstSolution(pi, sixthTest) == 2)
assert(numbersInPiSecondSolution(pi, sixthTest) == 2)

let seventhTest = ["141592653589793238462643383279", "314159265358979323846", "327", "26433", "8", "3279", "9", "314159265", "35897932384626433832", "79", "3"]
assert(numbersInPiFirstSolution(pi, seventhTest) == 1)
assert(numbersInPiSecondSolution(pi, seventhTest) == 1)

let eighthTest = ["3", "1", "4", "592", "65", "55", "35", "8", "9793", "2384626", "83279"]
assert(numbersInPiFirstSolution(pi, eighthTest) == 13)
assert(numbersInPiSecondSolution(pi, eighthTest) == 13)

let ninthTest = ["3", "1", "4", "592", "65", "55", "35", "8", "9793", "2384626", "383279"]
assert(numbersInPiFirstSolution(pi, ninthTest) == 12)
assert(numbersInPiSecondSolution(pi, ninthTest) == 12)

let tenthTest = ["3", "141", "592", "65", "55", "35", "8", "9793", "2384626", "383279"]
assert(numbersInPiFirstSolution(pi, tenthTest) == -1)
assert(numbersInPiSecondSolution(pi, tenthTest) == -1)

let eleventhTest = ["3", "141", "592", "65", "55", "35", "8", "9793", "23846264", "383279"]
assert(numbersInPiFirstSolution(pi, eleventhTest) == 9)
assert(numbersInPiSecondSolution(pi, eleventhTest) == 9)

let twelfthTest = ["3", "141", "592", "65", "55", "35", "8", "9793", "2384626", "3832798"]
assert(numbersInPiFirstSolution(pi, twelfthTest) == -1)
assert(numbersInPiSecondSolution(pi, twelfthTest) == -1)
