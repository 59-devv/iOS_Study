import UIKit

// Closure
// 이름이 없는 메서드이다.

// 두 수를 곱하는 Closure를 만들어본다.
var multiplyClosure: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
    return a * b
}
// 위를 조금 줄여보자.
var multiplyClosure2: (Int, Int) -> Int = { a, b in
    return a * b
}
// 더 줄여보자.
// 파라미터의 Index 값을 이용해서, $0, $1 과 같이 사용할 수 있다.
// 앞에서 이미 Return 타입을 Int 로 지정해주었기 때문에, Return도 생략 가능하다.
var multiplyClosure3: (Int, Int) -> Int = { $0 * $1 }

multiplyClosure(4, 2)
multiplyClosure2(4, 2)
multiplyClosure3(4, 2)


// 위 내용만 보면 그냥 메서드를 만드는 것과 차이가 없어보인다.
// 하지만, function에서 파라미터로 함수를 받는 경우가 생각보다 많기 때문에
// 이와 같은 경우에서 Closure가 유용하게 사용될 수 있다.

// 두 수와, Closure를 파라미터로 받는 메서드를 만들어본다.
func operateTwoNum(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    return result
}

operateTwoNum(a: 4, b: 2, operation: multiplyClosure)

var addClosure: (Int, Int) -> Int = { a, b in
    return a + b
}

operateTwoNum(a: 4, b: 2, operation: addClosure)

// 위의 경우 Closure를 미리 만들어놓는 경우인데,
// Closure를 미리 만들지 않고 메서드에 바로 작성할 수도 있다.
operateTwoNum(a: 5, b: 10) { a, b in
    return a * b
}

// Input / Output이 없는 Closure
let voidClosure: () -> Void = {
    print("iOS Developer!")
}

voidClosure()

// Capturing Values
var count = 0
// 인자로 받지 않았지만, 전역으로 선언된 변수를 Capturing 해서
// 함수 내에서 사용할 수 있도록 만들어주는 기능이 Capturing 기능이다.
// 유용하게 사용될 수도 있지만, 전역 변수를 직접 수정할 수 있으므로
// 사용할 때 유의해야 한다.
let incrementer = {
    count += 1
}

incrementer()
incrementer()
incrementer()
incrementer()

count


// ----------- 추가 학습

/* 기본적인 Closure의 생김새
 
 * in 키워드를 기준으로, 좌측에는 파라미터와 리턴타입,
 * 우측에는 실행 구문을 작성한다.
 
 { (parameters) -> return type in
    statements
 }
 
 */

// ex1. 아주 간단한 Closure
// 파라미터도 없고, 리턴 타입도 없는 심플한 형태
let simpleClosure = {
    
}
simpleClosure()

// ex2. 코드블록을 구현한 Closure
let simpleClosure2 = {
    print("Simple Closure2")
}
simpleClosure2()

// ex3. 인풋이 있는 Closure
let simpleClosure3: (String) -> Void = { name in
    print("my name is \(name)!")
}
simpleClosure3("59")

// ex4. 값을 리턴하는 Closure
let simpleClosure4: (String) -> String = { name in
    let msg = "I am iOS Developer, \(name)!"
    return msg
}
let result = simpleClosure4("59")
print(result)

// ex5. Closure를 파라미터로 받는 함수 구현
func someSimpleFunction(simpleClosure: () -> Void) {
    print("함수에서 호출이 되었어요.")
    // 파라미터로 받은 closure를 실행시켜주어야 한다.
    simpleClosure()
}

someSimpleFunction(simpleClosure: {
    print("함수에서 호출된 건 이녀석입니다!")
})

// ex6. Trailling Closure
// 클로저 자체를 함수의 파라미터로 넘길 수 있다.
// 파라미터로 클로저 하나가 아닌 다른 타입의 변수를 또 받을 수도 있다.
// 이 때, 클로저가 '마지막 인자' 일 때 형식을 생략할 수 있다.
func someSimpleFunction2(message: String, simpleClosure: () -> Void) {
    print("메시지는 \(message)")
    simpleClosure()
}

someSimpleFunction2(message: "요녀석", simpleClosure: {
    print("요녀석이 클로저")
})

// 위는 클로저의 일반 사용 방법,
// 아래는 Trailling Closure를 이용하여 생략한 방법이다.
someSimpleFunction2(message: "Trailling") {
    print("이 구문이 Trailling Closure 구문이에요!!")
}
