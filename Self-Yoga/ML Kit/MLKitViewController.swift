//
//  MLKitViewController.swift
//  Self-Yoga
//
//  Created by itst on 10/1/2021.
//

import UIKit
import MLKit
import AVFoundation

class MLKitViewController: UIViewController {
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCemera : AVCaptureDevice?
    var currnetCamerra : AVCaptureDevice?

    var photoOutput: AVCapturePhotoOutput?
    
    var camerPreviewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDrivce()
        setupInputOutput()
        startRunningCaptureSession()
        
        
        // Do any additional setup after loading the view.
    }
    
    // Base pose detector with streaming, when depending on the PoseDetection SDK
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDrivce() {
        let deviceeDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        let devices = deviceeDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }else if device.position == AVCaptureDevice.Position.front {
                frontCemera = device
            }
        }
        currnetCamerra = backCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDrviceInput = try AVCaptureDeviceInput(device: currnetCamerra!)
            captureSession.addInput(captureDrviceInput)
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            
        } catch {
            print(error)
        }
    }
    
    func setupPreviewLayer() {
        camerPreviewLayer = AVCaptureVideoPreviewLayer(session:  captureSession)
        camerPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        camerPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        camerPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(camerPreviewLayer!, at: 0
        )
    }
    
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
