/*
 * Protocol 프로토콜
    : 특정 역할을 하기 위한 프로퍼티, 메서드, 기타 요구사항 등의 규칙을 정한다.
    : 구조체, 클래스, 열거형은 프로토콜을 채택 후,
      특정 기능의 실행을 위해서 프로토콜의 요구사항을 실제로 구현할 수 있다.
    : 프로토콜은 정의를 제시할 뿐, 직접 구현하지는 않는다.
 
 * Protocol 문법
    : 프로퍼티의 요구사항은 var 로 선언한다.
    : 읽기/쓰기가 가능한지 선언한다. (쓰기만은 불가능, 읽기만은 가능)
    : 프로퍼티가 저장, 연산인지 선언하지 않아도 된다.
 
    ex)
    protocol Controllable {
        var hasMasterkey: bool { get set }
        func shutDown() -> String
    }
 
* Protocol 채택
    : 프로토콜의 내용을 구현해주어야, 구현이 완료된다.
    : 채택 방법은 아래와 같다.
 
    ex)
    class RemoteController: Controllable {
        var hasMasterkey: bool
        func shutDown() -> String {
            return "Shutdown"
        }
    }
 
 + Delegate Pattern 참고
 */


/*
 예시
 
 상황
 59(Me)는 수학이 너무나도 싫다.
 수학 천재인 친구 harry 에게 문제를 풀어달라고 요청한다.
 harry는 요청을 받으면 문제를 풀어주기로 했다.
 상호간의 약속을 프로토콜로 정의할 수 있다.
 */

protocol HomeworkDelegate {
    func solveMathProblem()
}


class Me: HomeworkDelegate {
    
    var harry = MathMaster()
    
    func askForHelp() {
        // 일을 시키는 주체가 self(Me 클래스)라는 것
        self.harry.delegate = self
        self.harry.didHomework()
    }
    
    func solveMathProblem() {
        print("숙제가 완료되었습니다.")
    }
    
}

class MathMaster {
    
    var delegate: HomeworkDelegate?
    func didHomework() {
        self.delegate?.solveMathProblem()
    }
}

var nine = Me()
nine.askForHelp()
