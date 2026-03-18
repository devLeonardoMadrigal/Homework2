import UIKit

/*
 Here is the assignment for Day 2.

  In Swift playgorund have multiple examples to show usage of below:
 1.Closures and its types-
 Non Escaping closure
 Escaping
 2.Protocol usage and demo to show how to use it on classes and achive multiple inheritance using  Protocol

 3.Memory management: ARC, strong/weak references, Retain Cycle

 4.MultiThreadin
 GCD - Grand Central Dispatch
 1.Main thread
  2.Global queues
  3.Custom Queues

 Operation Queue3.Async Await,
 SwiftConcunancy - Actor, async let,

 5.Create a new app in UIKIT to design attached design in storyboard.
 */



print("---------------------------------------------")
print("1.Closures and its types,  Non Escaping closure, Escaping")

//---------Non-Escaping Closure START--------
func nonScapingClosure(doSomething: () -> Void){
    print("1. Starting nonScapingClosure")
    doSomething()
    print("3. Finishing nonScapingClosure")
}

nonScapingClosure{
    print("-----2. Non-Escaping Closure Execution-----")
}

//---------Non-Escaping Closure END--------

print("---------------------------------------------")

//---------Escaping Closure START--------

class EscapingClosuresClass{
    
    var actualDoSomething: () -> Void = {}
    
    func escapingClosure(doSomething: @escaping () -> Void){
        print("1. Starting escapingClosure")
        self.actualDoSomething = doSomething
        print("3. Finishing escapingClosure")
    }
}

let escapingClosuresObject = EscapingClosuresClass()

escapingClosuresObject.escapingClosure{
    print("-----2. Escaping Closure Execution-----")
}

escapingClosuresObject.actualDoSomething()


//---------Escaping Closure END--------

print("---------------------------------------------")
print("2.Protocol usage and demo to show how to use it on classes and achive multiple inheritance using  Protocol")


protocol Person{
    var name: String {get set}
    var age: Int {get set}
}

protocol Employee{
    var companyName: String {get set}
    var salary: Double {get set}
}


class Developer : Person, Employee{
    var name: String
    var age: Int
    var companyName: String
    var salary: Double
    
    init(name: String, age: Int, companyName: String, salary: Double) {
        self.name = name
        self.age = age
        self.companyName = companyName
        self.salary = salary
    }
}


let developerLeo:Developer = Developer(name:"Leo", age: 28, companyName: "TC",salary: 999999999.99)

print(developerLeo.name)
print(developerLeo.age)
print(developerLeo.companyName)
print(developerLeo.salary)


print("---------------------------------------------")
print("3.Memory management: ARC, strong/weak references, Retain Cycle")

class Tenant{
    var name: String
    var apartment:Apartment?
    
    init(name: String, apartment: Apartment? = nil) {
        self.name = name
        self.apartment = apartment
        print("Tenant \(name) initialized")
    }
    
    deinit{
        print("Tenant \(name) deinitialized")
    }
}

class Apartment{
    let apartmentNumber: Int
    weak var tenant: Tenant? //If this variable wasn't set to weak, instance of tenant and apartment would never be deallocated
    
    init(apartmentNumber: Int, tenant: Tenant? = nil) {
        self.apartmentNumber = apartmentNumber
        self.tenant = tenant
        print("apartmentNumber #\(apartmentNumber) initialized")

    }
    
    deinit{
        print("Apartment #\(apartmentNumber) deinitialized")
    }
}

var tenantDavid: Tenant? = Tenant(name: "David")
var apartment1: Apartment? = Apartment(apartmentNumber: 1)

tenantDavid?.apartment = apartment1
apartment1?.tenant = tenantDavid


//Able to deallocate these two objects from memory thanks to weak keyword in line 128
//Else, this instruction would just not work and memory leaks would occur
tenantDavid = nil
apartment1 = nil


print("---------------------------------------------")
print("4.MultiThreadin")

/*
 GCD - Grand Central Dispatch
 1.Main thread
  2.Global queues
  3.Custom Queues
 */


DispatchQueue.main.async {
    print("Task in the Main Thread")
}
DispatchQueue.global(qos: .background).async{
    print("Background task in the Global Queue")
}

let myCustomQueue = DispatchQueue(label: "Custom Queueu")
myCustomQueue.async{
    print("Custom Queue")
}



print("---------------------------------------------")
print("4?.MultiThreadin -  Operation Queue 3.Async Await, SwiftConcunancy - Actor, async let,")
/*
 Operation Queue3.Async Await,
 SwiftConcunancy - Actor, async let,
 */
let operationQueue = OperationQueue()
operationQueue.maxConcurrentOperationCount = 2

let operation1 = BlockOperation{
    for i in 0...10 {
        print("Task 1 execution... progress: \(i*10)")
    }
}
let operation2 = BlockOperation{
    for i in 0...10 {
        print("Task 2 execution... progress: \(i*10)")
    }
}

let operation3 = BlockOperation{
    for i in 0...10 {
        print("Task 3 execution... progress: \(i*10)")
    }
}
operation1.addDependency(operation3)

operationQueue.addOperations([operation1, operation2, operation3], waitUntilFinished: false)


print("---------------------------------------------")
print("4?.MultiThreadin -  Async Await, SwiftConcunancy - Actor, async let,")

func fetchUserData() async throws -> String {
    return "{result:{name:Leo}}"
}

Task{
    async let userData = fetchUserData()
    
    do{
        let data = try await userData
        print("User Data: \(data)")
    } catch{
        print("ERROR \(error)")
    }
}
print("---------------------------------------------")
print("4?.MultiThreadin - Actor")


actor BankAccount{
    var balance: Int = 0
    
    func deposit(money: Int){
        print("Trying to deposit $\(money) into a $\(balance) account...")
        balance += money
        print("     $\(money) deposit")
        print("     Balance: $\(balance) ")
    }
    
    func withdraw(money: Int){
        print("Trying to withdraw $\(money) from a $\(balance) account...")

        if(balance - money < 0){
            print("     Not enough funds!")
        }else{
            balance -= money
            print("     $\(money) withdrawn")
            print("     Balance: $\(balance) ")
        }
    }
}

let sharedBankAccount = BankAccount()

Task{
    await sharedBankAccount.withdraw(money: 100)
}
Task{
    await sharedBankAccount.deposit(money: 100)
}
Task{
    await sharedBankAccount.withdraw(money: 50)
}
Task{
    await sharedBankAccount.withdraw(money: 60)
}
Task{
    await sharedBankAccount.withdraw(money: 50)
}




