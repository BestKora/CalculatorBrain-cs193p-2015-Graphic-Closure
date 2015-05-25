//
//  GraphViewController.swift
//  CalculatorBrain
//
//  Created by Tatiana Kornilova on 5/6/15.
//  Copyright (c) 2015 Tatiana Kornilova. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController{
    
    @IBOutlet weak var graphView: GraphView! { didSet {
        
        graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView,
            action: "scale:"))
        graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView,
            action: "originMove:"))
        let tap = UITapGestureRecognizer(target: graphView, action: "origin:")
        tap.numberOfTapsRequired = 2
        graphView.addGestureRecognizer(tap)
        
        graphView.yForX =  { [unowned self](x:Double)  in
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
        let descript = brain.description.componentsSeparatedByString(",").last ?? " "
        title = "y = " + descript ?? " "
        updateUI()
        }
    }
    
    func updateUI() {
        graphView?.setNeedsDisplay()
    }
 }

