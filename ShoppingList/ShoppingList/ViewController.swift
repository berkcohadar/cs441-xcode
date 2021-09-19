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
    var num = 1;
    @IBAction func addToTable(_ sender: Any) {
        if InputArea.text != ""{
            tasks.append(InputArea.text!)
            TableList.beginUpdates()
            TableList.insertRows(at: [IndexPath(row: tasks.count-1, section: 0)], with: .automatic)
            TableList.endUpdates()
            InputArea.text = ""
        }
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

