//: Playground - noun: a place where people can play

import UIKit

class CalculatorFormatter: NSNumberFormatter {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        self.locale = NSLocale.currentLocale()
        self.numberStyle = .DecimalStyle
        self.maximumFractionDigits = 10
        self.notANumberSymbol = "Error"
        self.groupingSeparator = " "
        
    }
    
    // Swift 1.2 or above
    static let sharedInstance = CalculatorFormatter()
    
    /*    class var sharedInstance: CalculatorFormatter {
    struct Static {
    static let instance = CalculatorFormatter()
    }
    return Static.instance
    }*/
}

println(CalculatorFormatter.sharedInstance)

println(CalculatorFormatter.sharedInstance)

println(CalculatorFormatter.sharedInstance.stringFromNumber(20.00) ?? "")
println(CalculatorFormatter.sharedInstance.stringFromNumber(55550) ?? "")

class CalculatorBrain
{
    
    enum Result: Printable {
        case Value(Double)
        case Error(String)
        
        var description: String {
            switch self {
            case .Value(let value):
                return  CalculatorFormatter.sharedInstance.stringFromNumber(value) ?? ""
            case .Error(let errorMessage):
                return errorMessage
            }
        }
    }
}

// ГЛОБАЛЬНАЯ КОНСТАНТА

let formatter = CalculatorFormatter()
println(formatter)
println(formatter)
println(formatter.stringFromNumber(20.00) ?? "")
println(formatter.stringFromNumber(55550) ?? "")

class Foo {
    var action :() -> Void = { }
    func show (value:Int){println("\(value)")}
    func setUpMyAction () {
        var x:Int = 0
        action = { [unowned self] in
            x = x + 1
            self.show(x)
        }
    }
    
    func doMyAction10Times (){ for i in 1..<10 {action ()} }
}

let aaaa = Foo()
aaaa.setUpMyAction()
aaaa.doMyAction10Times ()


