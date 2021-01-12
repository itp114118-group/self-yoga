//
//  PoseViewController.swift
//  Self-Yoga
//
//  Created by itst on 12/1/2021.
//

import UIKit
import MLKit

class PoseViewController: UIViewController {
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
        
        
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
          
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

