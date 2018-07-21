//
//  WorkoutViewController.swift
//  ArnoldAdvance
//
//  Created by Siavash on 21/7/18.
//  Copyright © 2018 Siavash. All rights reserved.
//

import Foundation
import SnapKit

enum WorkoutType {
  case chestBack
  case thighsCalves
  case shouldersArmsCalves
}

final class WorkoutViewController: UIViewController {
  
  var workout: WorkoutType?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
