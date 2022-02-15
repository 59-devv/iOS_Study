import UIKit

// 조건문 실습

var isChecked = false

if isChecked {
    print("체크되어 있습니다.")
} else {
    print("체크되어 있지 않습니다.")
}

//------------------------------------

var time = 12

if time == 9 {
    print("아침 식사 시간입니다.")
} else if time == 12 {
    print("점심 식사 시간입니다.")
} else if time == 19 {
    print("저녁 식사 시간입니다.")
} else {
    print("식사 시간이 아닙니다.")
}

//------------------------------------

let color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

switch color {
case #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1):
    print("흰색입니다.")
case #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1):
    print("검정색입니다.")
case #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1):
    print("초록색이에요")
default :
    print("모르는색이에요.")
}

//------------------------------------

func getName(name: String?) -> String {
    guard let uName = name else {
        return "이름값이 존재하지 않습니다."
    }
    return uName
}

getName(name: "59")
getName(name: nil)
