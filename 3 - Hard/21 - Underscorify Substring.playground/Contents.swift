import Foundation

//Underscorify Substring
//O(n + m) time | O(n) space
func underscorifySubstring(_ string: String, _ substring: String) -> String
{
    let locations = getLocations(string, substring)
    let collapsedLocations = collapse(locations)
    
    return underscorify(string, collapsedLocations)
}

func getLocations(_ string: String, _ substring: String) -> [[String.Index]]
{
    //Will store an array of [startIndex, endIndex] pairs
    var locations = [[String.Index]]()
    
    //Initial index
    var start = 0
    var startIndex = string.index(string.startIndex, offsetBy: start)
    
    while start < string.count
    {
        //See whether we need to update the start index
        //If the next index exist
        if let rangeOfSubstring = string.range(of: substring, options: [], range: startIndex ..< string.endIndex, locale: nil)
        {
            //Push the indices to our locations array
            locations.append([rangeOfSubstring.lowerBound, rangeOfSubstring.upperBound])

            //Increment the start index
            let startPos = string.distance(from: string.startIndex, to: rangeOfSubstring.lowerBound)
            start = startPos + 1
            startIndex = string.index(string.startIndex, offsetBy: start)
        }
        else
        {
            break
        }
    }
    
    return locations
}

func collapse(_ locations: [[String.Index]]) -> [[String.Index]]
{
    if locations.count == 0
    {
        return locations
    }
    
    //Initialize newLocations with the first location inside locations
    var newLocations = [locations[0]]
    
    //Get the first location pair from inside the array
    var previousLocationIndex = 0
    
    //Iterate from the second location and onwards
    for i in 1 ..< locations.count
    {
        //Get the current location pair
        let currentLocation = locations[i]
        
        //If [x, y][y, z] or [w, y][x, z]
        if currentLocation[0] <= newLocations[previousLocationIndex][1]
        {
            //Collapse into the previous location
            newLocations[previousLocationIndex][1] = currentLocation[1]
        }
        //Otherwise
        else
        {
            //Push the current location
            newLocations.append(currentLocation)
            
            //Update the previous location
            previousLocationIndex += 1
        }
    }
    
    return newLocations
}

func underscorify(_ string: String, _ locations: [[String.Index]]) -> String
{
    var subIndex = 0
    var stringIndex = 0
    var locationIndex = 0
    var isInBetweenUnderscres = false
    var currentIndex = string.index(string.startIndex, offsetBy: stringIndex)
    
    var finalCharacters = [Character]()
    
    //Traverse the string letter by letter, traverse each location in our locations array
    while stringIndex < string.count && locationIndex < locations.count
    {
        currentIndex = string.index(string.startIndex, offsetBy: stringIndex)
        
        if currentIndex == locations[locationIndex][subIndex]
        {
            finalCharacters.append("_")

            isInBetweenUnderscres = !isInBetweenUnderscres
            
            //If not between underscores
            if !isInBetweenUnderscres
            {
                //Jump to the next location
                locationIndex += 1
            }
            
            if subIndex == 0
            {
                subIndex = 1
            }
            else
            {
                subIndex = 0
            }
        }
        
        finalCharacters.append(string[currentIndex])
        stringIndex += 1
    }
    
    //If we've broken from the while loop and we haven't reached the end of our locations array
    if locationIndex < locations.count
    {
        //Add the last underscore
        finalCharacters.append("_")
    }
    //If we've broken from the while loop and we haven't reached the end of our string
    else if stringIndex < string.count
    {
        //Add the rest of the string
        currentIndex = string.index(string.startIndex, offsetBy: stringIndex)
        let restOfCharacters = Array(string[currentIndex ..< string.endIndex])
        finalCharacters.append(contentsOf: restOfCharacters)
    }
    
    let result = finalCharacters.compactMap{ String($0) }.joined()
    return result
}

assert(underscorifySubstring("this is a test to see if it works", "test") == "this is a _test_ to see if it works")
assert(underscorifySubstring("test this is a test to see if it works", "test") == "_test_ this is a _test_ to see if it works")
assert(underscorifySubstring("testthis is a test to see if it works", "test") == "_test_this is a _test_ to see if it works")
assert(underscorifySubstring("testthis is a testest to see if testestes it works", "test") == "_test_this is a _testest_ to see if _testest_es it works")
assert(underscorifySubstring("testthis is a testtest to see if testestest it works", "test") == "_test_this is a _testtest_ to see if _testestest_ it works")
assert(underscorifySubstring("this is a test to see if it works and test", "test") == "this is a _test_ to see if it works and _test_")
assert(underscorifySubstring("this is a test to see if it works and test", "bfjawkfja") == "this is a test to see if it works and test")
assert(underscorifySubstring("ttttttttttttttbtttttctatawtatttttastvb", "ttt") == "_tttttttttttttt_b_ttttt_ctatawta_ttttt_astvb")
assert(underscorifySubstring("tzttztttz", "ttt") == "tzttz_ttt_z")
assert(underscorifySubstring("abababababababababababababaababaaabbababaa", "a") == "_a_b_a_b_a_b_a_b_a_b_a_b_a_b_a_b_a_b_a_b_a_b_a_b_a_b_aa_b_a_b_aaa_bb_a_b_a_b_aa_")
assert(underscorifySubstring("abcabcabcabcabcabcabcabcabcabcabcabcabcabc", "abc") == "_abcabcabcabcabcabcabcabcabcabcabcabcabcabc_")
