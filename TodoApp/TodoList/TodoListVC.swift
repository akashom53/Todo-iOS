//
//  TodoListVC2.swift
//  TodoApp
//
//  Created by Akash Srivastava on 01/03/19.
//  Copyright © 2019 Akash Srivastava. All rights reserved.
//

import UIKit
import CoreData


public protocol TodoDelegate {
    func removeClicked(_ todo:TodoEntity)
}

class TodoListVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, TodoDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let reuseIdentifier = "TodoCell"
    private let cellSpacing: CGFloat = 10;
    private let textPadding: CGFloat = 12;
    
    private var todoList = [TodoEntity]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "Todo App"
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        layout.minimumLineSpacing = 12
        collectionView!.collectionViewLayout = layout
//        seedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTodos()
    }
    
    // MARK: Core Data read/write
    func fetchTodos() {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        do {
            todoList = try context.fetch(request).reversed()
        } catch {
            print("Error fetching todos from core data \(error)")
        }
        collectionView.reloadData()
    }
    
    func seedData() {
        for index in 1...5 {
            let todo = TodoEntity(context: context)
            todo.desc = "Test description for  hsdf jhdsf jhdf hidas seeded data: \(index)"
            todo.title = "Todo: \(index)"
            todo.completed = false
            do {
                try context.save()
            } catch {
                print("Error saving todo to core data \(error)")
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.todoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TodoCell
        
        // Configure the cell
        cell.setData(todo: self.todoList[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    private func getCellWidth() -> CGFloat {
        
        return ((collectionView.frame.size.width / 2.0) - (cellSpacing * 2))
    }
    
    private func getCellSize(_ todo: TodoEntity) -> CGSize {
        let font = UIFont.systemFont(ofSize: 17)
        let width = getCellWidth() - (10 * 2)
        let titleHeight = todo.title!.height(withConstrainedWidth: width, font: font) + (textPadding * 2)
        let descHeight = todo.desc!.height(withConstrainedWidth: width, font: font) + (textPadding * 2)
        return CGSize(width: getCellWidth(), height: (titleHeight + descHeight))
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCellSize(self.todoList[indexPath.row])
    }
    
    
    func removeClicked(_ todo: TodoEntity) {
        context.delete(todo)
        do {
            try context.save()
        } catch {
            print("Error saving todo to core data \(error)")
        }
        todoList.remove(at: todoList.firstIndex(of: todo)!)
        collectionView.reloadData()
    }
    
}

