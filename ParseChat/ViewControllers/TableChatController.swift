//
//  TableChatController.swift
//  ParseChat
//
//  Created by Shrijan Aryal on 9/23/18.
//  Copyright © 2018 Shrijan Aryal. All rights reserved.
//

import UIKit
import Parse

class TableChatController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var messageField: UITextField!
    var chatArray: [PFObject] = []
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.chatArray.count == 0{
            return 0
        }
        else{
            return self.chatArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)as! ChatCell
        cell.chatsObj = chatArray[indexPath.row]
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        onTimer()
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    @objc func onTimer() {
        // code to be run periodically
        let query = PFQuery(className: "Message")
        query.whereKeyExists("text").includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.chatArray = posts
                self.tableView.reloadData()
                
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    
    @IBAction func onLogOut(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)

    }
    
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = self.messageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success{
                print("The message was saved!")
                self.messageField.text = ""
            }else if let error = error{
                print("Problem saving message: \(error.localizedDescription)")
            }
            
        }
    
    }
    
}
