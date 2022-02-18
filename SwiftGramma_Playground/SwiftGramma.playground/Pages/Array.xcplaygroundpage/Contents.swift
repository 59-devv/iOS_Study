import UIKit

// 짝수를 담는 배열을 만들어본다.
// 두 가지는 동일하다.
var evenNumbers: [Int] = [2, 4, 6, 8]
let evenNumbers2: Array<Int> = [2, 4, 6, 8]
var evenNumbers3: [Int] = []

// 값을 추가한다.
evenNumbers.append(10)
// 여러개의 값을 추가한다.
evenNumbers += [12, 14, 16]
evenNumbers.append(contentsOf: [18, 20])

// 비어있는지 확인
let isEmpty = evenNumbers.isEmpty
let isEmpty2 = evenNumbers3.isEmpty

// 숫자 세기
evenNumbers.count
evenNumbers3.count

// 첫번째 숫자 가져오기
print(evenNumbers.first)

// 마지막 숫자 가져오기
print(evenNumbers.last)

// 왜 Optional인가? 값이 있을 수도 있고, 없을 수도 있기 때문에
// 값이 없으면 nil 이다.
let firstNumber = evenNumbers.first
let firstNumber2 = evenNumbers3.first

// Optional Binding
if let firstElement = evenNumbers.first {
    print("--> first item is : \(firstElement)")
}

// 대소비교가 가능할 경우, 최소값 최대값을 뽑아올 수도 있다.
// 이 역시 있을수도 있고 없을 수도 있기 때문에 Optional이다.
evenNumbers.min()
evenNumbers.max()

// Index(순서)를 이용해서 값을 가져오고 싶을 때
var firstItem = evenNumbers[0]
var secondItem = evenNumbers[1]
var lastItem = evenNumbers[evenNumbers.count-1]

// Index가 없는 경우, Index out of range 오류가 뜬다.
// 앱 Crash가 날 수 있기 때문에, 항상 유의해야한다.
// ex) 현재 index의 최대는 9 인데, 10을 넣을 경우 오류가 발생한다.

// --------------------

// range type을 array에도 사용할 수 있다.
// range type => 0...3 : 0~3까지

let firstThree = evenNumbers[0...2]

// 값이 있는지 확인할 때
evenNumbers.contains(3)
evenNumbers.contains(4)

// 특정 index에 값을 집어넣기
// 해당 index 뒤로 다른 데이터가 밀려난다.
evenNumbers.insert(0, at: 0) // 0번째 index에 0을 넣는다.
evenNumbers

// 특정 index에 값을 삭제하기
// 해당 index 뒤의 데이터가 앞으로 밀려난다.
evenNumbers.remove(at: 0)
evenNumbers

// 모든 값 삭제하기
//evenNumbers.removeAll()

// 특정 index 값을 수정하기
evenNumbers[0] = -6
evenNumbers[1] = -4
evenNumbers[2] = -2
evenNumbers

// 여러 index의 값을 수정하기
evenNumbers[0...2] = [2, 4, 6]
evenNumbers

// index의 값 바꿔치기
// 아래처럼 하면 0번째 index와 1번째 index의 값이 바뀐다.
evenNumbers.swapAt(0, 1)
evenNumbers
evenNumbers.swapAt(1, 0)
evenNumbers

// 반복문
for num in evenNumbers {
    print(num)
}

// index와 함께 출력하는 반복문
for (index, num) in evenNumbers.enumerated() {
    print("idx: \(index), value: \(num)")
}

// 앞에서 몇 개를 뺀 나머지를 출력
// 앞에서 3개를 빼고 출력
// 기존 evenNumbers 배열에는 영향을 주지 않는다.
let firstThreeRemoved = evenNumbers.dropFirst(3)
firstThreeRemoved
evenNumbers

// 뒤에서 몇 개를 뺀 나머지 출력
let lastRemoved = evenNumbers.dropLast()
lastRemoved
evenNumbers

// 배열에 영향을 주지 않고, 앞에서 3개의 값을 출력
let firstThreeNums = evenNumbers.prefix(3)
firstThreeNums
evenNumbers

// 배열에 영향을 주지 않고, 뒤에서 3개의 값을 출력
let lastThreeNums = evenNumbers.suffix(3)
lastThreeNums
evenNumbers



