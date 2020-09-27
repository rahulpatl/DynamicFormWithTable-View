//
//  ViewController.swift
//  FormWithTableView
//
//  Created by Rahul Patil on 27/09/20.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  private var formData = [FormModel]() {
    didSet{
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareTable()
    prepareFormData()
  }
  
  private func prepareFormData() {
    formData = [
      FormModel(title: "Name", textValue: nil),
      FormModel(title: "Sex", textValue: nil),
      FormModel(title: "Address", textValue: nil),
      FormModel(title: "Age", textValue: nil),
      FormModel(title: "Contact Number", textValue: nil),
      FormModel(title: "Email", textValue: nil),
      FormModel(title: "Country", textValue: nil),
      FormModel(title: "Education", textValue: nil)
    ]
    title = "User Details"
  }
  
  private func prepareTable() {
    tableView.register(UINib(nibName: "FormCell", bundle: nil), forCellReuseIdentifier: "FormCell")
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    registerEventsForKeyboard()
  }
  
  deinit {
    unregisterEventsForKeyboard()
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return formData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FormCell") as? FormCell
    cell?.setForm(data: formData[indexPath.row], and: self, for: indexPath.row)
    return cell!
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
}

extension ViewController: FormCellDelegate {
  func updateForm(data: FormModel, for index: Int) {
    formData[index] = data
  }
}

extension ViewController {
  public func registerEventsForKeyboard() {
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: nil) { [weak self] notification in
      guard let self = self else {return}
      self.keyboardAppear(notification)
    }
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
      guard let self = self else {return}
      self.keyboardHide(notification, originInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
  }
  
  public func unregisterEventsForKeyboard() {
    NotificationCenter.default.removeObserver(self)
  }
  
  private func keyboardAppear(_ notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + CGFloat(30), right: 0)
    }
  }
  
  private func keyboardHide(_ notification: Notification, originInset: UIEdgeInsets) {
    var insets = originInset
    insets.top = tableView.contentInset.top
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.tableView.contentInset = insets
      self?.tableView.scrollIndicatorInsets = insets
    }
  }
}
