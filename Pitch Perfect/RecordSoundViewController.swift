//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Micheal on 5/5/16.
//  Copyright © 2016 Micheal. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController,AVAudioRecorderDelegate {

    @IBOutlet weak var recordLabel: UILabel!

    @IBOutlet weak var recordButton: UIButton!

    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.enabled = false

    }

   
    @IBAction func recordAideo(sender: AnyObject) {
        recordButton.enabled = false
        stopRecordingButton.enabled = true
        recordLabel.text = "Recording is in processing"
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    @IBAction func stopRecording(sender: AnyObject) {
        recordButton.enabled = true
        stopRecordingButton.enabled = false
        recordLabel.text = "Tap to record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setActive(false)

        
        
    }

    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }else{
            print("AvAudioRecorder finished saving recording")

        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            if (segue.identifier == "stopRecording") {
                let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
                let recordedAudioURL = sender as! NSURL
                playSoundsVC.recordedAudioURL = recordedAudioURL
            }
    }
    
}

