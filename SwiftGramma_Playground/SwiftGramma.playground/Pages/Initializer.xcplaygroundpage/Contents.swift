import UIKit

// 이전 예제를 통해 Initializer에 대해 조금 더 살펴보도록 한다.
// 1. StudentAthlete Class

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

class Student: Person {
    var grades: [Grade] = []
    
    override init(firstName: String, lastName: String) {
        super.init(firstName: firstName, lastName: lastName)
    }
    
    convenience init(student: Student) {
        self.init(firstName: student.firstName, lastName: student.lastName)
    }
}

// 운동선수인 학생
class StudentAthelete: Student {
    var minimumTrainingTime: Int = 2
    var trainedTime: Int = 0
    var sports: [String]
    
    init(firstName: String, lastName: String, sports: [String]) {
        // Phase1
        // 본인을 포함하여, 부모 클래스까지 모든 Property를 세팅 해야한다.
        // 본인의 Property를 먼저 세팅하고, 부모의 Property를 세팅해야한다.
        self.sports = sports
        super.init(firstName: firstName, lastName: lastName)
        
        // Phase2
        // Phase1의 과정이 모두 종료되어야 메서드나 프로퍼티를 사용할 수 있다.
        self.train()
    }
    
    convenience init(name: String) {
        self.init(firstName: name, lastName: "", sports: [])
    }
    
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

let student1 = Student(firstName: "Jay", lastName: "Park")
let student2 = StudentAthelete(firstName: "Jay", lastName: "Park", sports: ["Football"])
let student3 = Student(student: student2)

// 자식 클래스의 Stored Property를 먼저 초기화하고, 부모 클래스의 Property를 초기화했다.
// 이처럼, 상속받은 클래스에서 새로운 Initialization을 사용하기 위해서는 일정 규칙을 따라야 한다.

// 2-phase Initialization
// phase 1.
// 1. 상속받은 클래스의 경우, 본인의 Stored Property와 부모 클래스의 Stored Property를 모두 초기화 해야한다.
// 2. 이 때, 상속받은 클래스의 Stored Property가 부모 클래스의 Stored Property보다 먼저 설정 되어야 한다.

// phase 2.
// 1. phase-1에서 모든 Stored Property를 세팅해주고 난 후, Property와 Method 사용이 가능하다.

// 이런 규칙이 없다면 Property가 세팅되지 않은 상태에서 Instance가 생성되고 메서드가 호출되기 때문에
// 원하는대로 동작하지 않고, 안정적인 프로그램을 동작시킬 수 없다.
