//
//  ViewController.swift
//  LifeCycleApp
//
//  Created by Avenue Code on 10/11/17.
//  Copyright © 2017 lifecycleCourse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var redView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("1")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2")
        // Called when the view is about to made visible. Default does nothing


    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3")
        // Called when the view has been fully transitioned onto the screen. Default does nothing
        //Layout configurations should be done here, now you have perfectly frame defined

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("4")
        // Called when the view is dismissed, covered or otherwise hidden. Default does nothing

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("5")
        // Called after the view was dismissed, covered or otherwise hidden. Default does nothing

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

