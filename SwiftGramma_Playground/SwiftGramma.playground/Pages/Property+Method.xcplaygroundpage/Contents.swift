import UIKit

// Computed property가 하는 역할이 사실 Method와 동일하기도 하다
// 아래 코드를 보면,
struct Person {
    var firstName: String
    var lastName: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    func fullNameFunction() -> String {
        return "\(firstName) \(lastName)"
    }
}

let person = Person(firstName: "Nine", lastName: "Five")
person.fullName  // "Nine Five"
person.fullNameFunction()  // "Nine Five"

// 그렇다면, 언제 Computed property를 쓰고 언제 Method를 사용하는 것이 좋을까?
// 정답은 없지만, 개인적으로 일정한 규칙을 정해서 사용하는 것이 좋을 수 있다.
// * Setter가 필요한지 여부에 따라 결정
    // Setter가 필요하다 : Computed Property
    // Setter가 필요없다
        // 계산이 많이 필요하거나, DB 접근이 필요하다 : Method
        // 계산이 많이 필요하지 않고, DB 접근이 필요없다 : Computed Property
