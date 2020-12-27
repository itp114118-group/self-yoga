////
////  Predictor.swift
////  Self-Yoga
////
////  Created by Jack on 27/12/2020.
////
//
//import Foundation
//import CoreML
//import Vision
//
//class Predictor {
//
//    let playerActionClassifier = PlayerActionClassifier()
//
//    let humanBodyPoseRequest = VNDetectHumanBodyPoseRequest()
//
//    var posesWindow: [VNRecognizedPointsObservation?] = []
//
//    init() {
//        posesWindow.reserveCapacity(predictionWindowSize)
//    }
//
//    func processFrame(_ samplebuffer: CMSampleBuffer) throws -> [VNRecognizedPointsObservation] {
//            // 抓取出视频中的动作
//            let framePoses = extractPoses(from: samplebuffer)
//
//            // 选择视频中最明显的那个人
//            let pose = try selectMostProminentPerson(from: framePoses)
//
//            // 将数据点导入分析窗口
//            posesWindow.append(pose)
//
//            return framePoses
//        }
//
//    var isReadyToMakePrediction: Bool {
//        posesWindow.count == predictionWindowSize
//    }
//
//    func makePrediction() throws -> PredictionOutput {
//        // 将数据识别点转化为多维特征矩阵
//        let poseMultiArrays: [MLMultiArray] = try posesWindow.map { person in
//            guard let person = person else {
//                return zeroPaddedMultiArray()
//            }
//            return try person.keypointsMultiArray()
//        }
//
//        // 数据处理
//        let modelInput = MLMultiArray(concatenating: poseMultiArrays, axis: 0, dataType: .float)
//
//        // 调用分类器模型对数据进行分析
//        let predictions = try playerActionClassifier.prediction(poses: modelInput)
//
//        // 重置分析窗口
//        posesWindow.removeFirst(predictionInterval)
//
//       // 返回动作类型及其相关的置信度
//        return (
//            label: predictions.label,
//            confidence: predictions.labelProbabilities[predictions.label]!
//        )
//    }
//}
