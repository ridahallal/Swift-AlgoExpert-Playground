//Topological Sort Solution #2

//Generic Job Node class
class JobNode
{
    //Has a job
    let job: Int
    
    //Has dependencies
    var dependencies: [JobNode]
    
    //Number of prerequisites
    var numberOfPrerequisites: Int
    
    init(job: Int)
    {
        self.job = job
        self.dependencies = [JobNode]()
        self.numberOfPrerequisites = 0
    }
}

//Generc Job Graph class
class JobGraph
{
    //Nodes array
    var nodes: [JobNode]
    
    //Nodes Dictionary (Job -> JobNode)
    var graph: [Int: JobNode]
    
    init(jobs: [Int])
    {
        self.nodes = [JobNode]()
        self.graph = [Int: JobNode]()
        
        //Initializer creates JobNodes
        for job in jobs
        {
            //And adds them to the array dna dictionary
            addNode(job: job)
        }
    }
    
    //Creates JobNodes and adds them to the JobGraph's array and dictionary
    func addNode(job: Int)
    {
        let jobNode = JobNode(job: job)
        
        nodes.append(jobNode)
        graph[job] = jobNode
    }
    
    //Adds a dependency job to a JobNode's dependencies array
    func addDependencyToJob(job: Int, dependency: Int)
    {
        //Get job node
        let jobNode = getNode(job: job)
        
        //Get dependency node
        let dependencyNode = getNode(job: dependency)
        
        //Add the prerequisite to the job's prerequisites array
        jobNode.dependencies.append(dependencyNode)
        
        //Increment the depencendy node's number of prerequisites
        dependencyNode.numberOfPrerequisites += 1
    }
    
    //Returns a node in the graph if it exists
    func getNode(job: Int) -> JobNode
    {
        if let node = graph[job]
        {
            return node
        }
        else
        {
            graph[job] = JobNode(job: job)
            return graph[job]!
        }
    }
}

//O(j + d) time | O(j + d) space
func topologicalSort(jobs: [Int], dependencies: [[Int]]) -> [Int]
{
    //Create the graph
    let jobGraph = createJobGraph(jobs: jobs, dependencies: dependencies)
    
    //Get ordered jobs
    return getOrderedJobs(jobGraph: jobGraph)
}

//Creates job graph with jobs, and
//adds a prerequisite to its jobs based on the dependencies we feed it
func createJobGraph(jobs: [Int], dependencies: [[Int]]) -> JobGraph
{
    let jobGraph = JobGraph(jobs: jobs)
    
    for dependency in dependencies
    {
        let job = dependency[0]
        let dep = dependency[1]
        jobGraph.addDependencyToJob(job: job, dependency: dep)
    }
    
    return jobGraph
}

//Returns the proper order for our jobs based on the given dependenceies
func getOrderedJobs(jobGraph: JobGraph) -> [Int]
{
    var orderedJobs = [Int]()
    var nodesWithNoPrerequisites = jobGraph.nodes.filter { $0.numberOfPrerequisites == 0 }
    
    while nodesWithNoPrerequisites.count > 0
    {
        if let jobNode = nodesWithNoPrerequisites.popLast()
        {
            orderedJobs.append(jobNode.job)
            removeDependencies(jobNode: jobNode, nodesWithNoPrerequisites: &nodesWithNoPrerequisites)
        }
    }
    
    let graphHasEdges = jobGraph.nodes.filter { $0.numberOfPrerequisites > 0 }.count > 0
    
    return graphHasEdges ? [] : orderedJobs
}

func removeDependencies(jobNode: JobNode, nodesWithNoPrerequisites: inout [JobNode])
{
    while jobNode.dependencies.count > 0
    {
        if let dependency = jobNode.dependencies.popLast()
        {
            dependency.numberOfPrerequisites -= 1
            
            if dependency.numberOfPrerequisites == 0
            {
                nodesWithNoPrerequisites.append(dependency)
            }
        }
    }
}

//Tests
func isValidTopologicalOrder(order: [Int], jobs: [Int], dependencies: [[Int]]) -> Bool
{
    var visited = [Int: Bool]()
    
    for candidate in order
    {
        for dependency in dependencies
        {
            let job = dependency[1]
            let prerequisite = dependency[0]
            
            if candidate == prerequisite && visited.keys.contains(job)
            {
                return false
            }
        }
        
        visited[candidate] = true
    }
    
    for job in jobs
    {
        if !visited.keys.contains(job)
        {
            return false
        }
    }
    
    return order.count == jobs.count
}

var jobs = [1, 2, 3, 4, 5, 6, 7, 8]
var dependencies = [[3, 1], [8, 1], [8, 7], [5, 7], [5, 2], [1, 4], [1, 6], [1, 2], [7, 6]]
var order = topologicalSort(jobs: jobs, dependencies: dependencies)
var isValid = isValidTopologicalOrder(order: order, jobs: jobs, dependencies: dependencies)
assert(isValid)

jobs = [1, 2, 3, 4, 5, 6, 7, 8]
dependencies = [[3, 1], [8, 1], [8, 7], [5, 7], [5, 2], [1, 4], [6, 7], [1, 2], [7, 6]]
order = topologicalSort(jobs: jobs, dependencies: dependencies)
assert(order == [])

jobs = [1, 2, 3, 4, 5, 6, 7, 8]
dependencies = [[3, 1], [8, 1], [8, 7], [5, 7], [5, 2], [1, 4], [1, 6], [1, 2], [7, 6], [4, 6], [6, 2], [2, 3]]
order = topologicalSort(jobs: jobs, dependencies: dependencies)
assert(order == [])

jobs = [1, 2, 3, 4, 5, 6, 7, 8]
dependencies = [[1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [6, 7], [7, 8], [8, 1]]
order = topologicalSort(jobs: jobs, dependencies: dependencies)
assert(order == [])

jobs = [1, 2, 3, 4, 5, 6, 7, 8, 9]
dependencies = [[1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [7, 6], [7, 8], [8, 1]]
order = topologicalSort(jobs: jobs, dependencies: dependencies)
isValid = isValidTopologicalOrder(order: order, jobs: jobs, dependencies: dependencies)
assert(isValid)

jobs = [1, 2, 3, 4, 5, 6, 7, 8]
dependencies = [[1, 2], [3, 5], [4, 6], [3, 6], [1, 7], [7, 8], [1, 8], [2, 8]]
order = topologicalSort(jobs: jobs, dependencies: dependencies)
isValid = isValidTopologicalOrder(order: order, jobs: jobs, dependencies: dependencies)
assert(isValid)

jobs = [1, 2, 3, 4, 5, 6, 7, 8]
dependencies = [
    [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
    [2, 8], [3, 8], [4, 8], [5, 8], [6, 8], [7, 8],
]
order = topologicalSort(jobs: jobs, dependencies: dependencies)
isValid = isValidTopologicalOrder(order: order, jobs: jobs, dependencies: dependencies)
assert(isValid)

jobs = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
dependencies = [
    [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
    [2, 8], [3, 8], [4, 8], [5, 8], [6, 8], [7, 8],
    [2, 3], [2, 4], [5, 4], [7, 6], [6, 2], [6, 3],
    [6, 5], [5, 9], [9, 8], [8, 0], [4, 0], [5, 0],
    [9, 0], [2, 0], [3, 9], [3, 10], [10, 11], [11, 12], [2, 12],
]
order = topologicalSort(jobs: jobs, dependencies: dependencies)
isValid = isValidTopologicalOrder(order: order, jobs: jobs, dependencies: dependencies)
assert(isValid)

jobs = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
dependencies = [
    [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
    [2, 8], [3, 8], [4, 8], [5, 8], [6, 8], [7, 8],
    [2, 3], [2, 4], [5, 4], [7, 6], [6, 2], [6, 3],
    [6, 5], [5, 9], [9, 8], [8, 0], [4, 0], [5, 0],
    [9, 0], [2, 0], [3, 9], [3, 10], [10, 11], [11, 12], [12, 2],
]
order = topologicalSort(jobs: jobs, dependencies: dependencies)
assert(order == [])

jobs = [1, 2, 3, 4]
dependencies = [[1, 2], [1, 3], [3, 2], [4, 2], [4, 3]]
order = topologicalSort(jobs: jobs, dependencies: dependencies)
isValid = isValidTopologicalOrder(order: order, jobs: jobs, dependencies: dependencies)
assert(isValid)

jobs = [1, 2, 3, 4, 5]
dependencies = []
order = topologicalSort(jobs: jobs, dependencies: dependencies)
isValid = isValidTopologicalOrder(order: order, jobs: jobs, dependencies: dependencies)
assert(isValid)

jobs = [1, 2, 3, 4, 5]
dependencies = [[1, 4], [5, 2]]
order = topologicalSort(jobs: jobs, dependencies: dependencies)
isValid = isValidTopologicalOrder(order: order, jobs: jobs, dependencies: dependencies)
assert(isValid)
