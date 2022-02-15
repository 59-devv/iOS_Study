// 1. 함수 오버로딩
// 같은 이름의 함수지만 받는 인자의 수, 타입, 이름이 달라지도록 할 수 있다.

func calculateTwoNum(a: Int, b: Int) -> Int {
    return a*b
}

// 하나가 Double 타입일 경우
func calculateTwoNum(a: Double, b: Int) -> Double {
    return a*Double(b)
}

// 둘 다 Double 타입일 경우
func calculateTwoNum(a: Double, b: Double) -> Double {
    return a*b
}

// 받는 인자의 이름이 다를 경우
func calculateTwoNum(num1: Double, num2: Double) -> Double {
    return num1*num2
}

calculateTwoNum(a: 5, b: 3)
calculateTwoNum(a: 5.0, b: 3)
calculateTwoNum(a: 5.0, b: 3.0)
calculateTwoNum(num1: 5.0, num2: 3.0)


// 2. In-Out Parameter
// 인자로 받은 함수를 다시 돌려줄 때,
// 기본적으로 인자로 받은 값은 Constant 이기 때문에 수정이 불가능하다.
// 따라서 inout 키워드를 사용한다.

var value = 3
func inoutTest(value: inout Int) -> Int {
    value += 1
    return value
}

// inout 파라미터로 사용할 경우, 변수명 앞에 & 을 붙여주어야 한다.
inoutTest(value: &value)



// 3. 함수를 변수에 할당하기, 함수를 인자로 사용하기

func add(a: Int, b: Int) -> Int {
    return a+b
}

func subtract(a: Int, b: Int) -> Int {
    return a-b
}

// 변수에 함수를 할당할 수 있다.
var addFunc = add
// 사용할 때는 인자이름을 안써준다.
addFunc(1, 2)
// 할당된 함수를 다른 함수로 재할당 할수도 있다.
addFunc = subtract
addFunc(1, 2)


// 함수의 파라미터 인자로 함수를 받을 수 있다.
// 단, 함수 타입을 잘 정의해주어야 한다.
func funcInFunc(function: (Int, Int) -> Int, a: Int, b: Int) -> Int {
        let result = function(a, b)
        return result
}

funcInFunc(function: add, a: 2, b: 3)
funcInFunc(function: subtract, a: 5, b: 2)
