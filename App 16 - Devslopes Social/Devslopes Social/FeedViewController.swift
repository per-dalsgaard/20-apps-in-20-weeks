//
//  FeedViewController.swift
//  Devslopes Social
//
//  Created by Per Kristensen on 25/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postImageButton: RoundButton!
    @IBOutlet weak var captionTextField: UITextField!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        DataSerice.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let postDataDict = snap.value as? Dictionary<String, AnyObject> {
                        let postId = snap.key
                        let post = Post(postId: postId, postData: postDataDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell {
            let post = posts[indexPath.row]
            let image = FeedViewController.imageCache.object(forKey: post.imageUrl as NSString)
            cell.configureCell(post: posts[indexPath.row], postImage: image)
            return cell
        }
        return PostTableViewCell()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAtIndexPath")
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            postImageButton.setImage(image, for: .normal)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    
    @IBAction func addImageButtonPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        guard let caption = captionTextField.text , caption != "" else {
            print("Caption must be entered")
            return
        }
        
        guard let postImage = postImageButton.image(for: .normal) , postImageButton.currentImage != UIImage(named: "add-image") else {
            print("An image must be selected")
            return
        }
        
        if let postImageData = UIImageJPEGRepresentation(postImage, 0.2) {
            let imageUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            DataSerice.ds.REF_POST_IMAGES.child(imageUid).put(postImageData, metadata: metadata, completion: { (metadata, error) in
                if error != nil {
                    print("Unable to upload image to Firebase storage")
                } else {
                    print("Successfully uploaded image")
                    let postImageUrl = metadata?.downloadURL()?.absoluteString
                    print(postImageUrl)
                }
            })
        }
    }
}
