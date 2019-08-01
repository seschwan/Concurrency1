import UIKit

class Spoon {
    
    var lock = NSLock()
    
    var index = 0
    
    init(index: Int) {
        self.index = index
    }
    
    func pickUp() {
        lock.lock()
        print("Picked Up Spoon")
        //lock.unlock()
    }
    
    func putDown() {
        //lock.lock()
        print("Put Spoon Down")
        lock.unlock()
    }
}


class Developer {
    
    let name: String
    let leftSpoon: Spoon
    let rightSpoon: Spoon
    
    
    init(name: String, leftSpoon: Spoon, rightSpoon: Spoon) {
        self.name = name
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
    }
    
    
    
    func think() {
        
        if leftSpoon.index < rightSpoon.index {
            leftSpoon.pickUp()
            print("\(name) is picking up the left spoon first.")
            rightSpoon.pickUp()
        } else {
            rightSpoon.pickUp()
            print("\(name) is picking up the right spoon first.")
            leftSpoon.pickUp()
        }
        
    }
    
    func eat() {
        usleep(10_000)
        print("***** DELAY ****")
        leftSpoon.putDown()
        print("\(name) is putting down the left spoon.")
        
        rightSpoon.putDown()
        print("\(name) is putting down the the right spoon.")
        
    }
    
    func run() {
        while true {
            print("\(name) Started Eating")
            think()
            eat()
            print("\(name) Finished Eating")
        }
    }
}

let spoon1 = Spoon(index: 1)
let spoon2 = Spoon(index: 2)
let spoon3 = Spoon(index: 3)
let spoon4 = Spoon(index: 4)
let spoon5 = Spoon(index: 5)

let dev1 = Developer(name: "Bob", leftSpoon: spoon1, rightSpoon: spoon2)
let dev2 = Developer(name: "Cindy", leftSpoon: spoon2, rightSpoon: spoon3)
let dev3 = Developer(name: "Harry", leftSpoon: spoon3, rightSpoon: spoon4)
let dev4 = Developer(name: "Susan", leftSpoon: spoon4, rightSpoon: spoon5)
let dev5 = Developer(name: "Becky", leftSpoon: spoon5, rightSpoon: spoon1)



let devArray: [Developer] = [dev1, dev2, dev3, dev4, dev5]

DispatchQueue.concurrentPerform(iterations: 5) {
    devArray[$0].run()
}


