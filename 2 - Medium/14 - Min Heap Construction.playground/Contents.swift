//Min Heap Construction
class MinHeap
{
    var heap = [Int]()
    
    init(array: [Int])
    {
        var array = array
        self.heap = buildHeap(array: &array)
    }
    
    //O(n) time | O(1) space
    func buildHeap(array: inout [Int]) -> [Int]
    {
        //Start from the last parent and go upwards
        var firstParentIndex = Double((array.count - 2) / 2)
        firstParentIndex = firstParentIndex.rounded(.down)
        
        for var currentIndex in (0 ... Int(firstParentIndex)).reversed()
        {
            var endIndex = array.count - 1
            siftDown(currentIndex: &currentIndex, endIndex: &endIndex, heap: &array)
        }
        
        return array
    }
    
    //O(log(n)) time | O(1) space
    func siftDown(currentIndex: inout Int, endIndex: inout Int, heap: inout [Int])
    {
        //When sifting down we ust compare both child nodes, get the first child index by applying our formula (2 * x) + 1
        var firstChildIndex = (2 * currentIndex) + 1
        
        //Keep sifting down until we reach the end
        while firstChildIndex < endIndex
        {
            //Initialize the second child's index to -1
            var secondChildIndex = -1
            
            let potentialSecondChild = (2 * currentIndex) + 2
            
            //If the second child exists
            if potentialSecondChild <= endIndex
            {
                secondChildIndex = potentialSecondChild
            }
            
            //We need to figure out with which child we need to swap
            var indexToSwap = -1
            
            //If the second child exists and the its value is less than the first child
            if secondChildIndex != -1 && heap[secondChildIndex] < heap[firstChildIndex]
            {
                //We want to swap with it
                indexToSwap = secondChildIndex
            }
            //Otherwise
            else
            {
                //We want to swap with the first child
                indexToSwap = firstChildIndex
            }
            
            //Check if the value at index to swap is less than the value at the current index
            if heap[indexToSwap] < heap[currentIndex]
            {
                //Swap both indices
                swap(firstIndex: currentIndex, secondIndex: indexToSwap, heap: &heap)
                
                //Update current index
                currentIndex = indexToSwap
                
                //Update first child index
                firstChildIndex = (2 * currentIndex) + 1
            }
            else
            {
                return
            }
        }
    }
    
    //O(log(n)) time | O(1) space
    func siftUp(currentIndex: inout Int, heap: inout [Int])
    {
        //Get the parent node by applying the formula (x - 1) / 2 and rounding it down
        var parentIndex = Double((currentIndex - 1) / 2)
        parentIndex = parentIndex.rounded(.down)
        
        //While we haven't reached the top and the value at the current index is less than the value at the parent index
        while currentIndex > 0 && heap[currentIndex] < heap[Int(parentIndex)]
        {
            //Swap both indices
            swap(firstIndex: currentIndex, secondIndex: Int(parentIndex), heap: &heap)
            
            //Update current index
            currentIndex = Int(parentIndex)
            
            //Update parent index
            parentIndex = Double((currentIndex - 1) / 2)
        }
    }
    
    //O(1) time | O(1) space
    func peek() -> Int
    {
        return heap[0]
    }
    
    //O(log(n)) time | O(1) space
    func remove() -> Int
    {
        //Removal will remove the top value of a heap, so first thing we do is swap the top value with the last value of the heap
        swap(firstIndex: 0, secondIndex: heap.count - 1, heap: &heap)
        
        if let valueToRemove = heap.popLast()
        {
            var currentIndex = 0
            var endIndex = heap.count - 1
            siftDown(currentIndex: &currentIndex, endIndex: &endIndex, heap: &heap)
            
            return valueToRemove
        }
        
        return -1
    }
    
    //O(log(n)) time | O(1) space
    func insert(value: Int)
    {
        //Append the value to the heap
        heap.append(value)
        
        //Sift it up
        var currentIndex = heap.count - 1
        siftUp(currentIndex: &currentIndex, heap: &heap)
    }
    
    //Generic swap function
    func swap(firstIndex: Int, secondIndex: Int, heap: inout [Int])
    {
        let temp = heap[firstIndex]
        heap[firstIndex] = heap[secondIndex]
        heap[secondIndex] = temp
    }
}

//Tests
let firstTest = MinHeap(array: [2, 3, 1])
let secondTest = MinHeap(array: [1, 2, 3, 4, 5, 6, 7, 8, 9])

let thirdTest = MinHeap(array: [48, 12, 24, 7, 8, -5, 24, 391, 24, 56, 2, 6, 8, 41])
thirdTest.insert(value: 76)
thirdTest.remove()
thirdTest.remove()
thirdTest.insert(value: 87)

let fourthTest = MinHeap(array: [-4, 5, 10, 8, -10, -6, -4, -2, -5, 3, 5, -4, -5, -1, 1, 6, -7, -6, -7, 8])

let fifthTest = MinHeap(array: [-7, 2, 3, 8, -10, 4, -6, -10, -2, -7, 10, 5, 2, 9, -9, -5, 3, 8])
fifthTest.remove()
fifthTest.insert(value: -8)
fifthTest.remove()
fifthTest.insert(value: 8)

let sixthTest = MinHeap(array: [427, 787, 222, 996, -359, -614, 246, 230, 107, -706, 568, 9, -246, 12, -764, -212, -484, 603, 934, -848, -646, -991, 661, -32, -348, -474, -439, -56, 507, 736, 635, -171, -215, 564, -710, 710, 565, 892, 970, -755, 55, 821, -3, -153, 240, -160, -610, -583, -27, 131])

let seventhTest = MinHeap(array: [991, -731, -882, 100, 280, -43, 432, 771, -581, 180, -382, -998, 847, 80, -220, 680, 769, -75, -817, 366, 956, 749, 471, 228, -435, -269, 652, -331, -387, -657, -255, 382, -216, -6, -163, -681, 980, 913, -169, 972, -523, 354, 747, 805, 382, -827, -796, 372, 753, 519, 906])
seventhTest.remove()
seventhTest.remove()
seventhTest.remove()
seventhTest.insert(value: 992)

let eighthTest = MinHeap(array: [544, -578, 556, 713, -655, -359, -810, -731, 194, -531, -685, 689, -279, -738, 886, -54, -320, -500, 738, 445, -401, 993, -753, 329, -396, -924, -975, 376, 748, -356, 972, 459, 399, 669, -488, 568, -702, 551, 763, -90, -249, -45, 452, -917, 394, 195, -877, 153, 153, 788, 844, 867, 266, -739, 904, -154, -947, 464, 343, -312, 150, -656, 528, 61, 94, -581])

let ninthTest = MinHeap(array: [-823, 164, 48, -987, 323, 399, -293, 183, -908, -376, 14, 980, 965, 842, 422, 829, 59, 724, -415, -733, 356, -855, -155, 52, 328, -544, -371, -160, -942, -51, 700, -363, -353, -359, 238, 892, -730, -575, 892, 490, 490, 995, 572, 888, -935, 919, -191, 646, -120, 125, -817, 341, -575, 372, -874, 243, 610, -36, -685, -337, -13, 295, 800, -950, -949, -257, 631, -542, 201, -796, 157, 950, 540, -846, -265, 746, 355, -578, -441, -254, -941, -738, -469, -167, -420, -126, -410, 59])
ninthTest.insert(value: 2)
ninthTest.insert(value: 22)
ninthTest.insert(value: 222)
ninthTest.insert(value: 2222)
ninthTest.remove()
ninthTest.remove()
ninthTest.remove()
ninthTest.remove()

func testMinHeap(heap: MinHeap)
{
    assert(heap.heap.first == heap.heap.min())
    
    for currentIndex in 0 ..< heap.heap.count - 1
    {
        var parentIndex = Double((currentIndex - 1) / 2)
        parentIndex = parentIndex.rounded(.down)
        
        if parentIndex < 0
        {
            break
        }
        
        assert(heap.heap[currentIndex] >= heap.heap[Int(parentIndex)])
    }
}

testMinHeap(heap: firstTest)
testMinHeap(heap: secondTest)
testMinHeap(heap: thirdTest)
testMinHeap(heap: fourthTest)
testMinHeap(heap: fifthTest)
testMinHeap(heap: sixthTest)
testMinHeap(heap: seventhTest)
testMinHeap(heap: eighthTest)
testMinHeap(heap: ninthTest)
