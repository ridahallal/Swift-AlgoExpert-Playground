//Generic Organizational Entity class
class OrganizationalEntity
{
    let name: String
    var directReports = [OrganizationalEntity]()
    
    init(name: String)
    {
        self.name = name
    }
    
    func addDirectReports(directReports: [OrganizationalEntity?])
    {
        for directReport in directReports
        {
            if let report = directReport
            {
                self.directReports.append(report)
            }
        }
    }
}

//O(n) time | O(d) space
func getLowestCommonManager(_ topManager: OrganizationalEntity, _ reportOne: OrganizationalEntity, _ reportTwo: OrganizationalEntity) -> OrganizationalEntity?
{
    return getOrganizationalInfo(topManager, reportOne, reportTwo).0
}

func getOrganizationalInfo(_ manager: OrganizationalEntity, _ reportOne: OrganizationalEntity, _ reportTwo: OrganizationalEntity) -> (OrganizationalEntity?, Int)
{
    var numberOfImportantReports = 0
    
    for directReport in manager.directReports
    {
        let organizationalInfo = getOrganizationalInfo(directReport, reportOne, reportTwo)
        
        //If we've previously found the lowest common manager, return it up the recursive chain
        if organizationalInfo.0 != nil
        {
            return organizationalInfo
        }
        
        //Add up the number of important reports we've previously calculated up the recursive chain
        numberOfImportantReports += organizationalInfo.1
    }
    
    if manager === reportOne || manager === reportTwo
    {
        numberOfImportantReports += 1
    }
    
    let lowestCommonManager = numberOfImportantReports == 2 ? manager : nil
    return (lowestCommonManager, numberOfImportantReports)
}

//Tests
var organizationalChart = [Character: OrganizationalEntity]()
var alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

for letter in alphabet
{
    organizationalChart[letter] = OrganizationalEntity(name: String(letter))
}

organizationalChart["A"]?.addDirectReports(directReports: [organizationalChart["B"], organizationalChart["C"], organizationalChart["D"], organizationalChart["E"], organizationalChart["F"]])
organizationalChart["B"]?.addDirectReports(directReports: [organizationalChart["G"], organizationalChart["H"], organizationalChart["I"]])
organizationalChart["C"]?.addDirectReports(directReports: [organizationalChart["J"]])
organizationalChart["D"]?.addDirectReports(directReports: [organizationalChart["K"], organizationalChart["L"]])
organizationalChart["F"]?.addDirectReports(directReports: [organizationalChart["M"], organizationalChart["N"]])
organizationalChart["H"]?.addDirectReports(directReports: [organizationalChart["O"], organizationalChart["P"], organizationalChart["Q"], organizationalChart["R"]])
organizationalChart["K"]?.addDirectReports(directReports: [organizationalChart["S"]])
organizationalChart["P"]?.addDirectReports(directReports: [organizationalChart["T"], organizationalChart["U"]])
organizationalChart["R"]?.addDirectReports(directReports: [organizationalChart["V"]])
organizationalChart["V"]?.addDirectReports(directReports: [organizationalChart["W"], organizationalChart["X"], organizationalChart["Y"]])
organizationalChart["X"]?.addDirectReports(directReports: [organizationalChart["Z"]])

let firstTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["A"]!, organizationalChart["B"]!)
assert(firstTest === organizationalChart["A"])

let secondTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["B"]!, organizationalChart["F"]!)
assert(secondTest === organizationalChart["A"])

let thirdTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["G"]!, organizationalChart["M"]!)
assert(thirdTest === organizationalChart["A"])

let fourthTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["U"]!, organizationalChart["S"]!)
assert(fourthTest === organizationalChart["A"])

let fifthTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["Z"]!, organizationalChart["M"]!)
assert(fifthTest === organizationalChart["A"])

let sixthTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["O"]!, organizationalChart["I"]!)
assert(sixthTest === organizationalChart["B"])

let seventhTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["T"]!, organizationalChart["Z"]!)
assert(seventhTest === organizationalChart["H"])

let eightthTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["T"]!, organizationalChart["V"]!)
assert(eightthTest === organizationalChart["H"])

let ninthTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["T"]!, organizationalChart["H"]!)
assert(ninthTest === organizationalChart["H"])

let tenthTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["W"]!, organizationalChart["V"]!)
assert(tenthTest === organizationalChart["V"])

let eleventhTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["Z"]!, organizationalChart["B"]!)
assert(eleventhTest === organizationalChart["B"])

let twelfthTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["Q"]!, organizationalChart["W"]!)
assert(twelfthTest === organizationalChart["H"])

let thirteenthTest = getLowestCommonManager(organizationalChart["A"]!, organizationalChart["A"]!, organizationalChart["Z"]!)
assert(thirteenthTest === organizationalChart["A"])
