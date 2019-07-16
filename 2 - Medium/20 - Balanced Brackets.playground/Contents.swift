//Balanced Brackets
//O(n) time | O(n) space
func balancedBrackets(string: String) -> Bool
{
    let openingBrackets = "([{"
    let matchingBrackets: [Character: Character] = [")" : "(", "]" : "[", "}" : "{"]
    
    var stack = [Character]()
    
    for character in string
    {
        if openingBrackets.contains(character)
        {
            stack.append(character)
        }
        else
        {
            if string.count == 0
            {
                return false
            }
            else
            {
                if let lastCharacter = stack.last, lastCharacter == matchingBrackets[character]
                {
                    stack.popLast()
                }
                else
                {
                    return false
                }
            }
        }
    }
    
    return stack.count == 0
}

//Tests
assert(balancedBrackets(string: "()[]{}{") == false)
assert(balancedBrackets(string: "(((((({{{{{[[[[[([)])]]]]]}}}}}))))))") == false)
assert(balancedBrackets(string: "()()[{()})]") == false)
assert(balancedBrackets(string: "(()())((()()()))") == true)
assert(balancedBrackets(string: "{}()") == true)
assert(balancedBrackets(string: "()([])") == true)
assert(balancedBrackets(string: "((){{{{[]}}}})") == true)
assert(balancedBrackets(string: "([])(){}(())()()") == true)
assert(balancedBrackets(string: "((({})()))") == true)
assert(balancedBrackets(string: "(([]()()){})") == true)
assert(balancedBrackets(string: "(((((([[[[[[{{{{{{{{{{{{()}}}}}}}}}}}}]]]]]]))))))((([])({})[])[])[]([]){}(())") == true)
assert(balancedBrackets(string: "{[[[[({(}))]]]]}") == false)
assert(balancedBrackets(string: "[((([])([]){}){}){}([])[]((())") == false)
assert(balancedBrackets(string: ")[]}") == false)
