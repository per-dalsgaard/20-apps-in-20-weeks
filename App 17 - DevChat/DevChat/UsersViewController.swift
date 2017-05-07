    //
//  UsersViewController.swift
//  DevChat
//
//  Created by Per Kristensen on 04/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    
    private var _snapData: Data?
    private var _videoUrl: URL?
    
    var snapData: Data? {
        get {
            return _snapData
        } set {
            _snapData = newValue
        }
    }
    
    var videoUrl: URL? {
        get {
            return _videoUrl
        } set {
            _videoUrl = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, AnyObject> {
                        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let currentUsersUid = FIRAuth.auth()?.currentUser?.uid
                                if uid != currentUsersUid {
                                    let user = User(uid: uid, firstName: firstName)
                                    self.users.append(user)
                                }
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - UITableViewDataSource
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell {
            let user = users[indexPath.row]
            let userSelected = selectedUsers[user.uid] != nil
            cell.updateUi(user: user, selected: userSelected)
            return cell
        }
        return UserTableViewCell()
    }
    
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        markCellForRow(at: indexPath, selected: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        markCellForRow(at: indexPath, selected: false)

    }
    
    // MARK: - IBActions
    
    @IBAction func sendPullRequestButtonPressed(_ sender: UIBarButtonItem) {
        if let videoUrl = _videoUrl {
            let videoName = "\(NSUUID().uuidString)\(videoUrl.lastPathComponent)"
            let ref = DataService.instance.videosStorageRef.child(videoName)
            ref.putFile(videoUrl, metadata: nil, completion: { (meta: FIRStorageMetadata?, error: Error?) in
                if error != nil {
                    print("Error uploading video: \(error.debugDescription)")
                } else {
//                    let downloadUrl = metadata.downlo
                    if let downloadUrl = meta?.downloadURL() {
                        // TODO: Save this somewhere
                        
                        var users = [User]()
                        for user in self.selectedUsers.values {
                            users.append(user)
                        }
                        
                        let userId = FIRAuth.auth()!.currentUser!.uid
                        DataService.instance.sendMediaPullRequest(senderUid: userId, recipients: users, mediaUrl: downloadUrl)
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })

        } else if let snapData = _snapData {
            let imageName = "\(NSUUID().uuidString).jpg"
            let ref = DataService.instance.imagesStorageRef.child(imageName)
            ref.put(snapData, metadata: nil, completion: { (meta: FIRStorageMetadata?, error: Error?) in
                if error != nil{
                    print("Error uploading snapshot: \(error.debugDescription)")
                } else {
                    if let downloadUrl = meta?.downloadURL() {
                        // TODO: Save this somewhere
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    // MARK : - Miscellaneous
    
    func markCellForRow(at indexPath: IndexPath, selected: Bool) {
        if let cell = tableView.cellForRow(at: indexPath) as? UserTableViewCell {
            cell.setCheckmark(selected: selected)
            let user = users[indexPath.row]
            selectedUsers[user.uid] = selected ? user : nil
        }
        
        if selectedUsers.count > 0 {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}
