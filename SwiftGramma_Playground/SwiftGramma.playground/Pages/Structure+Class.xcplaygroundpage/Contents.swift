// Cat Class생성
class Cat {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


let cat1 = Cat(name: "오키", age: 2)
let cat2 = cat1
cat2.name = "도키"
cat1.name
cat2.name

// 위 내용에서 확인할 수 있듯, cat2의 이름을 바꾸었으나 cat1의 이름도 함께 바뀌었다.
// 즉, Class는 Reference Type(참조 타입) 이기 때문에 생성된 변수를 공유하여 사용한다.


// Structure 생성
struct CatStruct {
    var name: String
    var age: Int
}

var cat3 = CatStruct(name: "오키", age: 2)
var cat4 = cat3
cat4.name = "도키"
cat3.name
cat4.name

// Class와 다르게, Structure는 Value Type(값 타입) 이기 때문에, 변수를 복사해서 사용한다.
// 복사된 변수는 기존 변수와 다른 주소를 가지기 때문에 다른 변수이다.
// 따라서, cat4의 이름을 변경하여도 cat3에는 전혀 영향이 없다.

