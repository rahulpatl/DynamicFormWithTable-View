//
//  FormCell.swift
//  FormWithTableView
//
//  Created by Rahul Patil on 27/09/20.
//

import UIKit

protocol FormCellDelegate: class {
  func updateForm(data: FormModel, for index: Int)
}

class FormCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var valueTextField: UITextField!
  private weak var cellDelegate: FormCellDelegate?
  private var formData: FormModel?
  private var index: Int?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    prepareCell()
  }
  
  private func prepareCell() {
    valueTextField.delegate = self
  }
  
  func setForm(data: FormModel, and delegate: FormCellDelegate, for _index: Int) {
    formData = data
    index = _index
    cellDelegate = delegate
    titleLabel.text = data.title
    valueTextField.text = data.textValue
  }
}

extension FormCell: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    formData?.textValue = valueTextField.text
    cellDelegate?.updateForm(data: formData!, for: index!)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    endEditing(true)
    return false
  }
}
