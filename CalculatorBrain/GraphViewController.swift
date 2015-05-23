//
//  GraphViewController.swift
//  CalculatorBrain
//
//  Created by Tatiana Kornilova on 5/6/15.
//  Copyright (c) 2015 Tatiana Kornilova. All rights reserved.
//

import UIKit

class Grapher {
     var yForX:  ((x:Double) -> Double?)? // очень обобщенный
}

class GraphViewController: UIViewController{
    
    @IBOutlet weak var graphView: GraphView! { didSet {
        
        graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView,
            action: "scale:"))
        graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView,
            action: "originMove:"))
        let tap = UITapGestureRecognizer(target: graphView, action: "origin:")
        tap.numberOfTapsRequired = 2
        graphView.addGestureRecognizer(tap)
        
        graphView.grapher.yForX = { [unowned self]
            (x:Double) -> Double? in
            self.brain.setVariable("M", value: Double (x))
            return self.brain.evaluate()
        }
        updateUI()
        }
    }
    
    private var brain = CalculatorBrain()
    
    typealias PropertyList = AnyObject
    var program: PropertyList? { didSet {
        brain.setVariable("M", value: 0)
        brain.program = program!
        
        updateUI()
        }
    }
    
    func updateUI() {
        graphView?.setNeedsDisplay()
        title = brain.description != "?" ? brain.description : "График"
    }
 }
