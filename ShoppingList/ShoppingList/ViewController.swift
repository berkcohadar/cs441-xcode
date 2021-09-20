//
//  ViewController.swift
//  ShoppingList
//
//  Created by Berk Çohadar on 9/18/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TableList: UITableView!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var InputArea: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TableList.delegate = self
        TableList.dataSource = self
    }
    var tasks:[String] = [];
    @IBAction func addToTable(_ sender: Any) {
        if InputArea.text != ""{
            tasks.append(InputArea.text!)
            TableList.beginUpdates()
            TableList.insertRows(at: [IndexPath(row: tasks.count-1, section: 0)], with: .automatic)
            TableList.endUpdates()
            InputArea.text = ""
        }
        else{
            showInputDialog(title: "Add task",
                            subtitle: "Please enter a new task below.",
                            actionTitle: "Add",
                            cancelTitle: "Cancel",
                            inputPlaceholder: "New task",
                            inputKeyboardType: .phonePad,
                            actionHandler:
                                    { (input:String?) in
                                        self.tasks.append(input!)
                                        self.TableList.beginUpdates()
                                        self.TableList.insertRows(at: [IndexPath(row: self.tasks.count-1, section: 0)], with: .automatic)
                                        self.TableList.endUpdates()
                                    })
        }
    }
    
}
extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped!")
    }
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
}
