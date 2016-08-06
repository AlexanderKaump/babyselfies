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
    var error: NSError?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeImageCapture()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
}

extension CameraViewController {
    
    func initializeImageCapture() {
        let devices = AVCaptureDevice.devices().filter{ $0.hasMediaType(AVMediaTypeVideo) && $0.position == AVCaptureDevicePosition.Back }
        if let captureDevice = devices.first as? AVCaptureDevice  {
            
            do {
                try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
            } catch {
                print("error starting capture session")
            }

            captureSession.sessionPreset = AVCaptureSessionPresetPhoto
            captureSession.startRunning()
//            stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
//            if captureSession.canAddOutput(stillImageOutput) {
//                captureSession.addOutput(stillImageOutput)
//            }
            if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
                previewLayer.bounds = view.bounds
                previewLayer.position = CGPointMake(view.bounds.midX, view.bounds.midY)
                previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                let cameraPreview = UIView(frame: CGRectMake(0.0, 0.0, view.bounds.size.width, view.bounds.size.height))
                cameraPreview.layer.addSublayer(previewLayer)
                self.view.addSubview(cameraPreview)
            }
        } else {
            print("no camera found")
        }
    }
}
