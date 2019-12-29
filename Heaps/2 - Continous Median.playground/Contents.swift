//Generic Heap Class
class Heap
{
    var length = 0
    var heap = [Int]()
    var comparisonFunction: (Int, Int) -> Bool
    typealias comparisonFuncTypeAlias = (Int, Int)  -> Bool
    
    init(array: [Int], comparisonFunction: @escaping comparisonFuncTypeAlias)
    {
        self.comparisonFunction = comparisonFunction
        self.heap = buildHeap(array: array)
        self.length = heap.count
    }
    
    func buildHeap(array: [Int]) -> [Int]
    {
        var heapToReturn = array
        
        var firstParentIndex = Double((array.count - 2) / 2)
        firstParentIndex = firstParentIndex.rounded(.down)
        
        if array.count > 0
        {
            for var currentIndex in (0 ... Int(firstParentIndex)).reversed()
            {
                var endIndex = array.count - 1
                
                siftDown(currentIndex: &currentIndex, endIndex: &endIndex, heap: &heapToReturn)
            }
        }
        
        return heapToReturn
    }
    
    func siftDown(currentIndex: inout Int, endIndex: inout Int, heap: inout [Int])
    {
        var firstChildIndex = (2 * currentIndex) + 1
        
        while firstChildIndex <= endIndex
        {
            var secondChildIndex = -1
            
            let potentialSecondChild = (2 * currentIndex) + 2
            
            if potentialSecondChild <= endIndex
            {
                secondChildIndex = potentialSecondChild
            }
            
            var indexToSwap = -1
            
            if secondChildIndex != -1 && comparisonFunction(heap[secondChildIndex], heap[firstChildIndex])
            {
                indexToSwap = secondChildIndex
            }
            else
            {
                indexToSwap = firstChildIndex
            }
            
            if comparisonFunction(heap[indexToSwap], heap[currentIndex])
            {
                swap(firstIndex: currentIndex, secondIndex: indexToSwap, heap: &heap)
                
                currentIndex = indexToSwap
                
                firstChildIndex = (2 * currentIndex) + 1
            }
            else
            {
                return
            }
        }
    }
    
    func siftUp(currentIndex: inout Int, heap: inout [Int])
    {
        var parentIndex = Double((currentIndex - 1) / 2)
        parentIndex = parentIndex.rounded(.down)
        
        while currentIndex > 0
        {
            if comparisonFunction(heap[currentIndex], heap[Int(parentIndex)])
            {
                swap(firstIndex: currentIndex, secondIndex: Int(parentIndex), heap: &heap)
                
                currentIndex = Int(parentIndex)
                
                parentIndex = Double((currentIndex - 1) / 2)
            }
            else
            {
                return
            }
        }
    }
    
    func peek() -> Double
    {
        return Double(heap[0])
    }
    
    func remove() -> Int
    {
        swap(firstIndex: 0, secondIndex: heap.count - 1, heap: &heap)
        
        if let valuetoRemove = heap.popLast()
        {
            var currentIndex = 0
            var endIndex = heap.count - 1
            
            length -= 1
            siftDown(currentIndex: &currentIndex, endIndex: &endIndex, heap: &heap)
            
            return valuetoRemove
        }
        
        return -1
    }
    
    func insert(value: Int)
    {
        heap.append(value)
        length += 1
        
        var currentIndex = heap.count - 1
        siftUp(currentIndex: &currentIndex, heap: &heap)
    }
    
    func swap(firstIndex: Int, secondIndex: Int, heap: inout [Int])
    {
        let temp = heap[firstIndex]
        
        heap[firstIndex] = heap[secondIndex]
        heap[secondIndex] = temp
    }
}

func minHeapFunc(_ a: Int, _ b: Int) -> Bool
{
    return a < b
}

func maxHeapFunc(_ a: Int, _ b: Int) -> Bool
{
    return a > b
}

//Continuous Median Handler class
class ContinuousMedianHandler
{
    var median: Double
    var lowers: Heap
    var greaters: Heap
    
    init()
    {
        self.median = 0.0
        
        self.lowers = Heap(array: [], comparisonFunction: maxHeapFunc(_:_:))
        self.greaters = Heap(array: [], comparisonFunction: minHeapFunc(_:_:))
    }
    
    func getMedian() -> Double
    {
        return median
    }
    
    //O(log(n)) time | O(n) space
    func insert(number: Int)
    {
        if lowers.length == 0 || number < Int(lowers.peek())
        {
            lowers.insert(value: number)
        }
        else
        {
            greaters.insert(value: number)
        }
        
        rebalanceHeaps()
        updateMedian()
    }
    
    func rebalanceHeaps()
    {
        //If lowers heap has more nodes
        if lowers.length - greaters.length == 2
        {
            //Remove the top node and move it to the greaters heap
            greaters.insert(value: lowers.remove())
        }
            //If the greaters heap has more nodes
        else if greaters.length - lowers.length == 2
        {
            //Remove the top node and move it to the lowers heap
            lowers.insert(value: greaters.remove())
        }
    }
    
    func updateMedian()
    {
        //If lowers and greaters are equal
        if lowers.length == greaters.length
        {
            //Peek on both and get the average
            median = Double((lowers.peek() + greaters.peek()) / 2)
        }
        else if lowers.length > greaters.length
        {
            median = Double(lowers.peek())
        }
        else
        {
            median = Double(greaters.peek())
        }
    }
}

//Tests
let test = ContinuousMedianHandler()

test.insert(number: 5)
assert(test.getMedian() == 5)

test.insert(number: 10)
assert(test.getMedian() == 7.5)

test.insert(number: 100)
assert(test.getMedian() == 10)

test.insert(number: 200)
assert(test.getMedian() == 55)

test.insert(number: 6)
assert(test.getMedian() == 10)

test.insert(number: 13)
assert(test.getMedian() == 11.5)

test.insert(number: 14)
assert(test.getMedian() == 13)

test.insert(number: 50)
assert(test.getMedian() == 13.5)

test.insert(number: 51)
assert(test.getMedian() == 14)

test.insert(number: 52)
assert(test.getMedian() == 32)

test.insert(number: 1000)
assert(test.getMedian() == 50)

test.insert(number: 10000)
assert(test.getMedian() == 50.5)

test.insert(number: 10001)
assert(test.getMedian() == 51)

test.insert(number: 10002)
assert(test.getMedian() == 51.5)

test.insert(number: 10002)
assert(test.getMedian() == 52)

test.insert(number: 10004)
assert(test.getMedian() == 76)

test.insert(number: 75)
assert(test.getMedian() == 75)

test.insert(number: 80)
assert(test.getMedian() == 77.5)
