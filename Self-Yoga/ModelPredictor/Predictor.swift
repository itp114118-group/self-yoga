////
////  Predictor.swift
////  Self-Yoga
////
////  Created by Jack on 27/12/2020.
////
//
//import Foundation
//
//class Predictor {

////    // Base pose detector with streaming, when depending on the PoseDetection SDK
////    let options = PoseDetectorOptions()
////    options.detectorMode = .stream
//
//    // Accurate pose detector on static images, when depending on the
//    // PoseDetectionAccurate SDK
//    let options = AccuratePoseDetectorOptions()
//    options.detectorMode = .singleImage
//
//    let poseDetector = PoseDetector.poseDetector(options: options)
//
//    let image = VisionImage(image: UIImage)
//    visionImage.orientation = image.imageOrientation
//
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
//    let image = VisionImage(buffer: sampleBuffer)
//    image.orientation = imageOrientation(
//      deviceOrientation: UIDevice.current.orientation,
//      cameraPosition: cameraPosition)
//
//    var results: [Pose]
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
//
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
//
//    for pose in detectedPoses {
//      let leftAnkleLandmark = pose.landmark(ofType: .leftAnkle)
//      if leftAnkleLandmark.inFrameLikelihood > 0.5 {
//        let position = leftAnkleLandmark.position
//      }
//    }
//
//    // Pose Classification Tips
//    func angle(
//          firstLandmark: PoseLandmark,
//          midLandmark: PoseLandmark,
//          lastLandmark: PoseLandmark
//      ) -> CGFloat {
//          let radians: CGFloat =
//              atan2(lastLandmark.position.y - midLandmark.position.y,
//                        lastLandmark.position.x - midLandmark.position.x) -
//                atan2(firstLandmark.position.y - midLandmark.position.y,
//                        firstLandmark.position.x - midLandmark.position.x)
//          var degrees = radians * 180.0 / .pi
//          degrees = abs(degrees) // Angle should never be negative
//          if degrees > 180.0 {
//              degrees = 360.0 - degrees // Always get the acute representation of the angle
//          }
//          return degrees
//      }
//
//    let rightHipAngle = angle(
//          firstLandmark: pose.landmark(ofType: .rightShoulder),
//          midLandmark: pose.landmark(ofType: .rightHip),
//          lastLandmark: pose.landmark(ofType: .rightKnee))
//
//}
