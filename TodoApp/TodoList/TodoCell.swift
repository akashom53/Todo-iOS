//
//  TodoCell2.swift
//  TodoApp
//
//  Created by Akash Srivastava on 01/03/19.
//  Copyright © 2019 Akash Srivastava. All rights reserved.
//

import UIKit

class TodoCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    private let textPadding: CGFloat = 10;
    @IBOutlet weak var titleBottomConstraint: NSLayoutConstraint!
    public var delegate: TodoDelegate!
    private var todo: TodoEntity!
    
    private let colors = [
        UIColor(displayP3Red: 1, green: 0.7, blue: 0.7, alpha: 1),
        UIColor(displayP3Red: 1, green: 0.95, blue: 0.7, alpha: 1),
        UIColor(displayP3Red: 0.7, green: 1, blue: 0.7, alpha: 1)
    ];
    
    
    private func getColor(_ priority: Int16) -> UIColor {
        return colors[Int(priority)]
    }
    
    public func setData(todo todoEntity: TodoEntity) {
        self.todo = todoEntity
        labelTitle.text = todoEntity.title
        labelDesc.text = todoEntity.desc
        self.backgroundColor = getColor(todoEntity.priority)
        self.layer.cornerRadius = 8
    }
    @IBAction func removeClicked(_ sender: UIButton) {
        if (delegate != nil) {
            delegate.removeClicked(self.todo)
        }
    }
}
