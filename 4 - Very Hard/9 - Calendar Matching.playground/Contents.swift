//Calendar Matching
//O(c1 + c2) time | O(c1 + c2) space
func calendarMatching(_ calendar1: [[String]], _ dailyBounds1: [String], _ calendar2: [[String]], _ dailyBounds2: [String], _ meetingDuration: Int) -> [[String]]
{
    let updatedCalendar1 = updateCalendar(calendar1, dailyBounds1)
    let updatedCalendar2 = updateCalendar(calendar2, dailyBounds2)
    
    let mergedCalendar = mergeCalendars(updatedCalendar1, updatedCalendar2)
    let flattenedCalendar = flattenCalendar(mergedCalendar)
    
    return getMatchingAvailabilities(flattenedCalendar, meetingDuration)
}

func updateCalendar(_ calendar: [[String]], _ dailyBounds: [String]) -> [[Int]]
{
    let lowerBound = ["0:00", dailyBounds[0]]
    let upperBound = [dailyBounds[1], "23:59"]
    var updatedCalendar = [[String]]()
    
    updatedCalendar.append(lowerBound)
    updatedCalendar.append(contentsOf: calendar)
    updatedCalendar.append(upperBound)
    
    return updatedCalendar.map { $0.map { timeToMinutes($0) } }
}

func mergeCalendars(_ calendar1: [[Int]], _ calendar2: [[Int]]) -> [[Int]]
{
    var i = 0
    var j = 0
    var merged = [[Int]]()
    
    while i < calendar1.count && j < calendar2.count
    {
        let meeting1 = calendar1[i]
        let meeting2 = calendar2[j]
        
        if meeting1[0] < meeting2[0]
        {
            merged.append(meeting1)
            i += 1
        }
        else
        {
            merged.append(meeting2)
            j += 1
        }
    }
    
    while i < calendar1.count
    {
        merged.append(calendar1[i])
        i += 1
    }
    
    while j < calendar2.count
    {
        merged.append(calendar2[j])
        j += 1
    }
    
    return merged
}

func flattenCalendar(_ calendar: [[Int]]) -> [[Int]]
{
    let firstEntry = calendar[0]
    var flattened = [[Int]]()
    flattened.append(firstEntry)
    
    for currentMeeting in calendar
    {
        if let previousMeeting = flattened.last, let currentStart = currentMeeting.first, let currentEnd = currentMeeting.last, let previousStart = previousMeeting.first, let previousEnd = previousMeeting.last
        {
            if previousEnd >= currentStart
            {
                let newPreviousMeeting = [previousStart, max(previousEnd, currentEnd)]
                flattened[flattened.count - 1] = newPreviousMeeting
            }
            else
            {
                flattened.append(currentMeeting)
            }
        }
    }
    
    return flattened
}

func getMatchingAvailabilities(_ calendar: [[Int]], _ meetingDuration: Int) -> [[String]]
{
    var matchingAvailabilities = [[Int]]()
    
    for i in 1 ..< calendar.count
    {
        let start = calendar[i - 1][1]
        let end = calendar[i][0]
        
        let availabilityDuration = end - start
        if availabilityDuration >= meetingDuration
        {
            matchingAvailabilities.append([start, end])
        }
    }
    
    return matchingAvailabilities.map { $0.map { minutesToTime($0) } }
}

func timeToMinutes(_ string: String) -> Int
{
    let separatedComponents = string.split(separator: ":").map { Int($0) }
    
    if let hours = separatedComponents[0], let minutes = separatedComponents[1]
    {
        return (hours * 60) + minutes
    }
    
    return 0
}

func minutesToTime(_ minutes: Int) -> String
{
    var hours = (Double(minutes) / 60)
    hours = hours.rounded(.down)
    
    let mins = minutes % 60
    
    let hoursString = "\(Int(hours))"
    let minsString = mins < 10 ? "0" + "\(mins)" : "\(mins)"
    
    return hoursString + ":" + minsString
}

//Tests
var calendar1 = [["9:00", "10:30"], ["12:00", "13:00"], ["16:00", "18:00"]]
var dailyBounds1 = ["9:00", "20:00"]
var calendar2 = [["10:00", "11:30"], ["12:30", "14:30"], ["14:30", "15:00"], ["16:00", "17:00"]]
var dailyBounds2 = ["10:00", "18:30"]
var meetingDuration = 30
var expected = [["11:30", "12:00"], ["15:00", "16:00"], ["18:00", "18:30"]]
var result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)

calendar1 = [["9:00", "10:30"], ["12:00", "13:00"], ["16:00", "18:00"]]
dailyBounds1 = ["9:00", "20:00"]
calendar2 = [["10:00", "11:30"], ["12:30", "14:30"], ["14:30", "15:00"], ["16:00", "17:00"]]
dailyBounds2 = ["10:00", "18:30"]
meetingDuration = 45
expected = [["15:00", "16:00"]]
result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)

calendar1 = [["9:00", "10:30"], ["12:00", "13:00"], ["16:00", "18:00"]]
dailyBounds1 = ["8:00", "20:00"]
calendar2 = [["10:00", "11:30"], ["12:30", "14:30"], ["14:30", "15:00"], ["16:00", "17:00"]]
dailyBounds2 = ["7:00", "18:30"]
meetingDuration = 45
expected = [["8:00", "9:00"], ["15:00", "16:00"]]
result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)

calendar1 = [["8:00", "10:30"], ["11:30", "13:00"], ["14:00", "16:00"], ["16:00", "18:00"]]
dailyBounds1 = ["8:00", "18:00"]
calendar2 = [["10:00", "11:30"], ["12:30", "14:30"], ["14:30", "15:00"], ["16:00", "17:00"]]
dailyBounds2 = ["7:00", "18:30"]
meetingDuration = 15
expected = []
result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)

calendar1 = [["10:00", "10:30"], ["10:45", "11:15"], ["11:30", "13:00"], ["14:15", "16:00"], ["16:00", "18:00"]]
dailyBounds1 = ["9:30", "20:00"]
calendar2 = [["10:00", "11:00"], ["12:30", "13:30"], ["14:30", "15:00"], ["16:00", "17:00"]]
dailyBounds2 = ["9:00", "18:30"]
meetingDuration = 15
expected = [["9:30", "10:00"], ["11:15", "11:30"], ["13:30", "14:15"], ["18:00", "18:30"]]
result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)

calendar1 = [["10:00", "10:30"], ["10:45", "11:15"], ["11:30", "13:00"], ["14:15", "16:00"], ["16:00", "18:00"]]
dailyBounds1 = ["9:30", "20:00"]
calendar2 = [["10:00", "11:00"], ["10:30", "20:30"]]
dailyBounds2 = ["9:00", "22:30"]
meetingDuration = 60
expected = []
result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)

calendar1 = [["10:00", "10:30"], ["10:45", "11:15"], ["11:30", "13:00"], ["14:15", "16:00"], ["16:00", "18:00"]]
dailyBounds1 = ["9:30", "20:00"]
calendar2 = [["10:00", "11:00"], ["10:30", "16:30"]]
dailyBounds2 = ["9:00", "22:30"]
meetingDuration = 60
expected = [["18:00", "20:00"]]
result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)

calendar1 = []
dailyBounds1 = ["9:30", "20:00"]
calendar2 = []
dailyBounds2 = ["9:00", "16:30"]
meetingDuration = 60
expected = [["9:30", "16:30"]]
result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)

calendar1 = []
dailyBounds1 = ["9:00", "16:30"]
calendar2 = []
dailyBounds2 = ["9:30", "20:00"]
meetingDuration = 60
expected = [["9:30", "16:30"]]
result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)

calendar1 = []
dailyBounds1 = ["9:30", "16:30"]
calendar2 = []
dailyBounds2 = ["9:30", "16:30"]
meetingDuration = 60
expected = [["9:30", "16:30"]]
result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)

calendar1 = [["7:00", "7:45"], ["8:15", "8:30"], ["9:00", "10:30"], ["12:00", "14:00"], ["14:00", "15:00"], ["15:15", "15:30"], ["16:30", "18:30"], ["20:00", "21:00"]]
dailyBounds1 = ["6:30", "22:00"]
calendar2 = [["9:00", "10:00"], ["11:15", "11:30"], ["11:45", "17:00"], ["17:30", "19:00"], ["20:00", "22:15"]]
dailyBounds2 = ["8:00", "22:30"]
meetingDuration = 30
expected = [["8:30", "9:00"], ["10:30", "11:15"], ["19:00", "20:00"]]
result = calendarMatching(calendar1, dailyBounds1, calendar2, dailyBounds2, meetingDuration)
assert(result == expected)
