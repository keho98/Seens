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
        
        let boxGeometry = SCNBox(width: 4.0, height: 4.0, length: 4.0, chamferRadius: 1.0)
        boxGeometry.firstMaterial!.diffuse.contents = UIColor(red: 0.1, green: 0.2, blue: 0.7, alpha: 0.9)
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position =  SCNVector3(x: 2, y: 5, z: 2)
        scene.rootNode.addChildNode(boxNode)
        
        let planeGeometry = SCNPlane(width: 40.0, height: 40.0)
        planeGeometry.firstMaterial!.diffuse.contents = UIColor.greenColor()
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.transform = SCNMatrix4MakeRotation(Float(M_PI_2), 0.0, 0.0, 1.0)
        
        scene.rootNode.addChildNode(planeNode)
        
        let starParticles = SCNParticleSystem(named: "Stars", inDirectory: <#String!#>)
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 20)
        
        // create and add an ambient light to the scene
        let spotLightNode = SCNNode()
        spotLightNode.light = SCNLight()
        spotLightNode.light!.type = SCNLightTypeSpot
        spotLightNode.light!.color = UIColor(white: 0.9, alpha: 1.0)
        spotLightNode.position = SCNVector3(x: 10, y: 10, z: 10)
        spotLightNode.castsShadow = true
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor(white: 0.2, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)

        let constraint = SCNLookAtConstraint(target: boxNode)
        spotLightNode.constraints = [constraint]
        scene.rootNode.addChildNode(spotLightNode)
        
        let scnView = self.view as! SCNView
        
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.grayColor()
        
        // add animations
        boxNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(CGFloat(0.0), y: CGFloat(0.0), z: CGFloat(2.0*M_PI), duration: 2.0)))
        
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
