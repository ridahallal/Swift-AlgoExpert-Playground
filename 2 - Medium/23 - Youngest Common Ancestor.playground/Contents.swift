//Youngest Common Ancestor
class AncestralTree
{
    var name = String()
    var ancestor: AncestralTree?
    
    init(name: String)
    {
        self.name = name
        self.ancestor = nil
    }
    
    func addAsAncestor(descendants: [AncestralTree])
    {
        for descendant in descendants
        {
            descendant.ancestor = self
        }
    }
}

//O(d) time | O(1) space
func getYoungestCommonAncestor(_ topAncestor: AncestralTree?, _ descendantOne: inout AncestralTree?, _ descendantTwo: inout AncestralTree?) -> AncestralTree
{
    var firstDescendant = descendantOne
    var secondDescendant = descendantTwo
    
    let depthOne = getDescendantDepth(&descendantOne, topAncestor)
    let depthTwo = getDescendantDepth(&descendantTwo, topAncestor)
    
    if depthOne > depthTwo
    {
        var difference = depthOne - depthTwo
        return backTrackAncestralTree(&firstDescendant, &secondDescendant, &difference)
    }
    else
    {
        var difference = depthTwo - depthOne
        return backTrackAncestralTree(&secondDescendant, &firstDescendant, &difference)
    }
}

func getDescendantDepth(_ descendant: inout AncestralTree?, _ topAncestor: AncestralTree?) -> Int
{
    var depth = 0
    
    while descendant !== topAncestor
    {
        depth += 1
        descendant = descendant?.ancestor
    }
    
    return depth
}

func backTrackAncestralTree(_ lowerDescendant: inout AncestralTree?, _ higherDescendant: inout AncestralTree?, _ difference: inout Int) -> AncestralTree
{
    while difference > 0
    {
        difference -= 1
        lowerDescendant = lowerDescendant?.ancestor
    }
    
    while lowerDescendant !== higherDescendant
    {
        lowerDescendant = lowerDescendant?.ancestor
        higherDescendant = higherDescendant?.ancestor
    }
    
    return lowerDescendant!
}

//Tests
var ancestralTrees = [String: AncestralTree]()
let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

for letter in alphabet
{
    let stringifiedLetter = String(letter)
    ancestralTrees[stringifiedLetter] = AncestralTree(name: stringifiedLetter)
}

ancestralTrees["A"]!.addAsAncestor(descendants:
    [
        ancestralTrees["B"]!,
        ancestralTrees["C"]!,
        ancestralTrees["D"]!,
        ancestralTrees["E"]!,
        ancestralTrees["F"]!
    ])

ancestralTrees["B"]!.addAsAncestor(descendants:
    [
        ancestralTrees["G"]!,
        ancestralTrees["H"]!,
        ancestralTrees["I"]!
    ])

ancestralTrees["C"]!.addAsAncestor(descendants:
    [
        ancestralTrees["J"]!
    ])

ancestralTrees["D"]!.addAsAncestor(descendants:
    [
        ancestralTrees["K"]!,
        ancestralTrees["L"]!
    ])

ancestralTrees["F"]!.addAsAncestor(descendants:
    [
        ancestralTrees["M"]!,
        ancestralTrees["N"]!
    ])

ancestralTrees["H"]!.addAsAncestor(descendants:
    [
        ancestralTrees["O"]!,
        ancestralTrees["P"]!,
        ancestralTrees["Q"]!,
        ancestralTrees["R"]!
    ])

ancestralTrees["K"]!.addAsAncestor(descendants:
    [
        ancestralTrees["S"]!
    ])

ancestralTrees["P"]!.addAsAncestor(descendants:
    [
        ancestralTrees["T"]!,
        ancestralTrees["U"]!
    ])

ancestralTrees["R"]!.addAsAncestor(descendants:
    [
        ancestralTrees["V"]!
    ])

ancestralTrees["V"]!.addAsAncestor(descendants:
    [
        ancestralTrees["W"]!,
        ancestralTrees["X"]!,
        ancestralTrees["Y"]!
    ])

ancestralTrees["X"]!.addAsAncestor(descendants:
    [
        ancestralTrees["Z"]!
    ])


func testYCA(_ topAncestorName: String, _ firstDescendantName: String, _ secondDescendantName: String, _ assertedAncestorName: String)
{
    let topAncestor = ancestralTrees[topAncestorName]
    var firstDescendant = ancestralTrees[firstDescendantName]
    var secondDescendant = ancestralTrees[secondDescendantName]
    
    let youngestAncestor = ancestralTrees[assertedAncestorName]
    let testYoungestAncestor = getYoungestCommonAncestor(topAncestor, &firstDescendant, &secondDescendant)
    
    assert(youngestAncestor === testYoungestAncestor)
}

testYCA("A", "A", "B", "A")
testYCA("A", "B", "F", "A")
testYCA("A", "G", "M", "A")
testYCA("A", "U", "S", "A")
testYCA("A", "Z", "M", "A")
testYCA("A", "O", "I", "B")
testYCA("A", "T", "Z", "H")
testYCA("A", "T", "V", "H")
testYCA("A", "T", "H", "H")
testYCA("A", "W", "V", "V")
testYCA("A", "Z", "B", "B")
testYCA("A", "Q", "W", "H")
testYCA("A", "A", "Z", "A")
