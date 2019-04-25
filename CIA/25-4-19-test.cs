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

var rt = "F       JE   TU"
//var rt = "AA I   U"
//var rt = "HOH OI    OU    O      O "

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

var sf = [Int]()
for i in 0..<gross.count {
    var el = gross[i] // 1 díra
    print("SP \(abs(gross[i].count - desired / gross.count))")
    sf.append(abs(gross[i].count - desired / gross.count))
    //print("Počet mezer v díře \(el.count)")
    ci += el.count
}
gross
sf

let ro = round(Double(ci / gross.count))




for i in 0..<fiedl.count {
    print("K \(sf[i])  \(fiedl[i])")
    
    let str = String(sf[i])
  
 //   let r = Character(s)
   // var strjj = "\(Int(sf[i]))"
   // var enn = Character(strjj)
    move.insert(str, at: fiedl[i])
}

move


// move = move.map{String($0)}

for i in 0..<move.count {
    var el = move[i]
  
    if el == "1"{
        move.remove(at: i)
        move.insert("X", at: i)
        //move.insert("  ", at: i)
    }
    
    if el == "2"{
        move.remove(at: i)
        move.insert("XX", at: i)
        //move.insert("  ", at: i)
    }
    
    if el == "3"{
        move.remove(at: i)
        move.insert("XXX", at: i)
        //move.insert("  ", at: i)
    }
    
    if el == "4"{
        move.remove(at: i)
        move.insert("XXXX", at: i)
        //move.insert("  ", at: i)
    }
    
    
    if el == "5"{
        move.remove(at: i)
        move.insert("XXXXX", at: i)
        //move.insert("  ", at: i)
    }
    
    
    if el == "6"{
        move.remove(at: i)
        move.insert("XXXXXX", at: i)
        //move.insert("  ", at: i)
    }
    
    if el == "7"{
        move.remove(at: i)
        move.insert("XXXXXXX", at: i)
        //move.insert("  ", at: i)
    }
    
    if el == "8"{
        move.remove(at: i)
        move.insert("XXXXXXXX", at: i)
        //move.insert("  ", at: i)
    }
    
    
    if el == "9"{
        move.remove(at: i)
        move.insert("XXXXXXXXX", at: i)
        //move.insert("  ", at: i)
    }
    

    
    if el == "10"{
        move.remove(at: i)
        move.insert("XXXXXXXXXX", at: i)
        //move.insert("  ", at: i)
    }
    
    if el == "11"{
        move.remove(at: i)
        move.insert("XXXXXXXXXXX", at: i)
        //move.insert("  ", at: i)
    }
    
    if el == "12"{
        move.remove(at: i)
        move.insert("XXXXXXXXXXXX", at: i)
        //move.insert("  ", at: i)
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
