import UIKit

// 데이터 타입
// Bool : 참, 거짓을 표현하기 위한 타입
var isChecked: Bool = false
isChecked = true

// Int : 64비트 정수형 타입
var temprature: Int = -100
temprature = 100

// UInt (Unsigned Integer) : 64비트 정수형 타입
var cakes: UInt = 100
//cakes = -100 // 오류

// Float : 32비트 부동소수형
var pi: Float = 3.14
pi = 314

// Double : 64비트 부동소수형
var pi2: Double = 3.14
pi = 314

// Character : 한 문자를 표현하기 위한 타입
var sampleCharacter: Character = "A"
sampleCharacter = "가"
//sampleCharacter = "문자열" //오류

// String : 여러문자를 표현하기 위한 타입
var sampleString: String = "Hi!"
sampleString = "Hello!"

// 타입 추론 (타입을 적지 않아도 자동으로 추론해줌)
var test = 100
type(of: test)

var testString = "타입추론"
type(of: testString)

// Any : 모든 타입을 지칭하는 키워드
var sampleAny: Any = "Any"
sampleAny = 10
sampleAny = 3.14

// nil : 없음, 존재하지 않음을 나타내는 키워드
// var sampleInt: Int = nil //오류
var sampleInt: Int? = nil // ? 를 표시해주면 Optional 표시임
type(of: sampleInt)

var sampleStringNil: String? = nil
type(of: sampleString)
