import UIKit


extension String {
    subscript(i:Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(i:Int) -> String {
        return String(self[i] as Character)
    }
}


var str = "AAA   K O"
var desired = 15
var count = str.count


var rem = str
rem = str.components(separatedBy: " ").filter {!$0.isEmpty}.joined(separator: " ")

print(str)

var idx = [Int]()

for i in 0..<rem.count{
    if rem[i] == " " {
        idx.append(i)
    }
    
}



var arr = [String]()
var er = [String]()

for i in 0..<str.count {
    if str[i] != " " {
    arr.append(str[i])
    }
}


for i in 0..<arr.count{
    var space = ""
    
    if idx.contains(i){
        for n in 0..<desired - count {
            space += "-"
        }
         arr.insert(space, at: i)
    }
}



var sofi = ""

for el in arr {
    sofi += el
}


print(sofi.count)
print(sofi)

