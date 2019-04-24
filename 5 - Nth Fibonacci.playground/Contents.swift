//Nth Fibonacci

//Solution #1
//O(2^n) time | O(n) space
func nthFibonacciFirstSolution(fib: Int) -> Int
{
    if fib == 2
    {
        return 1
    }
    else if fib == 1
    {
        return 0
    }
    else
    {
        return nthFibonacciFirstSolution(fib: fib - 1) + nthFibonacciFirstSolution(fib: fib - 2)
    }
}

//Solution #2
//O(n) time | O(n) space
func nthFibonacciSecondSolution(fib: Int, memoize: inout [Int: Int]) -> Int
{
    if memoize.keys.contains(fib)
    {
        return memoize[fib]!
    }
    else
    {
        memoize[fib] = nthFibonacciSecondSolution(fib: fib - 1, memoize: &memoize) + nthFibonacciSecondSolution(fib: fib - 2, memoize: &memoize)
        
        return memoize[fib]!
    }
}

//Solution #3
//O(n) time | O(1) space
func nthFibonacciThirdSolution(fib: Int) -> Int
{
    var lastTwo = [0, 1]
    
    var counter = 3
    
    while counter <= fib
    {
        let nextFib = lastTwo[0] + lastTwo[1]

        lastTwo[0] = lastTwo[1]
        lastTwo[1] = nextFib
        
        counter = counter + 1
    }
    
    return fib > 1 ? lastTwo[1] : lastTwo[0]
}

//Tests
//First Solution
assert(nthFibonacciFirstSolution(fib: 1) == 0)
assert(nthFibonacciFirstSolution(fib: 2) == 1)
assert(nthFibonacciFirstSolution(fib: 3) == 1)
assert(nthFibonacciFirstSolution(fib: 4) == 2)
assert(nthFibonacciFirstSolution(fib: 5) == 3)
assert(nthFibonacciFirstSolution(fib: 6) == 5)
assert(nthFibonacciFirstSolution(fib: 7) == 8)
assert(nthFibonacciFirstSolution(fib: 8) == 13)
assert(nthFibonacciFirstSolution(fib: 9) == 21)
assert(nthFibonacciFirstSolution(fib: 10) == 34)
assert(nthFibonacciFirstSolution(fib: 11) == 55)
assert(nthFibonacciFirstSolution(fib: 12) == 89)
assert(nthFibonacciFirstSolution(fib: 13) == 144)
assert(nthFibonacciFirstSolution(fib: 14) == 233)
assert(nthFibonacciFirstSolution(fib: 15) == 377)
assert(nthFibonacciFirstSolution(fib: 16) == 610)
assert(nthFibonacciFirstSolution(fib: 17) == 987)
assert(nthFibonacciFirstSolution(fib: 18) == 1597)

//Second Solution
var memoize = [1: 0, 2: 1]
assert(nthFibonacciSecondSolution(fib: 1, memoize: &memoize) == 0)
assert(nthFibonacciSecondSolution(fib: 2, memoize: &memoize) == 1)
assert(nthFibonacciSecondSolution(fib: 3, memoize: &memoize) == 1)
assert(nthFibonacciSecondSolution(fib: 4, memoize: &memoize) == 2)
assert(nthFibonacciSecondSolution(fib: 5, memoize: &memoize) == 3)
assert(nthFibonacciSecondSolution(fib: 6, memoize: &memoize) == 5)
assert(nthFibonacciSecondSolution(fib: 7, memoize: &memoize) == 8)
assert(nthFibonacciSecondSolution(fib: 8, memoize: &memoize) == 13)
assert(nthFibonacciSecondSolution(fib: 9, memoize: &memoize) == 21)
assert(nthFibonacciSecondSolution(fib: 10, memoize: &memoize) == 34)
assert(nthFibonacciSecondSolution(fib: 11, memoize: &memoize) == 55)
assert(nthFibonacciSecondSolution(fib: 12, memoize: &memoize) == 89)
assert(nthFibonacciSecondSolution(fib: 13, memoize: &memoize) == 144)
assert(nthFibonacciSecondSolution(fib: 14, memoize: &memoize) == 233)
assert(nthFibonacciSecondSolution(fib: 15, memoize: &memoize) == 377)
assert(nthFibonacciSecondSolution(fib: 16, memoize: &memoize) == 610)
assert(nthFibonacciSecondSolution(fib: 17, memoize: &memoize) == 987)
assert(nthFibonacciSecondSolution(fib: 18, memoize: &memoize) == 1597)

//Third Solution
assert(nthFibonacciThirdSolution(fib: 1) == 0)
assert(nthFibonacciThirdSolution(fib: 2) == 1)
assert(nthFibonacciThirdSolution(fib: 3) == 1)
assert(nthFibonacciThirdSolution(fib: 4) == 2)
assert(nthFibonacciThirdSolution(fib: 5) == 3)
assert(nthFibonacciThirdSolution(fib: 6) == 5)
assert(nthFibonacciThirdSolution(fib: 7) == 8)
assert(nthFibonacciThirdSolution(fib: 8) == 13)
assert(nthFibonacciThirdSolution(fib: 9) == 21)
assert(nthFibonacciThirdSolution(fib: 10) == 34)
assert(nthFibonacciThirdSolution(fib: 11) == 55)
assert(nthFibonacciThirdSolution(fib: 12) == 89)
assert(nthFibonacciThirdSolution(fib: 13) == 144)
assert(nthFibonacciThirdSolution(fib: 14) == 233)
assert(nthFibonacciThirdSolution(fib: 15) == 377)
assert(nthFibonacciThirdSolution(fib: 16) == 610)
assert(nthFibonacciThirdSolution(fib: 17) == 987)
assert(nthFibonacciThirdSolution(fib: 18) == 1597)
