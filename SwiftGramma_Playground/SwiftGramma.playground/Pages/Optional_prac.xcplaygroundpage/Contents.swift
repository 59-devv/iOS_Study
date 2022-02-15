// Optional
// 값이 있을 수도 있고, 없을 수도 있는 변수
// 타입 뒤에 ? 를 붙인다.

var carName: String?
var carName2: String?
// Optional이 아니면 nil을 할당할 수 없다
//carName = nil
carName = "Tesla"


// 아래 변수의 타입은 Int? 이다.
// 문자열이 Int 타입으로 변환이 될 수도 있고, 변환이 불가능한 글자일수도 있기 때문이다.
let num = Int("10")


// 고급기능 4가지
// 1. Forced unwrapping > 억지로 값을 까보기
// 2. Optional Binding(if let) > 부드럽게 값을 까보기1
// 3. Optional Binding(guard) > 부드럽게 값을 까보기2
// 4. Nil Coalescing > 값이 Nil일 때 Default 값 주기

// ---> 1. Forced unwrapping
// 이렇게 그냥 값을 확인하면, Optional("carName") 이다.
print(carName)
print(carName2)
// 이것을 value만 확인할 경우 (Forced unwrapping)
print(carName!)
// 아래는 Nil 인데 억지로 value를 확인하려고 하면 오류가 발생한다.
//print(carName2!)


// ---> 2. Optional Binding(if let)
if let unwrappedCarName = carName2 {
    print(unwrappedCarName)
} else {
    print("값 없음")
}

func printParsedInt (from: String) {
    if let result = Int(from) {
        print(result)
    } else {
        print("변환할 수 없어여")
    }
}

printParsedInt(from: "10")
printParsedInt(from: "10 Hour")


// ---> 3. Optional Binding(guard)
// 2번 방법을 사용할 경우, if let 내부에서 처리해줘야하는 것들이 많아지기 때문에
// Cyclomatic Complexity (복잡도) 가 올라갈 수 있다.
// 따라서 3번 방법을 사용하는 것이 코드의 가독성을 높일 수 있다.

func printParsedInt2 (from: String) {
    // 변환이 불가능할 경우, guard문 이후의 코드를 실행하지 않는다.
    // 따라서 변환이 완료되었을 경우에만 변수를 통해 이후 로직을 수행하게 한다.
    guard let result = Int(from) else {
        print("변환 불가")
        return
    }
    
    print(result)
}


// ---> 4. Nil Coalescing
// 값이 있을 경우 그 값을, 없을 경우 Default 값을 할당한다.
//carName = nil
carName = "제네시스"
let myCarName: String = carName ?? "테슬라"
print(myCarName)



// 연습하기
// 1. 최애 음식을 담는 변수 작성 (Optional)
// 2. 옵셔널 바인딩을 이용해서 값 확인
// 3. 닉네임을 받아서 출력하는 함수 만들기. 조건 입력 파라미터는 Optional

// 1번
var favoriteFoodName: String?
favoriteFoodName = "김치찌개"

// 2번
//favoriteFoodName = nil
if let myFavoriteFood = favoriteFoodName {
    print(myFavoriteFood)
} else {
    print("좋아하는 음식이 없어여")
}

// 3번

var nick: String? = "니익"

func printNickname(value: String?) {
    guard let nickname = value else {
        print("닉네임을 입력해주세요.")
        return
    }
    
    print("\(nickname)님, 환영합니다.")
}
printNickname(value: nick)

nick = nil
printNickname(value: nick)
