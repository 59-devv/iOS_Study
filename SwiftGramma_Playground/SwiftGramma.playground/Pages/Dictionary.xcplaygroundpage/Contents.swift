import UIKit

// 학생의 점수를 관리하기 위해 Dictionary를 이용해본다.
var scoreDic: [String: Int] = ["Jason": 80, "Jay": 85, "Jake": 90]
var scoreDic2: Dictionary<String, Int> = ["Jason": 80, "Jay": 85, "Jake": 90]

// 값 가져오기
// key를 통해 검색하면 value를 반환한다.
scoreDic["Jason"]
scoreDic["Jay"]
scoreDic["Jake"]

// Dictionary에 없는 key를 입력하면, nil을 반환한다.
scoreDic["Jerry"]

// Optional 이므로, 안정적으로 가져오기 위해서는 Optional Binding을 이용하는게 좋다.
if let score = scoreDic["J"] {
    score
} else {
    print("Score 없음")
}

// Collection의 공통 Property를 사용할 수 있다.
// 비어있는지 확인
scoreDic.isEmpty
// 빈 Dictionary 만들기
let scoreDic3: [String: Int] = [:]
scoreDic3.isEmpty

// 숫자 세기
scoreDic.count

// 값 업데이트 하기
scoreDic["Jason"]
scoreDic["Jason"] = 99
scoreDic["Jason"]

// 값 추가하기
scoreDic["Nine"] = 100
scoreDic

// 값 제거하기
scoreDic["Nine"] = nil
scoreDic.removeValue(forKey: "Jake")
scoreDic

// 반복문
for (name, score) in scoreDic {
    print("\(name): \(score)")
}

// Key 만 반복문으로 확인
for key in scoreDic.keys {
    print(key)
}

//
/*
 * 실습 과제
 * 1. 이름, 직업, 도시에 대한 DIctionary 만들기
 * 2. 도시를 부산으로 업데이트 하기
 * 3. Dictionary를 받아서 이름과 도시를 프린트하는 함수 만들기
 */

var infoDict: [String: String] = ["name": "59", "city": "Seoul", "job": "iOS Developer"]
infoDict
infoDict["city"] = "Busan"
infoDict

func printInfo(info: [String: String]) {
    if let name = info["name"], let city = info["city"] {
        print("name: \(name), city: \(city) ")
    } else {
        print("값이 없습니다.")
    }    
}

printInfo(info: infoDict)
