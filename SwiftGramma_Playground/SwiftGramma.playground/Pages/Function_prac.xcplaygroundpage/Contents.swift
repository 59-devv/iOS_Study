import UIKit

// 1. 성, 이름을 받아서 풀네임을 출력하는 함수 만들기
func printFullName(lastName: String, firstName: String) {
    print("안녕하세요, \(lastName+firstName)님!")
}

printFullName(lastName: "홍", firstName: "길동")

// 2. 1번함수에서 파라미터 이름을 제거하기
func printFullName2(_ lastName: String, _ firstName: String) {
    print("안녕하세요, \(lastName+firstName)님!")
}

printFullName2("홍", "길동")

// 3. 성, 이름을 받아서 풀네임을 return 하기
func fullNameIs(lastName: String, firstName: String) -> String {
    let fullName: String = lastName + firstName
    return fullName
}

let name = fullNameIs(lastName: "김", firstName: "낙지")
print(name)
