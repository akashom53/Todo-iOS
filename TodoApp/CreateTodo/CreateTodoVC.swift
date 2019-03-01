//
//  CreateTodoVC.swift
//  TodoApp
//
//  Created by Akash Srivastava on 01/03/19.
//  Copyright © 2019 Akash Srivastava. All rights reserved.
//

import UIKit

class CreateTodoVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfDescription: MultilineTextField!
    @IBOutlet weak var btnPriority: UIBarButtonItem!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private lazy var actionSheet: UIAlertController = createActionSheet()
    private var doneButton: UIBarButtonItem!
    private var cancelButton: UIBarButtonItem!
    
    private let priorities = ["High", "Medium", "Low"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfTitle.delegate = self
        tfDescription.delegate = self
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonAction))
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonAction))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            if tfTitle.text?.count != 0 && tfDescription.text?.count != 0 {
                let todo = TodoEntity(context: context)
                todo.title = tfTitle.text
                todo.desc = tfDescription.text
                todo.completed = false
                todo.priority = Int16(priorities.firstIndex(of: btnPriority.title ?? "Low") ?? 2)
                do {
                    try context.save()
                } catch {
                    print("\(error)")
                }
            }
        }
    }
    
    private func createActionSheet() -> UIAlertController {
        let sheet = UIAlertController(title: "Choose Priority", message: nil, preferredStyle: .actionSheet)
        for priority in 0...2 {
            sheet.addAction(UIAlertAction(title: priorities[priority], style: .default, handler: setPriority))
        }
        return sheet
    }

    @IBAction func priorityButtonAction(_ sender: UIBarButtonItem) {
        present(actionSheet, animated: true, completion: nil);
    }
    
    func setPriority(_ action: UIAlertAction) {
        btnPriority.title = action.title
    }
    
    func textViewDidChange(_ textView: UITextView) {
        performValidation()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        performValidation()
        return true
    }
    private func performValidation() {
        if tfTitle.text?.count != 0 && tfDescription.text?.count != 0 {
            self.navigationItem.leftBarButtonItem = doneButton
        } else {
            self.navigationItem.leftBarButtonItem = cancelButton
        }
    }
    
    @objc private func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
