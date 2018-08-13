//
//  DaysViewController.swift
//  ArnoldAdvance
//
//  Created by Siavash on 21/7/18.
//  Copyright © 2018 Siavash. All rights reserved.
//

import Foundation
import SnapKit

final class DaysViewController: UIViewController {
  
  private lazy var tableView: UITableView = {
    let tblView = UITableView()
    tblView.register(DayTableCell.self, forCellReuseIdentifier: String(describing: DayTableCell.self))
    tblView.dataSource = self
    tblView.delegate = self
    return tblView
  }()
  
  override func viewDidLoad() {
    setupUI()
  }
  
  private func setupUI() {
    title = "L1"
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    let rightBarButtonItem = UIBarButtonItem.init(title: "Diary", style: .plain, target: self, action: #selector(didTapGoals))
    navigationItem.rightBarButtonItems = [rightBarButtonItem]
  }
  
  @objc
  private func didTapGoals() {
    let vc = DiaryViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension DaysViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return workoutDays.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: DayTableCell
    if let aCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayTableCell.self)) as? DayTableCell {
      cell = aCell
    } else {
      cell = DayTableCell()
    }
    cell.config(with: workoutDays[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = WorkoutViewController()
    vc.title = workoutDays[indexPath.row]
    switch indexPath.row {
    case 0: // Monday
      vc.workout = WorkoutType.shouldersArmsCalves
    case 1: // Tuesday
      vc.workout = WorkoutType.chestBack
    case 2: // Wednesday
      vc.workout = WorkoutType.thighsCalves
    case 3: // Thursday
      vc.workout = WorkoutType.shouldersArmsCalves
    case 4: // Friday AM
      vc.workout = WorkoutType.chestBack
    case 5: // Friday PM
      vc.workout = WorkoutType.thighsCalves
    case 6: // Saturday
      vc.workout = WorkoutType.shouldersArmsCalves
    case 7: // Sunday AM
      vc.workout = WorkoutType.chestBack
    case 8: // Sunday PM
      vc.workout = WorkoutType.thighsCalves
    default:
      break
    }
    navigationController?.pushViewController(vc, animated: true)
  }
}

final class DayTableCell: UITableViewCell {
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    label.textAlignment = .left
    label.textColor = .black
    label.numberOfLines = 0
    return label
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func config(with title: String) {
    titleLabel.text = title
  }
  
  private func setupUI() {
    _ = contentView.subviews.map({$0.removeFromSuperview()})
    selectionStyle = .none
    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.left.top.equalTo(16)
      make.right.equalTo(-16)
      make.centerY.equalToSuperview()
    }
  }
}
