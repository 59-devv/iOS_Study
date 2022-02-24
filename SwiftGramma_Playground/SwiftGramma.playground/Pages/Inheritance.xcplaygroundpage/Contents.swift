import UIKit

struct Grade {
    // A, B, C..
    var letter: Character
    // 점수
    var points: Double
    // 학점
    var credits: Double
}

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func printMyName() {
        print("My name is \(firstName) \(lastName)")
    }
}

class StudentWithoutInheritance {
    var grades: [Grade] = []

    var firstName: String
    var lastName: String

    init (firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

    func printMyName() {
        print("My name is \(firstName) \(lastName)")
    }
}


// 이 경우, 중복 코드를 제거하기 위해 상속의 개념을 사용할 수 있다.
// 모든 학생은 사람이기 때문에, 명제가 성립하여 상속을 사용할 수 있다.
class Student: Person {
    var grades: [Grade] = []
}

let person1 = Person(firstName: "Mars", lastName: "Bruno")
let student1 = Student(firstName: "Sheeran", lastName: "ED")

let math = Grade(letter: "A", points: 9.5, credits: 3)

person1.firstName  // "MARS"
student1.firstName  // "Sheeran"
student1.printMyName() // "My name is Sheeran ED"
student1.grades.append(math)
student1.grades.count  // 1


// 운동선수인 학생
class StudentAthelete: Student {
    var minimumTrainingTime: Int = 2
    var trainedTime: Int = 0
    
    func train() {
        trainedTime += 1
    }
}

// 운동선수 중, 축구선수인 학생
class FootballStudent: StudentAthelete {
    var footballTeam = "FC Swift"
    
    override func train() {
        trainedTime += 2
    }
}

// 현재 상속 구조
// Person > Student > StudentAthelete > FootballStudent

var athelete1 = StudentAthelete(firstName: "Yuna", lastName: "Kim")
var athelete2 = FootballStudent(firstName: "HeungMin", lastName: "Son")

athelete1.firstName  // "Yuna"
athelete2.firstName  // "HeungMin"

athelete1.grades.append(math)
athelete2.grades.append(math)

athelete1.minimumTrainingTime  // 2
athelete2.minimumTrainingTime  // 2

athelete2.footballTeam

athelete1.train()
athelete2.train()

athelete1.trainedTime  // 1
athelete2.trainedTime  // 2
