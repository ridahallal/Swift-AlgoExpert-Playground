//Breadth-first Search
class Node
{
    var name: String
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
    
    //O(v + e) time | O(v) space
    func breadthFirstSearch(array: inout [String]) -> [String]
    {
        var queue = [self]
        
        while queue.count > 0
        {
            let currentNode = queue.removeFirst()
            array.append(currentNode.name)
            
            for child in currentNode.children
            {
                queue.append(child)
            }
        }
        
        return array
    }
}

//Tests
let firstTest = Node(name: "A")
firstTest.addChild(name: "B").addChild(name: "C")
firstTest.children[0].addChild(name: "D")

let secondTest = Node(name: "A")
secondTest.addChild(name: "B").addChild(name: "C").addChild(name: "D").addChild(name: "E")
secondTest.children[1].addChild(name: "F")

let thirdTest = Node(name: "A")
thirdTest.addChild(name: "B")
thirdTest.children[0].addChild(name: "C")
thirdTest.children[0].children[0].addChild(name: "D").addChild(name: "E")
thirdTest.children[0].children[0].children[0].addChild(name: "F")

let fourthTest = Node(name: "A")
fourthTest.addChild(name: "B").addChild(name: "C").addChild(name: "D")
fourthTest.children[0].addChild(name: "E").addChild(name: "F")
fourthTest.children[2].addChild(name: "G").addChild(name: "H")
fourthTest.children[0].children[1].addChild(name: "I").addChild(name: "J")
fourthTest.children[2].children[0].addChild(name: "K")

let fifthTest = Node(name: "A")
fifthTest.addChild(name: "B").addChild(name: "C").addChild(name: "D").addChild(name: "L").addChild(name: "M")
fifthTest.children[0].addChild(name: "E").addChild(name: "F").addChild(name: "O")
fifthTest.children[1].addChild(name: "P")
fifthTest.children[2].addChild(name: "G").addChild(name: "H")
fifthTest.children[0].children[0].addChild(name: "Q").addChild(name: "R")
fifthTest.children[0].children[1].addChild(name: "I").addChild(name: "J")
fifthTest.children[2].children[0].addChild(name: "K")
fifthTest.children[4].addChild(name: "S").addChild(name: "T").addChild(name: "U").addChild(name: "V")
fifthTest.children[4].children[0].addChild(name: "W").addChild(name: "X")
fifthTest.children[4].children[0].children[1].addChild(name: "Y").addChild(name: "Z")

var arrayToReturn = [String]()
assert(firstTest.breadthFirstSearch(array: &arrayToReturn) == ["A", "B", "C", "D"])

arrayToReturn = [String]()
assert(secondTest.breadthFirstSearch(array: &arrayToReturn) == ["A", "B", "C", "D", "E", "F"])

arrayToReturn = [String]()
assert(thirdTest.breadthFirstSearch(array: &arrayToReturn) == ["A", "B", "C", "D", "E", "F"])

arrayToReturn = [String]()
assert(fourthTest.breadthFirstSearch(array: &arrayToReturn) == ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"])

arrayToReturn = [String]()
assert(fifthTest.breadthFirstSearch(array: &arrayToReturn) == ["A", "B", "C", "D", "L", "M", "E", "F", "O", "P", "G", "H", "S", "T", "U", "V", "Q", "R", "I", "J", "K", "W", "X", "Y", "Z"])
