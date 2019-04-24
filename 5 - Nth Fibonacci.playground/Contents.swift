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

nthFibonacciFirstSolution(fib: 5)

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

var memoize = [1: 0, 2: 1]
nthFibonacciSecondSolution(fib: 5, memoize: &memoize)

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

nthFibonacciThirdSolution(fib: 5)
