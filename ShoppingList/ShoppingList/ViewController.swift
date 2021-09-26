//
//  ViewController.swift
//  ShoppingList
//
//  Created by Berk Çohadar on 9/18/21.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var TableList: UITableView!
    @IBOutlet weak var AddButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TableList.delegate = self
        TableList.dataSource = self
    }
    var shoppingList:[String] = [];
    @IBAction func addToTable(_ sender: Any) {
        takeInput(title: "Add to List",
                  message: "Please enter an item below.",
                        actionTitle: "Add",
                        cancelTitle: "Cancel",
                        placeholder: "New item",
                        actionHandler:
                          { (input:String?) in
                            self.shoppingList.append(input!)
                            self.TableList.beginUpdates()
                            self.TableList.insertRows(at: [IndexPath(row: self.shoppingList.count-1, section: 0)], with: .automatic)
                            self.TableList.endUpdates()
                          }
                        )
    }
    @IBAction func shareTwitter(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: shoppingList, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
extension UITableView {
	
    func emptyScreen(_ text: String) { // Will be called when there is no item in the "shoppingList" array.
        let emptyMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyMessage.text = text
        emptyMessage.textColor = .black
        emptyMessage.numberOfLines = 0
        emptyMessage.textAlignment = .center
        emptyMessage.font = UIFont(name: "System", size: 16)
        //emptyMessage.sizeToFit()

        // background change down
        self.backgroundView = emptyMessage
        self.separatorStyle = .none
    }

    func restore() { // Will be called when item is added.
        // background change down. reset to default (nil)
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension UIViewController {
    func takeInput(title:String?,
                         message:String?,
                         actionTitle:String?,
                         cancelTitle:String?,
                         placeholder:String?,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = placeholder
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
    func normalizeQuery(_ url:String) -> String {
        return url.replacingOccurrences(of: " ", with: "+")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str: String = normalizeQuery("https://www.google.com/search?q="+shoppingList[indexPath[1]])
        if let url = URL(string: str) {
            UIApplication.shared.open(url)
        }
    }
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shoppingList.count == 0 {
            tableView.emptyScreen("No items yet! Press button to start.")
        } else {
            tableView.restore()
        }
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
}
