import UIKit

// EX : 나의 위치와 가장 가까운 편의점 찾기

// 위치와 관련한 Structure 생성
struct Location {
    var x: Int
    var y: Int
}

// 편의점과 관련한 Structure 생성
struct Store {
    var loc: Location
    var name: String
    var deliveryRange = 2.0
    
    func isDelivable(userLoc: Location) -> Bool {
        let distanceToStore = distance(current: userLoc, target: loc)
        return deliveryRange >= distanceToStore
    }
}

// 거리 구하는 함수
func distance(current: Location, target: Location) -> Double {
    let distanceX = Double(target.x - current.x)
    let distanceY = Double(target.y - current.y)
    
    let distance = sqrt(distanceX * distanceX + distanceY * distanceY)
    return distance
}

// 가장 가까운 편의점, 배달 가능 여부를 구해서 출력하는 함수
func printClosestStore(currentLocation: Location, stores:[Store]) {
    var closestStoreName = ""
    var closestStoreDistance = Double.infinity
    var isDelivable = false
    
    for store in stores {
        let distanceToStore = distance(current: currentLocation, target: store.loc)
        closestStoreDistance = min(distanceToStore, closestStoreDistance)
        if closestStoreDistance == distanceToStore {
            closestStoreName = store.name
            isDelivable = store.isDelivable(userLoc: currentLocation)
        }
    }
    
    print("Closest Store: \(closestStoreName), isDelivable: \(isDelivable)")
}

// 현재 편의점의 위치(Tuple)
let store1 = Store(loc: Location(x: 3, y: 5), name: "GS")
let store2 = Store(loc: Location(x: 4, y: 6), name: "Seven7")
let store3 = Store(loc: Location(x: 1, y: 7), name: "CU")

// Stores Array 세팅, 현재 내 위치 세팅
let myLocation = Location(x: 2, y: 5)
let stores = [store1, store2, store3]

// printClosestStore 함수를 이용해서 가까운 편의점 출력하기
printClosestStore(currentLocation: myLocation, stores: stores)

