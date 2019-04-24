import UIKit





extension String {
    subscript(i:Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(i:Int) -> String {
        return String(self[i] as Character)
    }
}



var desired = 14

var rt = "F  JE   TU"

var gross = [[Int]]()
var sub = [Int]()
var pos = [Int]()
var spacecount = [Int]()
var final = ""

if desired <= rt.count {
   // final = "STRING IS TOO SHORT"
  
}

var str = Array(rt)

var conv = ""

for i in 0..<str.count {
    let r = str[i]
    
    if r == " " {
        conv += "X"
    } else {
        conv += "\(r)"
    }
}






var move = Array(conv)

// Začátky děr
var e = ""
for i in 0..<move.count {
    let s = move[i]
    
    if s == "X"{
        e += "X"
        print("X is at \(i)")
    } else {
        e += "-"
        print("-")
    }
    
}




let fe = Array(e)


var fiedl = [Int]()

for i in 0..<fe.count - 1{
        let s = fe[i]
    if s == "X" && fe[i + 1] == "-"{
        print("OP\(i)")
        fiedl.append(i + 1)
    }
}

fiedl



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




var ci = 0
for i in 0..<gross.count {
    var el = gross[i] // 1 díra
    print("Počet mezer v díře \(el.count)")
    ci += el.count
}


let ro = round(Double(ci / gross.count))

ro
var strjj = "\(Int(ro))"
var enn = Character(strjj)
//let char = Character(ro)

for i in 0..<fiedl.count {
     move.insert(enn, at: fiedl[i])
}

move





// 14



print("Počet mezer je \(ci) po zvýšení \(desired - ci)")

let r = round(Double(ci / gross.count))

var addition = ""

for i in 0..<Int(r){
    addition += " "
}

print(addition.count)








for i in 0..<move.count {
    var el = move[i] // 1 díra
   // el
}


