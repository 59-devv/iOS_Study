import UIKit

// Default Initializer
// 별도로 Initializer를 만들지 않고, 기본값을 설정할 수 있다.
class Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")


// 아래와 같이 Property에 직접 값을 설정해서 기본값을 설정할 수도 있다.
// 모든 Stored Property에 값이 지정된 경우, init() 함수는 사용하지 않아도 된다.
class Fahrenheit2 {
    var temperature: Double = 32.0
}
var f2 = Fahrenheit2()
print("The default temperature is \(f2.temperature)° Fahrenheit")


// Custom Initializer
// 아래와 같이 직접 값 파라미터로 받아서 설정해줄 수도 있다.
// 이 때 받는 이름이나 형태가 다르다면, 각각 다른 init() 함수로 정의할 수 있다.
class Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
print("default boilling point of water is \(boilingPointOfWater.temperatureInCelsius)")

let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print("default freezing point of water is \(freezingPointOfWater.temperatureInCelsius)")


// 아래와 같이 파라미터로 값을 받고, Property를 설정해줄 수도 있다.
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
var c1 = Color(red: 1.0, green: 0.0, blue: 1.0)
c1.red  // 1
c1.green  // 0
c1.blue  // 1

var c2 = Color(white: 1.5)
c2.red // 1.5
c2.green  // 1.5
c2.blue  // 1.5


// 파라미터에 Label을 제거하고 싶다면, _ 를 앞에 붙여주면 된다.
struct Color2 {
    let red, green, blue: Double
    init(_ red: Double, _ green: Double, _ blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}
var c3 = Color2(1.5, 1.0, 0.5)
c3.red  // 1.5
c3.green  // 1
c3.blue  // 0.5


// Property에 Optional Type을 사용할 수 있다.
// 아래의 경우, response를 Optional로 사용했고
// 이 경우 값이 없을 수도 있기 때문에, Initializer에 포함되지 않아도 된다.
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()  // "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."


// let 키워드를 통해 상수로 선언한 Property라도,
// 초기화 시에는 값을 정해줄 수 있다.
// 하지만, 초기화 이후에는 값을 수정할 수 없다.
class SurveyQuestion2 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion2(text: "How about beets?")
beetsQuestion.ask() // "How about beets?"
beetsQuestion.response
beetsQuestion.response = "I also like beets. (But not with cheese.)"
// beetsQuestion.text = "Can be changed?"  <-- 오류발생


// 값을 초기화 할 때 Stored Property에 Optional Type이 있으면, nil이 된다.
// Optional Type도 역시 init() 함수에 포함되지 않아도 된다.
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
item.name // nil
item.quantity  // 1
item.purchased  // false


// Structure에서는 init() 메서드를 사용하지 않아도 된다.
struct Size {
    var width: Double, height: Double
}
let twoByTwo = Size(width: 2.0, height: 2.0)
twoByTwo.width  // 2
twoByTwo.height  // 2

struct iPhone {
    var model: String
}


// Structure에서, 다른 Structure를 Property로 사용할 수 있다.
struct Size2 {
    var width = 10.0, height = 20.0
}

struct Point {
    var x = 5.0, y = 10.0
}


// 이 경우, 기본 생성자를 사용하기 위해서는 init() 함수를 만들어주어야 한다.
// 중괄호 안은 생략 가능하다.
struct Rect {
    var origin = Point()
    var size = Size2()
    init() {}
    init(origin: Point, size: Size2) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size2) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()
basicRect.origin.x  // 5
basicRect.size.width  // 10
