//
//  ViewController.swift
//  babyselfie
//
//  Created by Alexander Kaump on 8/6/16.
//  Copyright © 2016 Alexander Kaump. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var error: NSError?
    
    var ButtonAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeImageCapture()
    
        ButtonAudioPlayer = AVAudioPlayer()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        self.saveToCamera()
    }
}

extension CameraViewController {
    
    func initializeImageCapture() {
        let devices = AVCaptureDevice.devices().filter{ $0.hasMediaType(AVMediaTypeVideo) && $0.position == AVCaptureDevicePosition.Front }
        if let captureDevice = devices.first as? AVCaptureDevice  {
            
            do {
                try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
            } catch {
                print("error starting capture session")
            }

            captureSession.sessionPreset = AVCaptureSessionPresetPhoto
            captureSession.startRunning()
            stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
            if captureSession.canAddOutput(stillImageOutput) {
                captureSession.addOutput(stillImageOutput)
            }
            if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
                previewLayer.bounds = view.bounds
                previewLayer.position = CGPointMake(view.bounds.midX, view.bounds.midY)
                previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                let cameraPreview = UIView(frame: CGRectMake(0.0, 0.0, view.bounds.size.width, view.bounds.size.height))
                cameraPreview.layer.addSublayer(previewLayer)
                self.cameraView.addSubview(cameraPreview)
            }
        } else {
            print("no camera found")
        }
    }
    
    func saveToCamera() {
        if let videoConnection = stillImageOutput.connectionWithMediaType(AVMediaTypeVideo) {
            stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection) {
                (imageDataSampleBuffer, error) -> Void in
                if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer) {
                    let image = UIImage(data: imageData)!
                    
                    var rotatedOrientation = UIImageOrientation.Up
                    if UIDevice.currentDevice().orientation == .LandscapeLeft {
                        rotatedOrientation = .Down
                    } else if UIDevice.currentDevice().orientation == .LandscapeRight {
                        rotatedOrientation = .Up
                    } else if UIDevice.currentDevice().orientation == .Portrait {
                        rotatedOrientation = .Right
                    } else if UIDevice.currentDevice().orientation == .PortraitUpsideDown {
                        rotatedOrientation = .Left
                    }
                    
                    let rotatedImage: UIImage = UIImage(CGImage: image.CGImage! ,
                                                           scale: 1.0 ,
                                                           orientation: rotatedOrientation)
                    
                    UIImageWriteToSavedPhotosAlbum(rotatedImage, nil, nil, nil)
                    CustomPhotoAlbum.sharedInstance.saveImage(rotatedImage)
                }
            }
        }
    }
    
    @IBAction func soundButton(sender: AnyObject) {
        if let effect = SoundAssist.randomSoundEffect() {
            ButtonAudioPlayer = try! AVAudioPlayer(contentsOfURL: effect)
            ButtonAudioPlayer.currentTime = 0
            ButtonAudioPlayer.prepareToPlay()
            ButtonAudioPlayer.play()
        }
   
    }
}
