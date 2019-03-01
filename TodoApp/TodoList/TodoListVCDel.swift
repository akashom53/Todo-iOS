//
//  TodoListVC.swift
//  TodoApp
//
//  Created by Akash Srivastava on 01/03/19.
//  Copyright © 2019 Akash Srivastava. All rights reserved.
//

import UIKit
import CoreData


class TodoCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    private let textPadding: CGFloat = 10;
    
    
    public func setData(todo todoEntity: TodoEntity) {
//        self.backgroundColor = UIColor.red
        labelTitle.text = todoEntity.title
        labelDescription.text = todoEntity.desc
    }
    
    
}

class TodoListVCDel: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "TodoCell"
    private let cellSpacing: CGFloat = 10;
    private let textPadding: CGFloat = 12;
    
    private var todoList = [TodoEntity]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodos()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Core Data read/write
    func fetchTodos() {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        
        do {
            todoList = try context.fetch(request)
        } catch {
            print("Error fetching todos from core data \(error)")
        }
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.todoList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TodoCell
    
        // Configure the cell
        cell.setData(todo: self.todoList[indexPath.row])
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

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
