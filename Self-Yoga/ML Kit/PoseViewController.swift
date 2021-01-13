////
////  PoseViewController.swift
////  Self-Yoga
////
////  Created by itst on 12/1/2021.
////
//
//import UIKit
//import MLKit
//import MLKitPoseDetection
//import AVFoundation
//
//class PoseViewController: UIViewController {
//
//    var visionImage: UIImage?
//    var lastFrame: CMSampleBuffer?
//
//    let detectorOPtions = PoseDetectorOptions()
//
//    // If use image to perform Pose Detection
//    let options = AccuratePoseDetectorOptions()
//    let image = VisionImage(image: UIImage(named: "background.png")!)
//
//    // If use stream to perform Pose Detection
//    //    let options = PoseDetectorOptions()
////    let image = VisionImage(buffer: sampleBuffer)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Define detector mode, either single image or stream
////        detectorOPtions.detectorMode = .stream
//        options.detectorMode = .singleImage
//
//        let poseDetector = PoseDetector.poseDetector(options: options)
//
//        // If use image
//        visionImage.orientation = image.imageOrientation
//
//        // If use stream
////        image.orientation = imageOrientation(
////          deviceOrientation: UIDevice.current.orientation,
////          cameraPosition: cameraPosition)
//
//        // Do any additional setup after loading the view.
//    }
//
//    // If use CMSapleBufferRef (stream)
////    func imageOrientation(
////      deviceOrientation: UIDeviceOrientation,
////      cameraPosition: AVCaptureDevice.Position
////    ) -> UIImage.Orientation {
////      switch deviceOrientation {
////      case .portrait:
////        return cameraPosition == .front ? .leftMirrored : .right
////      case .landscapeLeft:
////        return cameraPosition == .front ? .downMirrored : .up
////      case .portraitUpsideDown:
////        return cameraPosition == .front ? .rightMirrored : .left
////      case .landscapeRight:
////        return cameraPosition == .front ? .upMirrored : .down
////      case .faceDown, .faceUp, .unknown:
////        return .up
////      }
////    }
//
////
////    var results: [Pose] = []
////    do {
////      results = try poseDetector.results(in: image)
////    } catch let error {
////      print("Failed to detect pose with error: \(error.localizedDescription).")
////      return
////    }
////    guard let detectedPoses = results, !detectedPoses.isEmpty else {
////      print("Pose detector returned no results.")
////      return
////    }
//
////    // Success. Get pose landmarks here.
////
////    poseDetector.process(image) { detectedPoses, error in
////      guard error == nil else {
////        // Error.
////        return
////      }
////      guard !detectedPoses.isEmpty else {
////        // No pose detected.
////        return
////      }
////
////      // Success. Get pose landmarks here.
////    }
//
//
//        func angle(
//              firstLandmark: PoseLandmark,
//              midLandmark: PoseLandmark,
//              lastLandmark: PoseLandmark
//          ) -> CGFloat {
//              let radians: CGFloat =
//                  atan2(lastLandmark.position.y - midLandmark.position.y,
//                            lastLandmark.position.x - midLandmark.position.x) -
//                    atan2(firstLandmark.position.y - midLandmark.position.y,
//                            firstLandmark.position.x - midLandmark.position.x)
//              var degrees = radians * 180.0 / .pi
//              degrees = abs(degrees) // Angle should never be negative
//              if degrees > 180.0 {
//                  degrees = 360.0 - degrees // Always get the acute representation of the angle
//              }
//              return degrees
//          }
//
//    }
//

//
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
            // To detect objects synchronously
            var results: [Pose]
            do {
              results = try poseDetector.results(in: visionImage)
            } catch let error {
              print("Failed to detect pose with error: \(error.localizedDescription).")
              return
            }
            guard !results.isEmpty else {
              print("Pose detector returned no results.")
              return
            }
            // To detect objects asynchronously
//            poseDetector.process(visionImage) { detectedPoses, error in
//              guard error == nil else {
//                // Error.
//                return
//              }
//              guard !detectedPoses!.isEmpty else {
//                // No pose detected.
//                return
//              }
//
//              // Success. Get pose landmarks here.
//            }

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



