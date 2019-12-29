//Generic Node class
class Node
{
    //Properties
    let name: String
    var children: [Node]
    
    //Initializer
    init(name: String)
    {
        self.name = name
        self.children = []
    }
    
    //Add child
    func addChild(name: String) -> Node
    {
        let childNode = Node(name: name)
        self.children.append(childNode)
        
        return self
    }
    
    //Depth First Search
    //O(v + e) time | O(v) space
    func depthFirstSearch(array: inout [String]) -> [String]
    {
        array.append(self.name)
        
        for child in self.children
        {
            child.depthFirstSearch(array: &array)
        }
        
        return array
    }
}

//Tests
let test1 = Node(name: "A")
test1.addChild(name: "B").addChild(name: "C")
test1.children[0].addChild(name: "D")

let test2 = Node(name: "A")
test2.addChild(name: "B").addChild(name: "C").addChild(name: "D").addChild(name: "E")
test2.children[1].addChild(name: "F")

let test3 = Node(name: "A")
test3.addChild(name: "B")
test3.children[0].addChild(name: "C")
test3.children[0].children[0].addChild(name: "D").addChild(name: "E")
test3.children[0].children[0].children[0].addChild(name: "F")

let test4 = Node(name: "A")
test4.addChild(name: "B").addChild(name: "C").addChild(name: "D")
test4.children[0].addChild(name: "E").addChild(name: "F")
test4.children[2].addChild(name: "G").addChild(name: "H")
test4.children[0].children[1].addChild(name: "I").addChild(name: "J")
test4.children[2].children[0].addChild(name: "K")

let test5 = Node(name: "A")
test5.addChild(name: "B").addChild(name: "C").addChild(name: "D").addChild(name: "L").addChild(name: "M")
test5.children[0].addChild(name: "E").addChild(name: "F").addChild(name: "O")
test5.children[1].addChild(name: "P")
test5.children[2].addChild(name: "G").addChild(name: "H")
test5.children[0].children[0].addChild(name: "Q").addChild(name: "R")
test5.children[0].children[1].addChild(name: "I").addChild(name: "J")
test5.children[2].children[0].addChild(name: "K")
test5.children[4].addChild(name: "S").addChild(name: "T").addChild(name: "U").addChild(name: "V")
test5.children[4].children[0].addChild(name: "W").addChild(name: "X")
test5.children[4].children[0].children[1].addChild(name: "Y").addChild(name: "Z")

//Test 1
var arrayToReturn = [String]()
assert(test1.depthFirstSearch(array: &arrayToReturn) == ["A", "B", "D", "C"])

//Test 2
arrayToReturn = [String]()
assert(test2.depthFirstSearch(array: &arrayToReturn) == ["A", "B", "C", "F", "D", "E"])

//Test 3
arrayToReturn = [String]()
assert(test3.depthFirstSearch(array: &arrayToReturn) == ["A", "B", "C", "D", "F", "E"])

//Test 4
arrayToReturn = [String]()
assert(test4.depthFirstSearch(array: &arrayToReturn) == ["A", "B", "E", "F", "I", "J", "C", "D", "G", "K", "H"])

//Test 5
arrayToReturn = [String]()
assert(test5.depthFirstSearch(array: &arrayToReturn) == ["A", "B", "E", "Q", "R", "F", "I", "J", "O", "C", "P", "D", "G", "K", "H", "L", "M", "S", "W", "X", "Y", "Z", "T", "U", "V"])
