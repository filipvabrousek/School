import Foundation

extension String {
    subscript(i:Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(i:Int) -> String {
        return String(self[i] as Character)
    }
}



var desired = 27

var rt = "F      JE   TU"
// var rt = "AA I   U"
//var rt = "AA I   U "


var gross = [[Int]]()
var sub = [Int]()
var pos = [Int]()
var spacecount = [Int]()
var final = ""

if desired <= rt.count {
    final = "STRING IS TOO SHORT"
    
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






var move = Array(conv.map{String($0)})

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

var sf = [Int]()
for i in 0..<gross.count {
    var el = gross[i] // 1 díra
    print("SP \(abs(gross[i].count - desired / gross.count))")
    sf.append(abs(gross[i].count - desired / gross.count))
    //print("Počet mezer v díře \(el.count)")
    ci += el.count
}


let ro = round(Double(ci / gross.count))

for i in 0..<fiedl.count {
    print("K \(sf[i])  \(fiedl[i])")
    let str = String(sf[i])
    move.insert(str, at: fiedl[i])
}



for i in 0..<move.count {
    var el = move[i]
    var res = ""
    
    if let int = Int(el){
        print("INT \(int)")
        
        for x in 0..<int{
            res += "X"
            // print("FIX \(x)")
            move.remove(at: i)
            move.insert(res, at: i)
        }
        
    }
}






var savestr = ""
for i in 0..<move.count {
    savestr += move[i]
}

print(savestr)


let farr = Array(savestr)
var pres = ""


for i in 0..<savestr.count {
    if savestr[i] == "X"{
        pres += " "
    } else {
        pres += savestr[i]
    }
}

print("----------------------------")
print("Before \(rt.count)")
print("After \(pres.count)")
print(rt)
print(pres)
print("----------------------------")
