//
//  WorkoutViewController.swift
//  ArnoldAdvance
//
//  Created by Siavash on 21/7/18.
//  Copyright © 2018 Siavash. All rights reserved.
//

import Foundation
import SnapKit
import FirebaseDatabase

enum WorkoutType: String {
  case chestBack
  case thighsCalves
  case shouldersArmsCalves
}

final class WorkoutViewController: UIViewController {
  
  var workout: WorkoutType?
  
  var ds: [String] = []
  
  var ref: DatabaseReference!
  
  
  private lazy var tableView: UITableView = {
    let tblView = UITableView()
    tblView.register(DayTableCell.self, forCellReuseIdentifier: String(describing: DayTableCell.self))
    tblView.dataSource = self
    tblView.delegate = self
    return tblView
  }()
  private lazy var scrollView: UIScrollView = {
    let s = UIScrollView()
    s.isScrollEnabled = true
    s.showsHorizontalScrollIndicator = false
    s.backgroundColor = .white
    return s
  }()
  private lazy var contentView: UIView = {
    let v = UIView()
    v.backgroundColor = .white
    return v
  }()
  
  private lazy var textView: UITextView = {
    let t = UITextView()
    t.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    t.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    t.textAlignment = .left
    t.keyboardType = .default
    t.returnKeyType = .default
    t.autocorrectionType = .no
    t.autocapitalizationType = .none
    t.delegate = self
    t.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
    return t
  }()
  private lazy var noteLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.text = "    Notes:"
    label.textAlignment = .left
    label.textColor = .white
    label.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    guard let workout = workout else { return }
    switch workout {
    case .chestBack:
      _ = chestWorkout.map({self.ds.append($0)})
      _ = backWorkout.map({self.ds.append($0)})
      _ = abs1.map({self.ds.append($0)})
    case .shouldersArmsCalves:
      _ = calvesWorkout.map({self.ds.append($0)})
      _ = shouldersWorkout.map({self.ds.append($0)})
      _ = upperArmsWorkout.map({self.ds.append($0)})
      _ = forearmsWokout.map({self.ds.append($0)})
      _ = abs2.map({self.ds.append($0)})
    case .thighsCalves:
      _ = thighsWorkout.map({self.ds.append($0)})
      _ = calvesWorkout.map({self.ds.append($0)})
    }
    tableView.reloadData()
  }
  @objc
  private func dismissKeyboard() {
    view.endEditing(true)

  }
  @objc
  private func saveToFirebase() {
    guard let workout = workout else { return }
    if textView.text.count < 1 { return }
    ref = Database.database().reference()
    ref.child("\(workout.rawValue) - \(Date())").setValue(["Notes": textView.text])
  }
  private func setupUI() {
    _ = view.subviews.map({$0.removeFromSuperview()})
    
    let rightBarbutton = UIBarButtonItem.init(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(dismissKeyboard))
    let rightBarButton2 = UIBarButtonItem.init(title: "Save", style: .done, target: self, action: #selector(saveToFirebase))
    navigationItem.rightBarButtonItems = [rightBarbutton,rightBarButton2]
    
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    scrollView.addSubview(contentView)
    contentView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalToSuperview().priority(250)
    }
    contentView.addSubview(textView)
    textView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalToSuperview()
      make.height.equalTo(270)
    }
    contentView.addSubview(noteLabel)
    noteLabel.snp.makeConstraints { (make) in
      make.left.right.equalToSuperview()
      make.height.equalTo(44)
      make.bottom.equalTo(textView.snp.top)
    }
    contentView.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.left.right.top.equalToSuperview()
      make.bottom.equalTo(noteLabel.snp.top)
    }
  }
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ds.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: DayTableCell
    if let aCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayTableCell.self)) as? DayTableCell {
      cell = aCell
    } else {
      cell = DayTableCell()
    }
    cell.config(with: ds[indexPath.row])
    return cell
  }
}
extension WorkoutViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
  }
  func textViewDidEndEditing(_ textView: UITextView) {
    scrollView.setContentOffset(CGPoint.zero, animated: true)
  }
}
