import UIKit

// 파라미터 두 개를 받아서 곱하기
// 가격, 갯수 받아서 총 가격 출력
func printTotalPrice(price: Int, count: Int) {
    print("Total Price: \(price * count)")
}

printTotalPrice(price: 1500, count: 5)

// function 사용 시, price / count 입력 안해도 되게 만들기
func printTotalPrice2(_ price: Int, _ count: Int) {
    print("Total Price: \(price * count)")
}

printTotalPrice2(1500, 5)

// function 사용 시 임의의 표현으로 직관성 높이기
func printTotalPrice3(가격 price: Int, 갯수 count: Int) {
    print("Total Price: \(price * count)")
}

printTotalPrice3(가격: 1500, 갯수: 5)

// function 사용 시 기본값 부여하기
// 아래처럼, 사용할 때 하나의 인자만 받을 수 있다. (default와 다를 경우 두 개 모두 받을 수도 있다.)
func printTotalPriceWithDefaultValue(price: Int = 1500, count: Int) {
    print("Total Price: \(price * count)")
}

printTotalPriceWithDefaultValue(count: 5)


// 반환값을 사용하기 위해선 return을 이용한다.
func totalPrice(price: Int, count: Int) -> Int {
    return price*count
}

let calculatedPrice = totalPrice(price: 1000, count: 50)
