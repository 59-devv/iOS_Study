import UIKit

// Array와 Set 비교
var someArray: Array<Int> = [1, 2, 3, 1]
var someSet: Set<Int> = [1, 2, 3, 1]

// Collection에 있는 Property 들을 사용할 수 있다.
someSet.contains(1)
someSet.contains(4)
someSet.isEmpty
someSet.count

// 값 넣기
someSet.insert(4)
someSet.contains(4)

// 값 제거하기
someSet.remove(1)
someSet.contains(1)
