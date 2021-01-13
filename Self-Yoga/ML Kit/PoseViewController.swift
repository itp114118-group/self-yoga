//  PoseViewController.swift
//  Self-Yoga
//
//  Created by itst on 12/1/2021.
//

import UIKit
import MLKit
import MLKitPoseDetection
import AVFoundation

class PoseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultView: UITextView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
            
            //step 1 - single image
            let visionImage = VisionImage(image: pickedImage)
            visionImage.orientation = pickedImage.imageOrientation
            
            //step 1 - stream
            //            let image = VisionImage(buffer: sampleBuffer)
            //            image.orientation = imageOrientation(
            //              deviceOrientation: UIDevice.current.orientation,
            //              cameraPosition: cameraPosition)
            
            //step 2 - create and setup pose detector
            let options = AccuratePoseDetectorOptions()
            options.detectorMode = .singleImage
            let poseDetector = PoseDetector.poseDetector(options: options)
            
            //step 3 - process the image
            // To detect objects asynchronously
            poseDetector.process(visionImage) { detectedPoses, error in
                guard error == nil else {
                    // Error.
                    print(error)
                    return
                }
                guard !detectedPoses!.isEmpty else {
                    // No pose detected.
                    print("No pose detected.")
                    return
                }
                
                // Success. Get pose landmarks here.
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // To get the image orientation
    func imageOrientation(
        deviceOrientation: UIDeviceOrientation,
        cameraPosition: AVCaptureDevice.Position
    ) -> UIImage.Orientation {
        switch deviceOrientation {
        case .portrait:
            return cameraPosition == .front ? .leftMirrored : .right
        case .landscapeLeft:
            return cameraPosition == .front ? .downMirrored : .up
        case .portraitUpsideDown:
            return cameraPosition == .front ? .rightMirrored : .left
        case .landscapeRight:
            return cameraPosition == .front ? .upMirrored : .down
        case .faceDown, .faceUp, .unknown:
            return .up
        }
    }
    
    
}



