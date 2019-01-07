class U {
constructor(name, a, b){
this.name = name;
this.a = a;
this.b = b;
}
}

let arr = [
new U("Filip", 0, 20),
new U("Filip", 20, 30),
];

let f = arr.filter(x => x.b > 20);
console.log(f);
