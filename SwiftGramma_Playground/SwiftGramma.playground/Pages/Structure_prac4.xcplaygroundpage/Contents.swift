import UIKit

// 도전과제
// 1. 강의 이름, 강사 이름, 학생 수를 가지는 Structure 만들기 (Lecture)
// 2. 강의 Array와 강사 이름을 받아서, 해당 강사의 강의 이름을 출력하는 함수 만들기
// 3. 강의 3개 만들고, 강사 이름으로 강의 찾기

// Protocol을 간략하게 실습해본다.
// CustomStringConvertible Protocol을 사용해서 출력 결과를 바꾸어보자.
struct Lecture: CustomStringConvertible {
    var description: String {
        return "Title: \(lecName), Teacher: \(teacherName)"
    }

    var lecName: String
    var teacherName: String
    var studentCount: Int
}

func printTeacherName(lecs: [Lecture], teacherName: String) {
//    for lec in lecs {
//        if lec.teacherName == teacherName {
//            print(lec.lecName)
//        }
//    }
    let lectureNameList = lecs.filter { lec -> Bool in
        return lec.teacherName == teacherName
    }
    
    for lec in lectureNameList {
        print(lec.lecName)
    }
}

let lec1 = Lecture(lecName: "Swift Basic", teacherName: "Oh", studentCount: 50)
let lec2 = Lecture(lecName: "Swift Intermediate", teacherName: "Kim", studentCount: 25)
let lec3 = Lecture(lecName: "Swift HighLevel", teacherName: "Oh", studentCount: 10)

let lecList = [lec1, lec2, lec3]
printTeacherName(lecs: lecList, teacherName: "Oh")

print(lec1)
