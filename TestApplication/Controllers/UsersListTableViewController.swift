//
//  UsersListTableViewController.swift
//  TestApplication
//
//  Created by Андрей Илалов on 10.11.2017.
//  Copyright © 2017 Андрей Илалов. All rights reserved.
//

import UIKit
import SDWebImage

class UsersListTableViewController: UITableViewController {

    let cellReuseIdentifier = "UserListTableViewCell"
    
    let request = RequestRouter()
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request.dowloadUserInfo() { [weak self] completion in
            self?.users = completion
            self?.tableView.reloadData()
        }
        
        let nibCell = UINib(nibName: cellReuseIdentifier, bundle: nil)
        //tableView.register(nibCell, forCellWithReuseIdentifier: cellReuseIdentifier)
        tableView.register(nibCell, forCellReuseIdentifier: cellReuseIdentifier)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        request.dowloadUserInfo() { [weak self] completion in
            self?.users = completion
            self?.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! UserListTableViewCell
        
        cell.userEmailLabel.text = users[indexPath.row].email ?? "no email"
        cell.userFullNameLabel.text = (users[indexPath.row].firstName! + " " + users[indexPath.row].lastName!)
        
        cell.userAvatarImageView.sd_setImage(with: URL(string: users[indexPath.row].avatarUrl!), placeholderImage: UIImage(named: "MockImageWhite"), options: [.highPriority, .refreshCached, .retryFailed])

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            guard let editUserInfoViewController = segue.destination as? EditUserInfoViewController else
            {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let indexPath = sender as? IndexPath else
            {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            editUserInfoViewController.user = users[indexPath.row]
            editUserInfoViewController.buttonState = .edit
        }
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editSegue", sender: indexPath)
    }
    
    @IBAction func unwindToUsersListTableViewController(segue:UIStoryboardSegue) { }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
