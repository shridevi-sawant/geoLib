//
//  ViewController.swift
//  geoLib
//
//  Created by shridevi-sawant on 02/17/2022.
//  Copyright (c) 2022 shridevi-sawant. All rights reserved.
//

import UIKit
import geoLib


class ViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    let locWrapper = LocationWrapper()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("view did load")
     
      
        locWrapper.startTracking()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showClick(_ sender: Any) {
        
        if let loc = locWrapper.getCurrentLocation(){
            print("Got loc: \(loc.coordinate.latitude)")
            lbl.text = "Latt: \(loc.coordinate.latitude), Lang: \(loc.coordinate.longitude)"
        }
        else {
            print("did not get")
        }
//
    }
}

