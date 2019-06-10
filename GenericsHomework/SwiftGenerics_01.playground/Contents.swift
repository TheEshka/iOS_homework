protocol Additive{
    static func +(left:Self, right:Self)->Self
}


func sumTwoValues<T : Additive>(_ a: T, _ b: T) -> T {
    let result = a + b
    return result
}

extension String: Additive{}
extension Double: Additive{}
extension Array: Additive{}

extension Bool: Additive{
    static func +(left:Bool, right:Bool)->Bool{
        if left == true && right == true{
            return true
        }
        return false
    }
}

let a = 25.0
let b = 34.0
let resultDouble = sumTwoValues(a, b)
print(resultDouble)

let c = "ABC"
let d = "DEF"
let resultString = sumTwoValues(c, d)
print(resultString)

let e = [1,2,3,4]
let f = [4,5,6,7]
let resultArray = sumTwoValues(e, f)
print(resultArray)

let g = true
let h = false
let resultBool = sumTwoValues(g,h)
print(resultBool)
