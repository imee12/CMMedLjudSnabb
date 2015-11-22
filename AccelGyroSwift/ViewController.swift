//
//  ViewController.swift
//  AccelGyroSwift
//
//  Created by Imee Cuison on 11/21/15.
//  Copyright © 2015 Imee Cuison. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    
    var mySound = AVAudioPlayer()
    
    //Instance Variables
    
    var currentMaxAccelX: Double = 0.0
    var currentMaxAccelY: Double = 0.0
    var currentMaxAccelZ: Double = 0.0
    var currentMaxRotX: Double = 0.0
    var currentMaxRotY: Double = 0.0
    var currentMaxRotZ: Double = 0.0
    
    var motionManager = CMMotionManager()
    //  let motionManager: CMMotionManager = CMMotionManager()
    
    // Outlets
    
    
    @IBOutlet var accX: UILabel?
    @IBOutlet var accY: UILabel?
    @IBOutlet var accZ: UILabel?
    @IBOutlet var maxAccX: UILabel?
    @IBOutlet var maxAccY: UILabel?
    @IBOutlet var maxAccZ: UILabel?
    @IBOutlet var rotX: UILabel?
    @IBOutlet var rotY: UILabel?
    @IBOutlet var rotZ: UILabel?
    @IBOutlet var maxRotX: UILabel?
    @IBOutlet var maxRotY: UILabel?
    @IBOutlet var maxRotZ: UILabel?
    
    
    // Functions
    
    @IBAction func resetMaxValues() {
        print("Reset Pushed")
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
    }
    
    
    override func viewDidLoad() {
        
        //Set Motion Manager Properties  - how often check for accel,gyro 0.2 is every 2 10ths sec
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
        //Start Recording Data
        
//        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
//            [weak self] (data: CMAccelerometerData!, error: NSError!) in
//            
//            let rotation = atan2(data.acceleration.x, data.acceleration.y) - M_PI
//            self?.imageView.transform = CGAffineTransformMakeRotation(CGFloat(rotation))
//        }
        
    
//        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (data: CMAccelerometerData?, error: NSError?) -> Void in
//            guard data != nil else {
//                print("There was an error: \(error)")
//                return
//            }
//        }
//        
//        motionManager.startGyroUpdatesToQueue(NSOperationQueue()) { (data: CMGyroData?, error: NSError?) -> Void in
//                guard data != nil else {
//                    print("There was an error: \(error)")
//                    return
//                }
//    
//        }
        
        
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!,
            withHandler: { (accelerometerData, error) -> Void in self.outputAccelerationData(accelerometerData!.acceleration)
                if (error != nil) {
                    print("\(error)")
                    
                }

        })
        
        
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!,
            withHandler: { (gyroData, error) -> Void in self.outputRotationData(gyroData!.rotationRate)
                if (error != nil) {
                    print("\(error)")
                    
                }
                
        })

        
        
        
//        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(),
//            withHandler: { (accelerometerData: CMAccelerometerData!, error: NSError!) -> Void in self.outputAccelerationData(accelerometerData.acceleration)
//                if (error != nil) {
//                    print("\(error)")
//                }
//        })
//        
//        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler:
//            { (gyroData: CMGyroData!, error: NSError!) -> Void in
//                self.outputRotationData(gyroData.rotationRate)
//                if (error != nil) {
//                    print("\(error)")
//                }
//        })
        
        super.viewDidLoad()
        
        mySound = self.setupAudioPlayerWithFile("one", type:"mp3")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupAudioPlayerWithFile(file: String, type: String) -> AVAudioPlayer  {
        
        if let url = NSBundle.mainBundle().URLForResource(file, withExtension: type) {
            do {
                return try AVAudioPlayer(contentsOfURL: url)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return AVAudioPlayer()
    }
    
    
    
    
    
    
    func outputAccelerationData(acceleration: CMAcceleration) {
        
        
        accX?.text = "\(acceleration.x).2fg"
        
        if fabs(acceleration.x) > fabs(currentMaxAccelX)
        {
            currentMaxAccelX = acceleration.x
        }
        
        accY?.text = "\(acceleration.y).2fg"
        
        if fabs(acceleration.y) > fabs(currentMaxAccelY)
        {
            currentMaxAccelY = acceleration.y
        }
        
        accZ?.text = "\(acceleration.z).2fg"
        
        
        
        
        
        
        
        if (acceleration.z < -0.80) {
            print("Z is here.")
            
            mySound.play()
        }

//
//            let audioPath = NSBundle.mainBundle().pathForResource("one", ofType: "mp3")!
//            
//            do {
//                
//                try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
//                
//                
//            } catch {
//                
//                // Process error here
//                print("Ain't working")
//                
//            }
//            
//            
//        }
        
            
            
            
//          let fileURL:NSURL = NSBundle.mainBundle().URLForResource("one", withExtension: "mp3")!
//            
//            var error: NSError?
//            self.audioPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: &error)
//            if audioPlayer == nil {
//                if let e = error {
//                    print(e.localizedDescription)
//                }
//            }
            
            
            
            
//
//            var soundPath:NSURL?
//            
//            if let path = NSBundle.mainBundle().pathForResource("one", ofType: "mp3") {
//                soundPath = NSURL(fileURLWithPath: path)
//                do {
//                    let sound = try AVAudioPlayer(contentsOfURL: soundPath!, fileTypeHint:nil)
//                    sound.prepareToPlay()
//                    sound.play()
//                } catch {
//                    //Handle the error
//                    print("error sound")
//                }
//            }
// 
        
            
            
            
//            let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("one", ofType: "mp3")!)
//            print(alertSound)
//            
//            
//           var error:NSError?
//            audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
//            audioPlayer.prepareToPlay()
//            audioPlayer.play()
            
        //}

        
        if fabs(acceleration.z) > fabs(currentMaxAccelZ)
        {
            currentMaxAccelZ = acceleration.z
        }
        
        maxAccX?.text = "\(currentMaxAccelX) .2f"
        maxAccY?.text = "\(currentMaxAccelY) .2f"
        maxAccZ?.text = "\(currentMaxAccelZ) .2f"
        
    }
    
    
    func outputRotationData(rotation: CMRotationRate) {
        
        rotX?.text = "\(rotation.x).2fg"
        
        if fabs(rotation.x) > fabs(currentMaxRotX)
        {
            currentMaxRotX = rotation.x
        }
        
        if fabs(rotation.y) > fabs(currentMaxRotY)
        {
            currentMaxRotY = rotation.y
        }
        
        if fabs(rotation.z) > fabs(currentMaxRotZ)
        {
            currentMaxRotZ = rotation.z
        }
        
        
        maxRotX?.text = "\(currentMaxRotX) .2f"
        maxRotY?.text = "\(currentMaxRotY) .2f"
        maxRotZ?.text = "\(currentMaxRotZ) .2f"
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

