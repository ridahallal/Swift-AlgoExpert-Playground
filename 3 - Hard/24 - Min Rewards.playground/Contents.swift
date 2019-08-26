//Min Rewards
//Solution #1
//O(n ^ 2) time | O(n) space
func minRewardsFirstSolution(_ scores: [Int]) -> Int
{
    var rewards = Array(repeating: 1, count: scores.count)
    
    for i in 1 ..< scores.count
    {
        var j = i - 1
        
        if scores[i] > scores[j]
        {
            rewards[i] = rewards[j] + 1
        }
        else
        {
            while j >= 0 && scores[j] > scores[j + 1]
            {
                rewards[j] = max(rewards[j], rewards[j + 1] + 1)
                j -= 1
            }
        }
    }
    
    return rewards.reduce(0, { $0 + $1 })
}

//Solution #2
//O(n) time | O(n) space
func minRewardsSecondSolution(_ scores: [Int]) -> Int
{
    var rewards = Array(repeating: 1, count: scores.count)
    let localMinIndices = getLocalMinIndices(scores)
    
    for localMinIndex in localMinIndices
    {
        expandFromLocalMinIndex(localMinIndex, scores, &rewards)
    }
    
    return rewards.reduce(0, { $0 + $1 })
}

func getLocalMinIndices(_ scores: [Int]) -> [Int]
{
    if scores.count == 1
    {
        return [0]
    }
    
    var localMinIndices = [Int]()
    
    for i in 0 ..< scores.count
    {
        if i == 0 && scores[i] < scores[i + 1]
        {
            localMinIndices.append(i)
        }
        
        if i == scores.count - 1 && scores[i] < scores[i - 1]
        {
            localMinIndices.append(i)
        }
        
        if i == 0 || i == scores.count - 1
        {
            continue
        }
        
        if scores[i] < scores[i - 1] && scores[i] < scores[i + 1]
        {
            localMinIndices.append(i)
        }
    }
    
    return localMinIndices
}

func expandFromLocalMinIndex(_ localMinIndex: Int, _ scores: [Int], _  rewards: inout [Int])
{
    var leftIndex = localMinIndex - 1
    
    while leftIndex >= 0 && scores[leftIndex] > scores[leftIndex + 1]
    {
        rewards[leftIndex] = max(rewards[leftIndex], rewards[leftIndex + 1] + 1)
        leftIndex -= 1
    }
    
    var rightIndex = localMinIndex + 1
    
    while rightIndex < scores.count && scores[rightIndex] > scores[rightIndex - 1]
    {
        rewards[rightIndex] = rewards[rightIndex - 1] + 1
        rightIndex += 1
    }
}

//Solution #3
//O(n) time | O(n) space
func minRewardsThirdSolution(_ scores: [Int]) -> Int
{
    var rewards = Array(repeating: 1, count: scores.count)
    
    for i in stride(from: 1, to: scores.count, by: 1)
    {
        if scores[i] > scores[i - 1]
        {
            rewards[i] = rewards[i - 1] + 1
        }
    }
    
    for i in stride(from: scores.count - 2, through: 0, by: -1)
    {
        if scores[i] > scores[i + 1]
        {
            rewards[i] = max(rewards[i], rewards[i + 1] + 1)
        }
    }
    
    return rewards.reduce(0, { $0 + $1 })
}

//Tests
assert(minRewardsFirstSolution([1]) == 1)
assert(minRewardsFirstSolution([5, 10]) == 3)
assert(minRewardsFirstSolution([10, 5]) == 3)
assert(minRewardsFirstSolution([4, 2, 1, 3]) == 8)
assert(minRewardsFirstSolution([0, 4, 2, 1, 3]) == 9)
assert(minRewardsFirstSolution([8, 4, 2, 1, 3, 6, 7, 9, 5]) == 25)
assert(minRewardsFirstSolution([2, 20, 13, 12, 11, 8, 4, 3, 1, 5, 6, 7, 9, 0]) == 52)
assert(minRewardsFirstSolution([2, 1, 4, 3, 6, 5, 8, 7, 10, 9]) == 15)
assert(minRewardsFirstSolution([800, 400, 20, 10, 30, 60, 70, 90, 17, 21, 22, 13, 12, 11, 8, 4, 2, 1, 3, 6, 7, 9, 0, 68, 55, 67, 57, 60, 51, 661, 50, 65, 53]) == 93)

assert(minRewardsSecondSolution([1]) == 1)
assert(minRewardsSecondSolution([5, 10]) == 3)
assert(minRewardsSecondSolution([10, 5]) == 3)
assert(minRewardsSecondSolution([4, 2, 1, 3]) == 8)
assert(minRewardsSecondSolution([0, 4, 2, 1, 3]) == 9)
assert(minRewardsSecondSolution([8, 4, 2, 1, 3, 6, 7, 9, 5]) == 25)
assert(minRewardsSecondSolution([2, 20, 13, 12, 11, 8, 4, 3, 1, 5, 6, 7, 9, 0]) == 52)
assert(minRewardsSecondSolution([2, 1, 4, 3, 6, 5, 8, 7, 10, 9]) == 15)
assert(minRewardsSecondSolution([800, 400, 20, 10, 30, 60, 70, 90, 17, 21, 22, 13, 12, 11, 8, 4, 2, 1, 3, 6, 7, 9, 0, 68, 55, 67, 57, 60, 51, 661, 50, 65, 53]) == 93)

assert(minRewardsThirdSolution([1]) == 1)
assert(minRewardsThirdSolution([5, 10]) == 3)
assert(minRewardsThirdSolution([10, 5]) == 3)
assert(minRewardsThirdSolution([4, 2, 1, 3]) == 8)
assert(minRewardsThirdSolution([0, 4, 2, 1, 3]) == 9)
assert(minRewardsThirdSolution([8, 4, 2, 1, 3, 6, 7, 9, 5]) == 25)
assert(minRewardsThirdSolution([2, 20, 13, 12, 11, 8, 4, 3, 1, 5, 6, 7, 9, 0]) == 52)
assert(minRewardsThirdSolution([2, 1, 4, 3, 6, 5, 8, 7, 10, 9]) == 15)
assert(minRewardsThirdSolution([800, 400, 20, 10, 30, 60, 70, 90, 17, 21, 22, 13, 12, 11, 8, 4, 2, 1, 3, 6, 7, 9, 0, 68, 55, 67, 57, 60, 51, 661, 50, 65, 53]) == 93)
