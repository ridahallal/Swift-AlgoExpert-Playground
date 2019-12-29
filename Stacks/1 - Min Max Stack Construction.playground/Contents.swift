//Min Max Stack
class MinMaxStack
{
    var minMaxStack = [[String: Int]]()
    var stack = [Int]()
    
    //O(1) time | O(1) space
    func peek() -> Int?
    {
        return stack.last
    }
    
    //O(1) time | O(1) space
    func pop() -> Int?
    {
        minMaxStack.popLast()
        
        return stack.popLast()
    }
    
    //O(1) time | O(1) space
    func push(number: Int)
    {
        var newMinMax = ["min": number, "max": number]
        
        if let lastMinMax = minMaxStack.last
        {
            newMinMax["min"] = min(lastMinMax["min"]!, newMinMax["min"]!)
            newMinMax["max"] = max(lastMinMax["max"]!, newMinMax["max"]!)
        }
        
        minMaxStack.append(newMinMax)
        stack.append(number)
    }
    
    //O(1) time | O(1) space
    func getMin() -> Int?
    {
        return minMaxStack.last?["min"]
    }
    
    //O(1) | O(1) space
    func getMax() -> Int?
    {
        return minMaxStack.last?["max"]
    }
}

//Tests
func testMinMaxPeek(stack: MinMaxStack, min: Int, max: Int, peek: Int)
{
    if let stackMin = stack.getMin()
    {
        assert(stackMin == min)
    }
    
    if let stackMax = stack.getMax()
    {
        assert(stackMax == max)
    }
    
    if let stackPeek = stack.peek()
    {
        assert(stackPeek == peek)
    }
}

let firstTest = MinMaxStack()
firstTest.push(number: 2)
testMinMaxPeek(stack: firstTest, min: 2, max: 2, peek: 2)
firstTest.push(number: 7)
testMinMaxPeek(stack: firstTest, min: 2, max: 7, peek: 7)
firstTest.push(number: 1)
testMinMaxPeek(stack: firstTest, min: 1, max: 7, peek: 1)
firstTest.push(number: 8)
testMinMaxPeek(stack: firstTest, min: 1, max: 8, peek: 8)
firstTest.push(number: 3)
testMinMaxPeek(stack: firstTest, min: 1, max: 8, peek: 3)
firstTest.push(number: 9)
testMinMaxPeek(stack: firstTest, min: 1, max: 9, peek: 9)
assert(firstTest.pop() == 9)
testMinMaxPeek(stack: firstTest, min: 1, max: 8, peek: 3)
assert(firstTest.pop() == 3)
testMinMaxPeek(stack: firstTest, min: 1, max: 8, peek: 8)
assert(firstTest.pop() == 8)
testMinMaxPeek(stack: firstTest, min: 1, max: 7, peek: 1)
assert(firstTest.pop() == 1)
testMinMaxPeek(stack: firstTest, min: 2, max: 7, peek: 7)
assert(firstTest.pop() == 7)
testMinMaxPeek(stack: firstTest, min: 2, max: 2, peek: 2)
assert(firstTest.pop() == 2)

let secondTest = MinMaxStack()
secondTest.push(number: 5)
testMinMaxPeek(stack: secondTest, min: 5, max: 5, peek: 5)
secondTest.push(number: 5)
testMinMaxPeek(stack: secondTest, min: 5, max: 5, peek: 5)
secondTest.push(number: 5)
testMinMaxPeek(stack: secondTest, min: 5, max: 5, peek: 5)
secondTest.push(number: 5)
testMinMaxPeek(stack: secondTest, min: 5, max: 5, peek: 5)
secondTest.push(number: 8)
testMinMaxPeek(stack: secondTest, min: 5, max: 8, peek: 8)
secondTest.push(number: 8)
testMinMaxPeek(stack: secondTest, min: 5, max: 8, peek: 8)
secondTest.push(number: 0)
testMinMaxPeek(stack: secondTest, min: 0, max: 8, peek: 0)
secondTest.push(number: 8)
testMinMaxPeek(stack: secondTest, min: 0, max: 8, peek: 8)
secondTest.push(number: 9)
testMinMaxPeek(stack: secondTest, min: 0, max: 9, peek: 9)
secondTest.push(number: 5)
testMinMaxPeek(stack: secondTest, min: 0, max: 9, peek: 5)
assert(secondTest.pop() == 5)
testMinMaxPeek(stack: secondTest, min: 0, max: 9, peek: 9)
assert(secondTest.pop() == 9)
testMinMaxPeek(stack: secondTest, min: 0, max: 8, peek: 8)
assert(secondTest.pop() == 8)
testMinMaxPeek(stack: secondTest, min: 0, max: 8, peek: 0)
assert(secondTest.pop() == 0)
testMinMaxPeek(stack: secondTest, min: 5, max: 8, peek: 8)
assert(secondTest.pop() == 8)
testMinMaxPeek(stack: secondTest, min: 5, max: 8, peek: 8)
assert(secondTest.pop() == 8)
testMinMaxPeek(stack: secondTest, min: 5, max: 5, peek: 5)
assert(secondTest.pop() == 5)
testMinMaxPeek(stack: secondTest, min: 5, max: 5, peek: 5)
assert(secondTest.pop() == 5)
testMinMaxPeek(stack: secondTest, min: 5, max: 5, peek: 5)
assert(secondTest.pop() == 5)
testMinMaxPeek(stack: secondTest, min: 5, max: 5, peek: 5)
assert(secondTest.pop() == 5)

let thirdTest = MinMaxStack()
thirdTest.push(number: 2)
testMinMaxPeek(stack: thirdTest, min: 2, max: 2, peek: 2)
thirdTest.push(number: 0)
testMinMaxPeek(stack: thirdTest, min: 0, max: 2, peek: 0)
thirdTest.push(number: 5)
testMinMaxPeek(stack: thirdTest, min: 0, max: 5, peek: 5)
thirdTest.push(number: 4)
testMinMaxPeek(stack: thirdTest, min: 0, max: 5, peek: 4)
assert(thirdTest.pop() == 4)
testMinMaxPeek(stack: thirdTest, min: 0, max: 5, peek: 5)
assert(thirdTest.pop() == 5)
testMinMaxPeek(stack: thirdTest, min: 0, max: 2, peek: 0)
thirdTest.push(number: 4)
testMinMaxPeek(stack: thirdTest, min: 0, max: 4, peek: 4)
thirdTest.push(number: 11)
testMinMaxPeek(stack: thirdTest, min: 0, max: 11, peek: 11)
thirdTest.push(number: -11)
testMinMaxPeek(stack: thirdTest, min: -11, max: 11, peek: -11)
assert(thirdTest.pop() == -11)
testMinMaxPeek(stack: thirdTest, min: 0, max: 11, peek: 11)
assert(thirdTest.pop() == 11)
testMinMaxPeek(stack: thirdTest, min: 0, max: 4, peek: 4)
assert(thirdTest.pop() == 4)
testMinMaxPeek(stack: thirdTest, min: 0, max: 2, peek: 0)
assert(thirdTest.pop() == 0)
testMinMaxPeek(stack: thirdTest, min: 2, max: 2, peek: 2)
assert(thirdTest.pop() == 2)
thirdTest.push(number: 6)
testMinMaxPeek(stack: thirdTest, min: 6, max: 6, peek: 6)
assert(thirdTest.pop() == 6)
