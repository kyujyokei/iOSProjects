//: Playground - noun: a place where people can play

import UIKit

    protocol BossDelegate{
    func work()
    }

class Worker:BossDelegate{
    func work() {
        print("work from 9 to 5")
    }
}

class Boss{
    var delegate:BossDelegate?
    func askWorker(){
    delegate?.work()
    }
}

let aBoss = Boss()
let aWorker = Worker()

aBoss.delegate = aWorker
aBoss.askWorker()

