import UIKit

var stro = "FR MM      PO "
var desired = 90

extension String {
    subscript(i:Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(i:Int) -> String {
        return String(self[i] as Character)
    }
}





var gross = [[Int]]()
var sub = [Int]()

var str = Array(stro)

var conv = ""

for i in 0..<str.count {
    let r = str[i]
    print(r)
    
    
    if r == " " {
        conv += "X"
    } else {
        conv += "\(r)"
    }
}


var move = Array(conv)


for i in 0..<move.count {
    
    let w = move[i]
    
    if w == "X"{
        sub.append(i)
    } else {
        if sub.count > 0 {
            gross.append(sub)
            sub.removeAll()
        }
        
        
    }
}









var pos = [Int]()
var spacecount = [Int]()

for x in gross{
    pos.append(x[0])
    spacecount.append(desired / gross.count - x.count)
}




var copy = str

var mopy = copy.map {String($0)}

func prepareDashe(n: Int) -> String {
    var ret = ""
    if n != 0 {
        
        
        
        for i in 0..<n {
            ret += " "
        }
    }
    
    return ret
}




mopy = mopy.filter{$0 != " "}

for i in 0..<pos.count{
    let ct = spacecount[i]
    let prepared = prepareDashe(n: ct)
    
    print("Prep \(prepared.count) ATTTT \(pos[i])")
    // let r:Character = Character(prepared)
    mopy.insert(prepared, at: pos[i])
    
}



var final = ""
for i in 0..<mopy.count{
    final += mopy[i]
}

print(stro)
print(final)
