//
//  CameraViewController.swift
//  DevChat
//
//  Created by Per Kristensen on 01/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import Firebase

class CameraViewController: AAPLCameraViewController, AAPLCameraViewControllerDelegate {

    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.delegate = self

        super._previewView = previewView
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard FIRAuth.auth()?.currentUser != nil else {
            performSegue(withIdentifier: "LogInViewController", sender: nil)
            return
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func recordButtonPressed(sender: UIButton) {
        toggleMovieRecording()
    }
    
    @IBAction func changeCameraButtonPressed(sender: UIButton) {
        changeCamera()
    }
    
    // MARK: - AAPLCameraViewControllerDelegate
    
    func shouldEnableRecordUI(_ enable: Bool) {
        recordButton.isEnabled = enable
    }
    
    func shouldEnableCameraUI(_ enable: Bool) {
        cameraButton.isEnabled = enable
    }
    
    func canStartRecording() {
        
    }
    
    func recordingHasStarted() {
        
    }
    
    func videoRecordingComplete(_ videoURL: URL!) {
        performSegue(withIdentifier: "UsersViewController", sender: ["videoUrl": videoURL])
    }
    
    func videoRecordingFailed() {
        
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        performSegue(withIdentifier: "UsersViewController", sender: ["snapshotData": snapshotData])

    }
    
    func snapshotFailed() {
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UsersViewController" {
            if let usersViewController = segue.destination as? UsersViewController {
                if let videoDict = sender as? Dictionary<String, URL> {
                    usersViewController.videoUrl = videoDict["videoUrl"]
                } else if let imageData = sender as? Dictionary<String, Data> {
                    usersViewController.snapData = imageData["snapshotData"]
                }
            }
        }
    }
}

