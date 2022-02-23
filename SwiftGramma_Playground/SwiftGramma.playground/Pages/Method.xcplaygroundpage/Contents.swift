import UIKit

// Method 학습

struct Lecture {
    var title: String
    var maxStudents: Int = 10
    var numOfRegistered: Int = 0
    
    func remainSeats() -> Int {
        let remainSeats = maxStudents - numOfRegistered
        return remainSeats
    }
    
    // Structure 내부의 Stored Property를 변경시키는 Method의 경우,
    // func 앞에 mutating 을 적어주어야 한다.
    mutating func register() {
        numOfRegistered += 1
    }
    
    // Type Property
    static let target: String = "Anybody want to learn something"
    
    // Type Method
    static func schoolName() -> String {
        return "FC"
    }
}

var lec = Lecture(title: "iOS Basic")

lec.remainSeats()  // 10
lec.register()  // Lecture
lec.remainSeats() // 9
Lecture.target  // "Anybody want to learn something"
Lecture.schoolName()  // "FC"


// 메서드 확장해보기
struct Math {
    static func abs(value: Int) -> Int {
        if value > 0 {
            return value
        } else {
            return -value
        }
    }
}

Math.abs(value: -20)  // 20

// extension으로 메서드 확장하기
// Math Structure 내부에 무언가 넣는게 꼭 정답은 아니기 때문에,
// 외부에서 선언하게 될 경우 extension을 사용해서 확장할 수 있다.
extension Math {
    static func square(value: Int) -> Int {
        return value*value
    }
    
    static func half(value: Int) -> Int {
        return value / 2
    }
}

Math.square(value: 5)  // 25
Math.half(value: 20)  // 10

// Swift에 만들어진 Structure를 확장시킬 수도 있다.
extension Int {
    func square() -> Int {
        return self * self
    }
    
    func half() -> Int {
        return self / 2
    }
}

var value: Int = 4
value.square()  // 16
value.half()  // 2

