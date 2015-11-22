//
//  ThreeViewController.swift
//  AccelGyroSwift
//
//  Created by Imee Cuison on 11/22/15.
//  Copyright © 2015 Imee Cuison. All rights reserved.
//

//import UIKit
//
//class ThreeViewController: UIViewController {
//
//    override func viewDidLoad() {
//        print("Tres is here")
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

import UIKit
import CoreMotion
import AVFoundation

class ThreeViewController: UIViewController {
    
    var mySound = AVAudioPlayer()
    var mySound2 = AVAudioPlayer()
    var mySound3 = AVAudioPlayer()
    
    
    //var random = Int(arc4random_uniform(3)+1)
    
    
    // let random = Int(arc4random_uniform(UInt32(4)))
    //  let random = arc4random()
    
    
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
        print("Three is here")
        
        //Set Motion Manager Properties  - how often check for accel,gyro 0.2 is every 2 10ths sec
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
        //Start Recording Data
        delay(3) {
        self.restartAccelUpdates()
        }
        
        
        super.viewDidLoad()
        
        mySound = self.setupAudioPlayerWithFile("one", type:"mp3")
        mySound2 = self.setupAudioPlayerWithFile("Two", type:"mp3")
        mySound3 = self.setupAudioPlayerWithFile("Tres", type:"mp3")
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func restartAccelUpdates () {
        print("restart here")
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
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
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
            stopAccelerometerUpdates()
            
            
            
          //  let random = Int(arc4random_uniform(UInt32(4)))
           
            let random = 1
            switch random
            {
            case 0:
                print("uno")
                let unoFromOne = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as UIViewController
                // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
                let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                appDelegate.window?.rootViewController = unoFromOne
                
                self.presentViewController(unoFromOne, animated: false, completion: nil)
                mySound.play()
                delay(1){
                    self.mySound.stop()
                }
                
                
                //                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "functionHere", userInfo: nil, repeats: false)
                
                break
                
                
                
                
                
                
                
                
                //  ViewController(nibName: "ViewController", bundle: nil)
                
            case 1:
                print("dos")
                let dosFromOne = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TwoViewController") as UIViewController
                // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
                let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                appDelegate.window?.rootViewController = dosFromOne
                
                self.presentViewController(dosFromOne, animated: false, completion: nil)
                
                
                mySound2.play()
                
                
                delay(1){
                    self.mySound2.stop()
                }
                
                
                break
                
                
            case 2:
                print("tres")
                let tresFromOne = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ThreeViewController") as UIViewController
                // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
                let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                appDelegate.window?.rootViewController = tresFromOne
                
                self.presentViewController(tresFromOne, animated: false, completion: nil)
                
                mySound3.play()
                
                delay(1){
                    self.mySound3.stop()
                }
                
                
                break
            default:
                print("Something else")
                let dosFromOne = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TwoViewController") as UIViewController
                // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
                let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                appDelegate.window?.rootViewController = dosFromOne
                
                self.presentViewController(dosFromOne, animated: false, completion: nil)
                
                
                mySound2.play()
                
                
                delay(1){
                    self.mySound2.stop()
                }
                

                break
            }
            //mySound.play()
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
    
    func stopAccelerometerUpdates() {
        print("stop accel updates")
        
        motionManager.stopAccelerometerUpdates()
        
        delay(5){
            print("delay working from 3")
            self.printout()
            //            self.motionManager.accelerometerUpdateInterval = 1
            //            self.motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!,
            //            withHandler: { (accelerometerData, error) -> Void in self.outputAccelerationData(accelerometerData!.acceleration)
            //                if (error != nil) {
            //                    print("\(error)")
            //                    
            //                }
            //                
            //        })
            
            
            
        }
        
        
    }
    
    func printout () {
        print("waited for 5 seconds from 3")
        //        self.motionManager.accelerometerUpdateInterval = 0.2
        //                    self.motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!,
        //                    withHandler: { (accelerometerData, error) -> Void in self.outputAccelerationData(accelerometerData!.acceleration)
        //                        if (error != nil) {
        //                            print("\(error)")
        //        
        //                        }
        //                        
        //                })
        
        
        
        
    }
    
    
}




