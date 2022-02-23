import UIKit

// 프로퍼티 실습

// Stored Property
struct Person {
    var firstName: String
    var lastName: String
}

var person = Person(firstName: "Nine", lastName: "Five")
person.firstName // "Nine"
person.lastName  // "Five"

person.firstName = "9"
person.lastName = "5"
person.firstName  // "9"
person.lastName  // "5"


// Computed Property
struct SecondPerson {
    var firstName: String
    var lastName: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

var secondPerson = SecondPerson(firstName: "Nine", lastName: "Five")
secondPerson.firstName // "Nine"
secondPerson.lastName  // "Five"
secondPerson.fullName  // "Nine Five"

secondPerson.firstName = "9"
secondPerson.lastName = "5"
secondPerson.fullName  // "9 5

// fullName은 수정이 불가능하다.
// 이 때, 수정이 가능하도록 만들기 위해서는 'Getter, Setter'를 만들어주어야 한다.
struct ThirdPerson {
    var firstName: String
    var lastName: String
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
        
        set {
            if let firstName = newValue.split(separator: " ").first {
                self.firstName = String(firstName)
            }
            if let lastName = newValue.components(separatedBy: " ").last {
                self.lastName = lastName
            }
            
        }
    }
}

var thirdPerson = ThirdPerson(firstName: "Nine", lastName: "Five")

thirdPerson.firstName // "Nine"
thirdPerson.lastName  // "Five"
thirdPerson.fullName  // "Nine Five"

thirdPerson.fullName = "9 5"
thirdPerson.firstName  // "9"
thirdPerson.lastName  // "5"
thirdPerson.fullName  // "9 5"


// Type Property
// : 인스턴스 생성과 상관없이, Structure(Class)의 자체 속성을 정하고 싶을 때 사용한다.
// : static let 을 이용해서 선언한다.
struct TypePropertyPerson {
    var firstName: String
    var lastName: String
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
        
        set {
            if let firstName = newValue.split(separator: " ").first {
                self.firstName = String(firstName)
            }
            if let lastName = newValue.components(separatedBy: " ").last {
                self.lastName = lastName
            }
        }
    }
    
    static let isAlien: Bool = false
}

// 인스턴스 생성과 상관없이, Structure 그 자체의 속성을 나타낸다.
TypePropertyPerson.isAlien  // "false"


// 고급 기능
// 1. Observar 추가 (didSet, willSet)
    // Observer는 Stored Property 에서만 사용 가능하다.
// 2. lazy property
    // lazy를 붙이지 않을 경우, 인스턴스가 생성되면 모든 stored property가 실행된다.
    // 하지만 lazy를 붙일 경우에는 인스턴스 생성시가 아닌, 접근할 때 생성된다.
struct FourthPerson {
    var firstName: String {
        didSet {
            print("이름이 \(oldValue)에서 \(firstName)로 바뀌었습니다. ")
        }
        willSet {
            print("이름이 \(firstName)에서 \(newValue)로 바뀔 예정입니다.")
        }
    }
    
    lazy var isPopular: Bool = {
        if fullName == "Jay Park" {
            print("유명해요")
            return true
        } else {
            print("듣보잡")
            return false
        }
    }()
    
    var lastName: String
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
        
        set {
            if let firstName = newValue.split(separator: " ").first {
                self.firstName = String(firstName)
            }
            if let lastName = newValue.components(separatedBy: " ").last {
                self.lastName = lastName
            }
        }
    }
}
var fourthPerson = FourthPerson(firstName: "Nine", lastName: "Five")
fourthPerson.firstName = "9"  //  "이름이 Nine에서 9로 바뀌었습니다."
fourthPerson.fullName = "Jay Park"
fourthPerson.firstName
fourthPerson.lastName
fourthPerson.fullName
fourthPerson.isPopular  // "true"
