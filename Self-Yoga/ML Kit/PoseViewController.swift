//
//  PoseViewController.swift
//  Self-Yoga
//
//  Created by itst on 12/1/2021.
//

import UIKit
import MLKit
import MLKitPoseDetection

class PoseViewController: UIViewController{
    
    var visionImage: UIImage?
//
    override func viewDidLoad() {
        super.viewDidLoad()

        // Base pose detector with streaming, when depending on the PoseDetection SDK
        let detectorOPtions = PoseDetectorOptions()
        detectorOPtions.detectorMode = .stream

        // Accurate pose detector on static images, when depending on the
        // PoseDetectionAccurate SDK
        let accOptions = AccuratePoseDetectorOptions()
        accOptions.detectorMode = .singleImage
        // Do any additional setup after loading the view.

        let poseDetector = PoseDetector.poseDetector(options: accOptions)

        let Uiimage = VisionImage(image: UIImage())
//        visionImage.orientation = Uiimage.imageOrientation

//        let Bufimage = VisionImage(buffer: sampleBuffer)
//        image.orientation = imageOrientation(
//          deviceOrientation: UIDevice.current.orientation,
//          cameraPosition: cameraPosition)
    }

//    func imageOrientation(
//      deviceOrientation: UIDeviceOrientation,
//      cameraPosition: AVCaptureDevice.Position
//    ) -> UIImage.Orientation {
//      switch deviceOrientation {
//      case .portrait:
//        return cameraPosition == .front ? .leftMirrored : .right
//      case .landscapeLeft:
//        return cameraPosition == .front ? .downMirrored : .up
//      case .portraitUpsideDown:
//        return cameraPosition == .front ? .rightMirrored : .left
//      case .landscapeRight:
//        return cameraPosition == .front ? .upMirrored : .down
//      case .faceDown, .faceUp, .unknown:
//        return .up
//      }
//    }
//
//    var results: [Pose] = []
//    do {
//      results = try poseDetector.results(in: image)
//    } catch let error {
//      print("Failed to detect pose with error: \(error.localizedDescription).")
//      return
//    }
//    guard let detectedPoses = results, !detectedPoses.isEmpty else {
//      print("Pose detector returned no results.")
//      return
//    }

//    // Success. Get pose landmarks here.
//
//    poseDetector.process(image) { detectedPoses, error in
//      guard error == nil else {
//        // Error.
//        return
//      }
//      guard !detectedPoses.isEmpty else {
//        // No pose detected.
//        return
//      }
//
//      // Success. Get pose landmarks here.
//    }


        func angle(
              firstLandmark: PoseLandmark,
              midLandmark: PoseLandmark,
              lastLandmark: PoseLandmark
          ) -> CGFloat {
              let radians: CGFloat =
                  atan2(lastLandmark.position.y - midLandmark.position.y,
                            lastLandmark.position.x - midLandmark.position.x) -
                    atan2(firstLandmark.position.y - midLandmark.position.y,
                            firstLandmark.position.x - midLandmark.position.x)
              var degrees = radians * 180.0 / .pi
              degrees = abs(degrees) // Angle should never be negative
              if degrees > 180.0 {
                  degrees = 360.0 - degrees // Always get the acute representation of the angle
              }
              return degrees
          }
        
    }
          

