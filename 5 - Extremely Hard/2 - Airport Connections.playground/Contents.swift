//Generic Airport Node Class
class AirportNode: CustomStringConvertible
{
    let airportCode: String
    var isReachable = true
    var directConnections = [String]()
    var allChildConnections = [String]()
    
    init(_ airportCode: String)
    {
        self.airportCode = airportCode
    }
    
    var description: String
    {
        return "Airport Code: \(airportCode), Is Reachable: \(isReachable), Direct Connections: \(directConnections), All Child Connections: \(allChildConnections)"
    }
}

//Airport Connections
//O(a * (a + r) + (a + r) + alog(a)) time | O(a + r) space
func airportConnections(_ airports: [String], _ routes: [[String]], _ startingAirport: String) -> Int
{
    var airportGraph = createAirportGraph(airports, routes)
    var unreachableAirportNodes = getUnreachableAirportNodes(airports, &airportGraph, startingAirport)
    addChildrenToUnreachableAirportNodes(airportGraph, unreachableAirportNodes)
    
    return getMinimumNumberOfNewConnections(&airportGraph, &unreachableAirportNodes)
}

//O(a + r) time | O(a + r) space
func createAirportGraph(_ airports: [String], _ routes: [[String]]) -> [String: AirportNode]
{
    var airportGraph = [String: AirportNode]()
    
    for airportCode in airports
    {
        airportGraph[airportCode] = AirportNode(airportCode)
    }
    
    for route in routes
    {
        let origin = route[0]
        let destination = route[1]
        
        if let airportNode = airportGraph[origin]
        {
            airportNode.directConnections.append(destination)
            airportGraph[origin] = airportNode
        }
    }
    
    return airportGraph
}

//O(a + r) time | O(a) space
func getUnreachableAirportNodes(_ airports: [String], _ airportsGraph: inout [String: AirportNode], _ startingAirport: String) -> [AirportNode]
{
    var visitedAirports = [String: Bool]()
    depthFirstTraverseAirports(airportsGraph, startingAirport, &visitedAirports)
    
    var unreachableAirportNodes = [AirportNode]()
    for airportCode in airports
    {
        if visitedAirports.keys.contains(airportCode)
        {
            continue
        }
        
        if let airportNode = airportsGraph[airportCode]
        {
            airportNode.isReachable = false
            airportsGraph[airportCode] = airportNode
            unreachableAirportNodes.append(airportNode)
        }
    }
    
    return unreachableAirportNodes
}

func depthFirstTraverseAirports(_ airportsGraph: [String: AirportNode], _ airport: String, _ visitedAirports: inout [String: Bool])
{
    if visitedAirports.keys.contains(airport)
    {
        return
    }
    
    visitedAirports[airport] = true
    
    if let airportNode = airportsGraph[airport]
    {
        let directConnections = airportNode.directConnections
        
        for connection in directConnections
        {
            depthFirstTraverseAirports(airportsGraph, connection, &visitedAirports)
        }
    }
}

//O(a * (a + r)) time | O(a) space
func addChildrenToUnreachableAirportNodes(_ airportsGraph: [String: AirportNode], _ unreachableAirportNodes: [AirportNode])
{
    for airportNode in unreachableAirportNodes
    {
        var visitedAirports = [String: Bool]()
        var childConnections = [String]()
        let airportCode = airportNode.airportCode
        
        depthFirstAddChildConnections(airportCode, airportsGraph, &visitedAirports, &childConnections)
        airportNode.allChildConnections = childConnections
    }
}

func depthFirstAddChildConnections(_ airportCode: String, _ airportsGraph: [String: AirportNode], _ visitedAirports: inout [String: Bool], _ childConnections: inout [String])
{
    if visitedAirports.keys.contains(airportCode)
    {
        return
    }
    
    if let airportNode = airportsGraph[airportCode], airportNode.isReachable
    {
        return
    }
    
    visitedAirports[airportCode] = true
    childConnections.append(airportCode)
    
    if let airportNode = airportsGraph[airportCode]
    {
        let directConnections = airportNode.directConnections
        
        for connection in directConnections
        {
            depthFirstAddChildConnections(connection, airportsGraph, &visitedAirports, &childConnections)
        }
    }
}

//O(alog(a) + a + r) time | O(1) space
func getMinimumNumberOfNewConnections(_ airportGraph: inout [String: AirportNode], _ unreachableAirportNodes: inout [AirportNode]) -> Int
{
    var numberOfNewConnections = 0
    unreachableAirportNodes = unreachableAirportNodes.sorted(by: { $0.allChildConnections.count > $1.allChildConnections.count })
    
    for airportNode in unreachableAirportNodes
    {
        if airportNode.isReachable
        {
            continue
        }
        
        numberOfNewConnections += 1
        
        for child in airportNode.allChildConnections
        {
            if let airportNode = airportGraph[child]
            {
                airportNode.isReachable = true
                airportGraph[child] = airportNode
            }
        }
    }
    
    return numberOfNewConnections
}

//Tests
let STARTING_AIRPORT = "LGA"

let AIRPORTS = [
    "BGI",
    "CDG",
    "DEL",
    "DOH",
    "DSM",
    "EWR",
    "EYW",
    "HND",
    "ICN",
    "JFK",
    "LGA",
    "LHR",
    "ORD",
    "SAN",
    "SFO",
    "SIN",
    "TLV",
    "BUD",
]

let firstRoutes = [[String]]()
airportConnections(AIRPORTS, firstRoutes, STARTING_AIRPORT)

let secondRoutes = [
    ["LGA", "DSM"],
    ["LGA", "ORD"],
    ["LGA", "EYW"],
]
airportConnections(AIRPORTS, secondRoutes, STARTING_AIRPORT)

let thirdRoutes = [
    ["LGA", "DSM"],
    ["DSM", "ORD"],
    ["LGA", "EYW"],
    ["EYW", "JFK"],
    ["EYW", "EWR"],
    ["JFK", "ICN"],
]
airportConnections(AIRPORTS, thirdRoutes, STARTING_AIRPORT)

let fourthRoutes = [
    ["LGA", "DSM"],
    ["DSM", "ORD"],
    ["LGA", "EYW"],
    ["EYW", "JFK"],
    ["EYW", "EWR"],
    ["JFK", "ICN"],
    ["LGA", "ICN"],
    ["ICN", "ORD"],
    ["ICN", "EWR"],
    ["JFK", "DSM"],
]
airportConnections(AIRPORTS, fourthRoutes, STARTING_AIRPORT)

let fiftRoutes = [
    ["LGA", "DSM"],
    ["DSM", "ORD"],
    ["LGA", "EYW"],
    ["EYW", "JFK"],
    ["EYW", "EWR"],
    ["JFK", "ICN"],
    ["LGA", "ICN"],
    ["ICN", "ORD"],
    ["ICN", "EWR"],
    ["JFK", "DSM"],
    ["ICN", "JFK"],
    ["ORD", "DSM"],
    ["DSM", "LGA"],
    ["JFK", "LGA"],
    ["JFK", "HND"],
]
airportConnections(AIRPORTS, fiftRoutes, STARTING_AIRPORT)

let sixthRoutes = [
    ["LGA", "DSM"],
    ["DSM", "ORD"],
    ["LGA", "EYW"],
    ["EYW", "JFK"],
    ["EYW", "EWR"],
    ["JFK", "ICN"],
    ["LGA", "ICN"],
    ["ICN", "ORD"],
    ["ICN", "EWR"],
    ["JFK", "DSM"],
    ["ICN", "JFK"],
    ["ORD", "DSM"],
    ["DSM", "LGA"],
    ["JFK", "LGA"],
    ["JFK", "HND"],
    ["SFO", "SIN"],
    ["SFO", "CDG"],
    ["SFO", "LHR"],
    ["LHR", "DEL"],
    ["DEL", "BGI"],
    ["DEL", "DOH"],
    ["DOH", "SAN"],
]
airportConnections(AIRPORTS, sixthRoutes, STARTING_AIRPORT)

let seventhRoutes = [
    ["LGA", "DSM"],
    ["DSM", "ORD"],
    ["EYW", "JFK"],
    ["EYW", "EWR"],
    ["JFK", "ICN"],
    ["LGA", "ICN"],
    ["ICN", "ORD"],
    ["ICN", "EWR"],
    ["JFK", "DSM"],
    ["ICN", "JFK"],
    ["ORD", "DSM"],
    ["DSM", "LGA"],
    ["JFK", "LGA"],
    ["JFK", "HND"],
    ["SFO", "SIN"],
    ["SFO", "CDG"],
    ["SFO", "LHR"],
    ["LHR", "DEL"],
    ["DEL", "BGI"],
    ["DEL", "DOH"],
    ["DOH", "SAN"],
]
airportConnections(AIRPORTS, seventhRoutes, STARTING_AIRPORT)

let eighthRoutes = [
    ["LGA", "DSM"],
    ["SIN", "BGI"],
    ["SIN", "CDG"],
    ["SIN", "DEL"],
    ["SIN", "DOH"],
    ["SIN", "DSM"],
    ["SIN", "EWR"],
    ["SIN", "EYW"],
    ["SIN", "HND"],
    ["SIN", "ICN"],
    ["SIN", "JFK"],
    ["SIN", "LHR"],
    ["SIN", "ORD"],
    ["SFO", "SIN"],
    ["SFO", "SAN"],
]
airportConnections(AIRPORTS, eighthRoutes, STARTING_AIRPORT)

let ninthRoutes = [
    ["LGA", "DSM"],
    ["DSM", "ORD"],
    ["SIN", "BGI"],
    ["SIN", "CDG"],
    ["CDG", "DEL"],
    ["DEL", "DOH"],
    ["DEL", "CDG"],
    ["DEL", "EWR"],
    ["HND", "ICN"],
    ["ICN", "JFK"],
    ["JFK", "LGA"],
    ["JFK", "SFO"],
    ["EYW", "LHR"],
    ["SFO", "ORD"],
    ["SFO", "LGA"],
]
airportConnections(AIRPORTS, ninthRoutes, STARTING_AIRPORT)

let tenthRoutes = [
    ["LGA", "DSM"],
    ["DSM", "ORD"],
    ["SIN", "BGI"],
    ["SIN", "CDG"],
    ["CDG", "DEL"],
    ["DEL", "DOH"],
    ["DEL", "CDG"],
    ["DEL", "EWR"],
    ["HND", "ICN"],
    ["ICN", "JFK"],
    ["JFK", "LGA"],
    ["JFK", "SFO"],
    ["EYW", "LHR"],
    ["SFO", "ORD"],
    ["SFO", "LGA"],
    ["SFO", "SIN"],
    ["CDG", "EYW"],
    ["LGA", "SAN"],
]
airportConnections(AIRPORTS, tenthRoutes, STARTING_AIRPORT)

let eleventhRoutes = [
    ["LGA", "DSM"],
    ["DSM", "ORD"],
    ["SIN", "BGI"],
    ["SIN", "CDG"],
    ["CDG", "DEL"],
    ["DEL", "DOH"],
    ["DEL", "CDG"],
    ["DEL", "EWR"],
    ["HND", "ICN"],
    ["ICN", "JFK"],
    ["JFK", "LGA"],
    ["JFK", "SFO"],
    ["EYW", "LHR"],
    ["SFO", "ORD"],
    ["SFO", "LGA"],
    ["SFO", "SIN"],
    ["CDG", "EYW"],
    ["ORD", "HND"],
    ["HND", "SAN"],
    ["LGA", "TLV"],
    ["LGA", "BUD"],
]
airportConnections(AIRPORTS, eleventhRoutes, STARTING_AIRPORT)

let twelfthRoutes = [
    ["DSM", "ORD"],
    ["ORD", "BGI"],
    ["BGI", "LGA"],
    ["SIN", "CDG"],
    ["CDG", "DEL"],
    ["DEL", "DOH"],
    ["DOH", "SIN"],
    ["EWR", "HND"],
    ["HND", "ICN"],
    ["ICN", "JFK"],
    ["JFK", "LGA"],
    ["EYW", "LHR"],
    ["LHR", "SFO"],
    ["SFO", "SAN"],
    ["SAN", "EYW"],
]
airportConnections(AIRPORTS, twelfthRoutes, STARTING_AIRPORT)

let thirteenthRoutes = [
    ["DSM", "ORD"],
    ["ORD", "BGI"],
    ["BGI", "LGA"],
    ["SIN", "CDG"],
    ["CDG", "DEL"],
    ["DEL", "DOH"],
    ["DOH", "SIN"],
    ["EWR", "HND"],
    ["HND", "ICN"],
    ["ICN", "JFK"],
    ["JFK", "LGA"],
    ["EYW", "LHR"],
    ["LHR", "SFO"],
    ["SFO", "SAN"],
    ["SFO", "ORD"],
    ["SAN", "EYW"],
]
airportConnections(AIRPORTS, thirteenthRoutes, STARTING_AIRPORT)

let fourteenthRoutes = [
    ["DSM", "ORD"],
    ["ORD", "BGI"],
    ["BGI", "LGA"],
    ["SIN", "CDG"],
    ["CDG", "DEL"],
    ["DEL", "DOH"],
    ["DOH", "SIN"],
    ["EWR", "HND"],
    ["HND", "ICN"],
    ["ICN", "JFK"],
    ["JFK", "LGA"],
    ["EYW", "LHR"],
    ["LHR", "SFO"],
    ["SFO", "SAN"],
    ["SFO", "DSM"],
    ["SAN", "EYW"],
]
airportConnections(AIRPORTS, fourteenthRoutes, STARTING_AIRPORT)

let fifteenthRoutes = [
    ["DSM", "ORD"],
    ["ORD", "BGI"],
    ["BGI", "LGA"],
    ["SIN", "CDG"],
    ["CDG", "SIN"],
    ["CDG", "BUD"],
    ["DEL", "DOH"],
    ["DEL", "CDG"],
    ["TLV", "DEL"],
    ["EWR", "HND"],
    ["HND", "ICN"],
    ["HND", "JFK"],
    ["ICN", "JFK"],
    ["JFK", "LGA"],
    ["EYW", "LHR"],
    ["LHR", "SFO"],
    ["SFO", "SAN"],
    ["SFO", "DSM"],
    ["SAN", "EYW"],
]
airportConnections(AIRPORTS, fifteenthRoutes, STARTING_AIRPORT)
