//
//  CameraViewController.swift
//  DevChat
//
//  Created by Per Kristensen on 01/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class CameraViewController: AAPLCameraViewController, AAPLCameraViewControllerDelegate {

    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.delegate = self

        super._previewView = previewView
        super.viewDidLoad()
    }
    
    @IBAction func recordButtonPressed(sender: UIButton) {
        toggleMovieRecording()
    }
    
    @IBAction func changeCameraButtonPressed(sender: UIButton) {
        changeCamera()
    }
    
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
        
    }
    
    func videoRecordingFailed() {
        
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        
    }
    
    func snapshotFailed() {
        
    }
}

