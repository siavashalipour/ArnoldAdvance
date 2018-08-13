//
//  DiaryViewController.swift
//  ArnoldAdvance
//
//  Created by Siavash on 10/8/18.
//  Copyright © 2018 Siavash. All rights reserved.
//

import Foundation
import SnapKit
import FirebaseDatabase

final class DiaryViewController: UIViewController {
  
  var ref: DatabaseReference!
  
  private lazy var textView: UITextView = {
    let t = UITextView()
    t.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    t.textColor = #colorLiteral(red: 0.02745098039, green: 0.1215686275, blue: 0.2274509804, alpha: 1)
    t.textAlignment = .left
    t.keyboardType = .default
    t.returnKeyType = .default
    t.autocorrectionType = .no
    t.autocapitalizationType = .none
    t.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    return t
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Just Write"
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    let rightBarButton = UIBarButtonItem.init(title: "Save", style: .done, target: self, action: #selector(saveToFirebase))
    navigationItem.rightBarButtonItems = [rightBarButton]
    view.addSubview(textView)
    textView.snp.makeConstraints { (make) in
      make.top.left.right.equalToSuperview()
      make.height.equalTo(400)
    }
  }
  
  @objc
  private func saveToFirebase() {
    if textView.text.count < 1 { return }
    ref = Database.database().reference()
    ref.child("Diary - \(Date())").setValue(["Notes": textView.text])
  }
}

