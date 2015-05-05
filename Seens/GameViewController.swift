//
//  GameViewController.swift
//  Seens
//
//  Created by Kevin Ho on 5/4/15.
//  Copyright (c) 2015 Keiho. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene()
        
        let boxGeometry = SCNBox(width: 5.0, height: 5.0, length: 5.0, chamferRadius: 1.0)
        boxGeometry.firstMaterial!.diffuse.contents = UIColor(red: 0.1, green: 0.2, blue: 0.7, alpha: 0.9)
        let boxNode = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode)
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // create and add an ambient light to the scene
        let spotLightNode = SCNNode()
        spotLightNode.light = SCNLight()
        spotLightNode.light!.type = SCNLightTypeSpot
        spotLightNode.light!.color = UIColor(white: 0.9, alpha: 1.0)
        spotLightNode.position = SCNVector3(x: 10, y: 10, z: 10)
        spotLightNode.castsShadow = true

        let constraint = SCNLookAtConstraint(target: boxNode)
        spotLightNode.constraints = [constraint]
        scene.rootNode.addChildNode(spotLightNode)
        
        let scnView = self.view as! SCNView
        
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.grayColor()
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        var gestureRecognizers = [AnyObject]()
        gestureRecognizers.append(tapGesture)
        if let existingGestureRecognizers = scnView.gestureRecognizers {
            gestureRecognizers.extend(existingGestureRecognizers)
        }
        scnView.gestureRecognizers = gestureRecognizers
    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.locationInView(scnView)
        if let hitResults = scnView.hitTest(p, options: nil) {
            // check that we clicked on at least one object
            println(hitResults)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
