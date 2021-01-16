////  PoseViewController.swift
////  Self-Yoga
////
////  Created by itst on 12/1/2021.
////
//
//import AVFoundation
//import CoreVideo
//import MLKit
//
//class PoseViewController: UIViewController {
//  private let detectors: [Detector] = [
//    .pose,
//    .poseAccurate,
//  ]
//
//  private var currentDetector: Detector = .pose
//  private var isUsingFrontCamera = true
//  private var previewLayer: AVCaptureVideoPreviewLayer!
//  private lazy var captureSession = AVCaptureSession()
//  private lazy var sessionQueue = DispatchQueue(label: Constant.sessionQueueLabel)
//  private var lastFrame: CMSampleBuffer?
//    @IBOutlet weak var lblresult: UILabel!
//
//  private lazy var previewOverlayView: UIImageView = {
//
//    precondition(isViewLoaded)
//    let previewOverlayView = UIImageView(frame: .zero)
//    previewOverlayView.contentMode = UIView.ContentMode.scaleAspectFill
//    previewOverlayView.translatesAutoresizingMaskIntoConstraints = false
//    return previewOverlayView
//  }()
//
//  private lazy var annotationOverlayView: UIView = {
//    precondition(isViewLoaded)
//    let annotationOverlayView = UIView(frame: .zero)
//    annotationOverlayView.translatesAutoresizingMaskIntoConstraints = false
//    return annotationOverlayView
//  }()
//
//  private var poseDetector: PoseDetector? = nil
//  private var lastDetector: Detector?
//
//  @IBOutlet private weak var cameraView: UIView!
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//    setUpPreviewOverlayView()
//    setUpAnnotationOverlayView()
//    setUpCaptureSessionOutput()
//    setUpCaptureSessionInput()
//  }
//
//  override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//
//    startSession()
//  }
//
//  override func viewDidDisappear(_ animated: Bool) {
//    super.viewDidDisappear(animated)
//
//    stopSession()
//  }
//
//  override func viewDidLayoutSubviews() {
//    super.viewDidLayoutSubviews()
//
//    previewLayer.frame = cameraView.frame
//  }
//
//  @IBAction func selectDetector(_ sender: Any) {
//    presentDetectorsAlertController()
//  }
//
//  @IBAction func switchCamera(_ sender: Any) {
//    isUsingFrontCamera = !isUsingFrontCamera
//    removeDetectionAnnotations()
//    setUpCaptureSessionInput()
//  }
//
//
//  private func detectPose(in image: VisionImage, width: CGFloat, height: CGFloat) {
//    if let poseDetector = self.poseDetector {
//      var poses: [Pose]
//      do {
//        poses = try poseDetector.results(in: image)
//      } catch let error {
//        print("Failed to detect poses with error: \(error.localizedDescription).")
//        return
//      }
//      weak var weakSelf = self
//      DispatchQueue.main.sync {
//        guard let strongSelf = weakSelf else {
//          print("Self is nil!")
//          return
//        }
//        strongSelf.updatePreviewOverlayView()
//        strongSelf.removeDetectionAnnotations()
//      }
//      guard !poses.isEmpty else {
//        print("Pose detector returned no results.")
//        return
//      }
//      DispatchQueue.main.sync {
//        guard let strongSelf = weakSelf else {
//          print("Self is nil!")
//          return
//        }
//        // Pose detected. Currently, only single person detection is supported.
//        poses.forEach { pose in
//          for (startLandmarkType, endLandmarkTypesArray) in UIUtilities.poseConnections() {
//            let startLandmark = pose.landmark(ofType: startLandmarkType)
//            for endLandmarkType in endLandmarkTypesArray {
//              let endLandmark = pose.landmark(ofType: endLandmarkType)
//              let startLandmarkPoint = normalizedPoint(
//                fromVisionPoint: startLandmark.position, width: width, height: height)
//              let endLandmarkPoint = normalizedPoint(
//                fromVisionPoint: endLandmark.position, width: width, height: height)
//              UIUtilities.addLineSegment(
//                fromPoint: startLandmarkPoint,
//                toPoint: endLandmarkPoint,
//                inView: strongSelf.annotationOverlayView,
//                color: UIColor.green,
//                width: Constant.lineWidth
//              )
//            }
//          }
//          for landmark in pose.landmarks {
//            let landmarkPoint = normalizedPoint(
//              fromVisionPoint: landmark.position, width: width, height: height)
//            UIUtilities.addCircle(
//              atPoint: landmarkPoint,
//              to: strongSelf.annotationOverlayView,
//              color: UIColor.blue,
//              radius: Constant.smallDotRadius
//            )
//          }
//
//            let rightShoulder = pose.landmark(ofType: .rightShoulder) // 12
//            let rightElbow = pose.landmark(ofType: .rightElbow) // 14
//            let rightWrist = pose.landmark(ofType: .rightWrist) // 16
//            let rightHip = pose.landmark(ofType: .rightHip) // 24
//            let rightKnee = pose.landmark(ofType: .rightKnee) // 26
//
//            let leftShoulder = pose.landmark(ofType: .leftShoulder)
//            let leftElbow = pose.landmark(ofType: .leftElbow)
//            let leftWrist = pose.landmark(ofType: .leftWrist)
//            let leftHip = pose.landmark(ofType: .leftHip)
//            let leftKnee = pose.landmark(ofType: .leftKnee)
//
//            let rightArmAngle = UIUtilities.angle(
//                firstLandmark: rightShoulder,
//                midLandmark: rightElbow,
//                lastLandmark: rightWrist
//            )
//            let leftArmAngle = UIUtilities.angle(
//                firstLandmark: leftShoulder,
//                midLandmark: leftElbow,
//                lastLandmark: leftWrist
//            )
//
//            let rightHipAngle = UIUtilities.angle(
//                firstLandmark: rightShoulder,
//                midLandmark: rightHip,
//                lastLandmark: rightKnee
//            )
//            let leftHipAngle = UIUtilities.angle(
//                firstLandmark: leftShoulder,
//                midLandmark: leftHip,
//                lastLandmark: leftKnee
//            )
//
//            func checkPoses(rightHipAngle: CGFloat, leftHipAngle: CGFloat, currentPose: String) -> String {
//                // Warrier poes
//                if currentPose == "Warrier pose" &&
//                    rightArmAngle > 153 && rightArmAngle < 193 && leftArmAngle > 151 && leftArmAngle < 191 &&
//                    rightHipAngle > 95 && rightHipAngle < 135 && leftHipAngle > 120 && leftHipAngle < 160 ||
//                    currentPose == "Warrier pose" &&
//                    rightArmAngle > 153 && rightArmAngle < 193 && leftArmAngle > 151 && leftArmAngle < 191 &&
//                    leftHipAngle > 90 && leftHipAngle < 135 && rightHipAngle > 120 && rightHipAngle < 160 {
//                    return "You are doing Warrier pose"
//                }
//                // Tree pose
//                if currentPose == "Tree pose" &&
//                    rightArmAngle > 132 && rightArmAngle < 172 && leftArmAngle > 147 && leftArmAngle < 187 &&
//                    rightHipAngle > 145 && rightHipAngle < 185 && leftHipAngle > 129 && leftHipAngle < 169 ||
//                    currentPose == "Tree pose" &&
//                    rightArmAngle > 132 && rightArmAngle < 172 && leftArmAngle > 147 && leftArmAngle < 187 &&
//                    leftHipAngle > 145 && leftHipAngle < 185 && rightHipAngle > 129 && rightHipAngle < 169 {
//                    return "You are doing Tree pose"
//                }
//                // Dance pose (need variable)
//                if currentPose == "Dance pose" &&
//                    rightArmAngle > 134 && rightArmAngle < 174 && leftArmAngle > 155 && leftArmAngle < 195 &&
//                    rightHipAngle > 97 && rightHipAngle < 137 && leftHipAngle > 111 && leftHipAngle < 151 ||
//                    currentPose == "Dance pose" &&
//                    rightArmAngle > 134 && rightArmAngle < 174 && leftArmAngle > 155 && leftArmAngle < 195 &&
//                    leftHipAngle > 97 && leftHipAngle < 137 && rightHipAngle > 111 && rightHipAngle < 151 {
//                    return "You are doing Dance pose"
//                }
//                // Peacock Pose (need variable)
//                if currentPose == "Peacock pose" &&
//                    rightArmAngle > 93 && rightArmAngle < 133 && leftArmAngle > 102 && leftArmAngle < 142 &&
//                    rightHipAngle > 112 && rightHipAngle < 152 && leftHipAngle > 133 && leftHipAngle < 173 ||
//                    currentPose == "Peacock pose" &&
//                    rightArmAngle > 93 && rightArmAngle < 133 && leftArmAngle > 102 && leftArmAngle < 142 &&
//                    leftHipAngle > 112 && leftHipAngle < 152 && rightHipAngle > 133 && rightHipAngle < 173 {
//                    return "You are doing Peacock pose"
//                }
//                return "Try to make a Yoga pose"
//            }
//
//            let results = checkPoses(rightHipAngle: rightHipAngle, leftHipAngle: leftHipAngle, currentPose: "Warrier pose")
//            lblresult.text = ("\(results), rightArmAngle: \(rightArmAngle), leftArmAngle: \(leftArmAngle), rightHipAngle: \(rightHipAngle), leftHipAngle: \(leftHipAngle)")
//
//        }
//      }
//    }
//  }
//
//
//  private func setUpCaptureSessionOutput() {
//    weak var weakSelf = self
//    sessionQueue.async {
//      guard let strongSelf = weakSelf else {
//        print("Self is nil!")
//        return
//      }
//      strongSelf.captureSession.beginConfiguration()
//      strongSelf.captureSession.sessionPreset = AVCaptureSession.Preset.medium
//
//      let output = AVCaptureVideoDataOutput()
//      output.videoSettings = [
//        (kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA
//      ]
//      output.alwaysDiscardsLateVideoFrames = true
//      let outputQueue = DispatchQueue(label: Constant.videoDataOutputQueueLabel)
//      output.setSampleBufferDelegate(strongSelf, queue: outputQueue)
//      guard strongSelf.captureSession.canAddOutput(output) else {
//        print("Failed to add capture session output.")
//        return
//      }
//      strongSelf.captureSession.addOutput(output)
//      strongSelf.captureSession.commitConfiguration()
//    }
//  }
//
//  private func setUpCaptureSessionInput() {
//    weak var weakSelf = self
//    sessionQueue.async {
//      guard let strongSelf = weakSelf else {
//        print("Self is nil!")
//        return
//      }
//      let cameraPosition: AVCaptureDevice.Position = strongSelf.isUsingFrontCamera ? .front : .back
//      guard let device = strongSelf.captureDevice(forPosition: cameraPosition) else {
//        print("Failed to get capture device for camera position: \(cameraPosition)")
//        return
//      }
//      do {
//        strongSelf.captureSession.beginConfiguration()
//        let currentInputs = strongSelf.captureSession.inputs
//        for input in currentInputs {
//          strongSelf.captureSession.removeInput(input)
//        }
//
//        let input = try AVCaptureDeviceInput(device: device)
//        guard strongSelf.captureSession.canAddInput(input) else {
//          print("Failed to add capture session input.")
//          return
//        }
//        strongSelf.captureSession.addInput(input)
//        strongSelf.captureSession.commitConfiguration()
//      } catch {
//        print("Failed to create capture device input: \(error.localizedDescription)")
//      }
//    }
//  }
//
//  private func startSession() {
//    weak var weakSelf = self
//    sessionQueue.async {
//      guard let strongSelf = weakSelf else {
//        print("Self is nil!")
//        return
//      }
//      strongSelf.captureSession.startRunning()
//    }
//  }
//
//  private func stopSession() {
//    weak var weakSelf = self
//    sessionQueue.async {
//      guard let strongSelf = weakSelf else {
//        print("Self is nil!")
//        return
//      }
//      strongSelf.captureSession.stopRunning()
//    }
//  }
//
//  private func setUpPreviewOverlayView() {
//    cameraView.addSubview(previewOverlayView)
//    NSLayoutConstraint.activate([
//      previewOverlayView.centerXAnchor.constraint(equalTo: cameraView.centerXAnchor),
//      previewOverlayView.centerYAnchor.constraint(equalTo: cameraView.centerYAnchor),
//      previewOverlayView.leadingAnchor.constraint(equalTo: cameraView.leadingAnchor),
//      previewOverlayView.trailingAnchor.constraint(equalTo: cameraView.trailingAnchor),
//
//    ])
//  }
//
//  private func setUpAnnotationOverlayView() {
//    cameraView.addSubview(annotationOverlayView)
//    NSLayoutConstraint.activate([
//      annotationOverlayView.topAnchor.constraint(equalTo: cameraView.topAnchor),
//      annotationOverlayView.leadingAnchor.constraint(equalTo: cameraView.leadingAnchor),
//      annotationOverlayView.trailingAnchor.constraint(equalTo: cameraView.trailingAnchor),
//      annotationOverlayView.bottomAnchor.constraint(equalTo: cameraView.bottomAnchor),
//    ])
//  }
//
//  private func captureDevice(forPosition position: AVCaptureDevice.Position) -> AVCaptureDevice? {
//    if #available(iOS 10.0, *) {
//      let discoverySession = AVCaptureDevice.DiscoverySession(
//        deviceTypes: [.builtInWideAngleCamera],
//        mediaType: .video,
//        position: .unspecified
//      )
//      return discoverySession.devices.first { $0.position == position }
//    }
//    return nil
//  }
//
//  private func presentDetectorsAlertController() {
//    let alertController = UIAlertController(
//      title: Constant.alertControllerTitle,
//      message: Constant.alertControllerMessage,
//      preferredStyle: .alert
//    )
//    weak var weakSelf = self
//    detectors.forEach { detectorType in
//      let action = UIAlertAction(title: detectorType.rawValue, style: .default) {
//        [unowned self] (action) in
//        guard let value = action.title else { return }
//        guard let detector = Detector(rawValue: value) else { return }
//        guard let strongSelf = weakSelf else {
//          print("Self is nil!")
//          return
//        }
//        strongSelf.currentDetector = detector
//        strongSelf.removeDetectionAnnotations()
//      }
//      if detectorType.rawValue == self.currentDetector.rawValue { action.isEnabled = false }
//      alertController.addAction(action)
//    }
//    alertController.addAction(UIAlertAction(title: Constant.cancelActionTitleText, style: .cancel))
//    present(alertController, animated: true)
//  }
//
//  private func removeDetectionAnnotations() {
//    for annotationView in annotationOverlayView.subviews {
//      annotationView.removeFromSuperview()
//    }
//  }
//
//  private func updatePreviewOverlayView() {
//    guard let lastFrame = lastFrame,
//      let imageBuffer = CMSampleBufferGetImageBuffer(lastFrame)
//    else {
//      return
//    }
//    let ciImage = CIImage(cvPixelBuffer: imageBuffer)
//    let context = CIContext(options: nil)
//    guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
//      return
//    }
//    let rotatedImage = UIImage(cgImage: cgImage, scale: Constant.originalScale, orientation: .right)
//    if isUsingFrontCamera {
//      guard let rotatedCGImage = rotatedImage.cgImage else {
//        return
//      }
//      let mirroredImage = UIImage(
//        cgImage: rotatedCGImage, scale: Constant.originalScale, orientation: .leftMirrored)
//      previewOverlayView.image = mirroredImage
//    } else {
//      previewOverlayView.image = rotatedImage
//    }
//  }
//
//  private func convertedPoints(
//    from points: [NSValue]?,
//    width: CGFloat,
//    height: CGFloat
//  ) -> [NSValue]? {
//    return points?.map {
//      let cgPointValue = $0.cgPointValue
//      let normalizedPoint = CGPoint(x: cgPointValue.x / width, y: cgPointValue.y / height)
//      let cgPoint = previewLayer.layerPointConverted(fromCaptureDevicePoint: normalizedPoint)
//      let value = NSValue(cgPoint: cgPoint)
//      return value
//    }
//  }
//
//  private func normalizedPoint(
//    fromVisionPoint point: VisionPoint,
//    width: CGFloat,
//    height: CGFloat
//  ) -> CGPoint {
//    let cgPoint = CGPoint(x: point.x, y: point.y)
//    var normalizedPoint = CGPoint(x: cgPoint.x / width, y: cgPoint.y / height)
//    normalizedPoint = previewLayer.layerPointConverted(fromCaptureDevicePoint: normalizedPoint)
//    return normalizedPoint
//  }
//
//  private func resetManagedLifecycleDetectors(activeDetector: Detector) {
//    if activeDetector == self.lastDetector {
//      return
//    }
//
//    switch self.lastDetector {
//    case .pose, .poseAccurate:
//      self.poseDetector = nil
//      break
//    default:
//      break
//    }
//
//    switch activeDetector {
//    case .pose, .poseAccurate:
//      let options = activeDetector == .pose ? PoseDetectorOptions() : AccuratePoseDetectorOptions()
//      options.detectorMode = .stream
//      self.poseDetector = PoseDetector.poseDetector(options: options)
//      break
//    default:
//      break
//    }
//    self.lastDetector = activeDetector
//  }
//}
//
//extension MLKitViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
//
//  func captureOutput(
//    _ output: AVCaptureOutput,
//    didOutput sampleBuffer: CMSampleBuffer,
//    from connection: AVCaptureConnection
//  ) {
//    guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
//      print("Failed to get image buffer from sample buffer.")
//      return
//    }
//
//    let activeDetector = self.currentDetector
//    resetManagedLifecycleDetectors(activeDetector: activeDetector)
//
//    lastFrame = sampleBuffer
//    let visionImage = VisionImage(buffer: sampleBuffer)
//    let orientation = UIUtilities.imageOrientation(
//      fromDevicePosition: isUsingFrontCamera ? .front : .back
//    )
//
//    visionImage.orientation = orientation
//    let imageWidth = CGFloat(CVPixelBufferGetWidth(imageBuffer))
//    let imageHeight = CGFloat(CVPixelBufferGetHeight(imageBuffer))
//    var shouldEnableClassification = false
//    var shouldEnableMultipleObjects = false
//
//    switch activeDetector {
//    case .pose, .poseAccurate:
//      detectPose(in: visionImage, width: imageWidth, height: imageHeight)
//    }
//  }
//}
//
//public enum Detector: String {
//  case pose = "Pose Detection"
//  case poseAccurate = "Pose Detection, accurate"
//}
//
//private enum Constant {
//  static let alertControllerTitle = "Vision Detectors"
//  static let alertControllerMessage = "Select a detector"
//  static let cancelActionTitleText = "Cancel"
//  static let videoDataOutputQueueLabel = "com.google.mlkit.visiondetector.VideoDataOutputQueue"
//  static let sessionQueueLabel = "com.google.mlkit.visiondetector.SessionQueue"
//  static let noResultsMessage = "No Results"
//  static let localModelFile = (name: "bird", type: "tflite")
//  static let labelConfidenceThreshold = 0.75
//  static let smallDotRadius: CGFloat = 4.0
//  static let lineWidth: CGFloat = 3.0
//  static let originalScale: CGFloat = 1.0
//  static let padding: CGFloat = 10.0
//  static let resultsLabelHeight: CGFloat = 200.0
//  static let resultsLabelLines = 5
//  static let imageLabelResultFrameX = 0.4
//  static let imageLabelResultFrameY = 0.1
//  static let imageLabelResultFrameWidth = 0.5
//  static let imageLabelResultFrameHeight = 0.8
//}
