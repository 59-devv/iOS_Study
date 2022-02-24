import UIKit

// Class와 Structure 비교
struct PersonStruct: Equatable {
    var firstName: String
    var lastName: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    // 인스턴스 메서드에서 Stored Property 수정을 위해
    // mutating 키워드 사용
    mutating func uppercaseName() {
        firstName = firstName.uppercased()
        lastName = lastName.uppercased()
    }
}

class PersonClass: Equatable {
    var firstName: String
    var lastName: String
    
    // Class는 아래와 같은 initializer를 생성해주어야 한다.
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    func uppercaseName() {
        firstName = firstName.uppercased()
        lastName = lastName.uppercased()
    }
    
    static func == (left: PersonClass, right: PersonClass) -> Bool {
        return left.firstName == right.firstName && left.lastName == right.lastName
    }
}

// Structure
var personStruct1 = PersonStruct(firstName: "Nine", lastName: "Five")
var personStruct2 = personStruct1

personStruct2.firstName = "YP"
personStruct2.firstName  // "YP"
personStruct1.firstName  // "Nine"


// Class
var personClass1 = PersonClass(firstName: "9", lastName: "5")
var personClass2 = personClass1

personClass2.firstName = "JS"
personClass2.firstName  // "JS"
personClass1.firstName  // "JS"

// Class 객체 2번을, 새로운 객체로 생성해주었을 때
personClass2 = PersonClass(firstName: "Cook", lastName: "Tim")
personClass1.firstName  // "JS"
personClass2.firstName  // "Cook"

// 다시 객체1이 객체2를 바라보게 했을 때
personClass1 = personClass2
personClass1.fullName  // "Cook Tim"
personClass2.fullName  // "Cook Tim"

personStruct1 == personStruct2
personStruct2.firstName = "Nine"
personStruct2.lastName = "Five"
personStruct1 == personStruct2

personClass1 == personClass2

// 언제 Structure를 사용해야 하는가?
// 1. 두 object가 같은지 다른지 비교할 경우
// 2. Copy된 각 객체들이 독립적인 상태를 가져야 하는 경우
// 3. 코드에서 오브젝트의 데이터를 여러 스레드에 걸쳐 사용할 경우.
//    각 객체에 여러 Thread가 접근했을 때, 잠재적인 위험이 존재
//    하지만 value type은 각 객체가 unique하기 때문에 안전하다.

// 언제 Class를 사용해야 하는가?
// 1. 두 object의 인스턴스 자체가 같음을 확인해야 할 때
// 2. 하나의 객체가 필요하고, 여러 대상에 의해 접근이 되고 변경이 필요한 경우
//    UIApplication <- 객체는 유일한 객체이기 때문에, 앱 내의 여러 object에 의해 접근된다.
//    이럴 때 class로 만들어준다.


// 무슨말인지 이해가 잘 가지 않는다면, 일단 Structure를 쓴다.
// 이 때, 문제가 발생하거나 Class로 바꿀 필요성을 느낀다면 Class로 바꿔주면 된다.
//
