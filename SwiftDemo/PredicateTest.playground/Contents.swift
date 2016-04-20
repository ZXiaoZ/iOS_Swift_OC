//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let count = 3_000_000_000_000
let countedThings = "stars in the Milky Way"
var naturalCount: String
switch count {
case 0:
    naturalCount = "no"
case 1...3:
    naturalCount = "a few"
case 4...9:
    naturalCount = "several"
case 10...99:
    naturalCount = "tens of"
case 100...999:
    naturalCount = "hundreds of"
case 1000...999_999:
    naturalCount = "thousands of"
default:
    naturalCount = "millions and millions of"
}
print("There are \(naturalCount) \(countedThings).")

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

let anotherPoint = (2, 0)
switch anotherPoint {
    case (let x, 0):
    print("on the x-axis with an x value of \(x)")
    case (0, let y):
    print("on the y-axis with a y value of \(y)")
    case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

//去除了字符串里的元字符
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
    switch character {
    case "a", "e", "i", "o", "u", " ":
        continue
    default:
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)

var newArr = [Int]()
var arr = [1,2,3,4,5,6]
a:while arr.count>0 {
    newArr.append(arr.first!)
    arr.removeFirst()

    var aValue = newArr.last!
    if aValue > 3 {
        print("\(aValue)")
        continue a
    }
}
print(newArr)

func match(text:String,regex:String) -> Bool {
    let regex = try! NSRegularExpression(pattern: regex, options: .AnchorsMatchLines)
    let match = regex.rangeOfFirstMatchInString(text, options: .ReportProgress, range:NSMakeRange(0, text.characters.count))
    if match.location != NSNotFound {
        return true
    }else{
        return false
    }
}

let testStr = "一./////22222$多项选择题"
let result = match(testStr, regex: "^[一,二,三,四,五,六,七,八,九,十].*多项选择题$")

enum QuestionTypeRegex:String {
    case choiceQuestion = "^[一,二,三,四,五,六,七,八,九,十].*单项选择题"
    case multipleChoiceQuestion = "^[一,二,三,四,五,六,七,八,九,十].*多项选择题"
    case trueOrFalseQuestion = "^[一,二,三,四,五,六,七,八,九,十].*判断题"
    case materialQuestion = "^[一,二,三,四,五,六,七,八,九,十].*材料题"
 
}

let type = QuestionTypeRegex.choiceQuestion.rawValue

func RandomID(typecode:Int) -> String {
    let uuid = NSUUID().UUIDString
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyMMddss"
    let dateString = dateFormatter.stringFromDate(NSDate())
    return "\(typecode)+"+dateString+"+"+uuid //41+16030350+A8B6B22C-DC01-4340-AFA1-594CC5765E8B
}

let intStr = "1. 问题内容"
let regExp = try! NSRegularExpression(pattern: "^[0-9]+", options:.AnchorsMatchLines)
let range = regExp.firstMatchInString(intStr, options: .ReportCompletion, range: NSMakeRange(0, intStr.characters.count))?.range
if range?.location != NSNotFound {
    
    let intNum = (intStr as NSString).substringWithRange(range!)
    print(intNum)
}


func match(text:String,regexs:[String]) -> Bool {
    for reg in regexs {
        let regex = try! NSRegularExpression(pattern: reg, options: .AnchorsMatchLines)
        let match = regex.rangeOfFirstMatchInString(text, options: .ReportProgress, range:NSMakeRange(0, text.characters.count))
        if match.location != NSNotFound {
            return true
        }
    }
    return false
}

match("11.ertt", regexs: ["^[0-9]"])

let stringAdding = "123"+"123" 
