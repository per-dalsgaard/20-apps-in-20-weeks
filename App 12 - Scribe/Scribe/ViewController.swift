//
//  ViewController.swift
//  Scribe
//
//  Created by Per Kristensen on 19/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextView: UITextView!

    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activitySpinner.isHidden = true
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        transcriptionTextView.text = ""
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == .authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer.delegate = self
                        self.audioPlayer.play()
                    } catch {
                        // TODO: Handle error
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                        if let error = error {
                            print("There was an error: \(error)")
                        } else {
                            if let transcription = result?.bestTranscription.formattedString {
                                self.transcriptionTextView.text = transcription
                            }
                        }
                    })
                }
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.audioPlayer.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
}

