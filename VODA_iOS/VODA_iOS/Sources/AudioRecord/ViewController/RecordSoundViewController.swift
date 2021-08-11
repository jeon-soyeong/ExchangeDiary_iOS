//
//  RecordSoundViewController.swift
//  VODA_iOS
//
//  Created by 전소영 on 2021/07/22.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController {
    @IBOutlet weak var voiceRecordTitle: UILabel!
    @IBOutlet weak var recordTime: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordGuideText: UILabel!
    private var audioRecorder = VodaAudioRecorder.shared
    private var recordStatus: AudioRecordStatus?
    private var recordedAudioUrl: URL?
    var recordedDuration: TimeInterval?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.stopRecording {
            let playSoundViewController = segue.destination as? PlaySoundViewController
            playSoundViewController?.recordedAudioUrl = recordedAudioUrl
            playSoundViewController?.playDuration = recordedDuration
            playSoundViewController?.recordingTitle = "Untitle\(getCurrentDate())"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecordButtonUI(.idle)
       
        audioRecorder.delegate = self
        
        self.setNavigationBarTransparency()
        self.setBackButton(color: .black)
        
        (rootViewController as? MainViewController)?.setTabBarHidden(true)
        
        voiceRecordTitle.text = "Untitle\(getCurrentDate())"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordTime.text = "00:00"
    }
    
    private func setupRecordButtonUI(_ recordStatus: AudioRecordStatus) {
        switch recordStatus {
        case .idle, .prepared:
            stopButton.isHidden = true
        case .recording:
            recordButton.isHidden = true
            recordGuideText.isHidden = true
            stopButton.isHidden = false
        case .stopped:
            stopButton.isHidden = true
            recordButton.isHidden = false
            recordGuideText.isHidden = false
        default:
            break
        }
    }
    
    private func getCurrentDate() -> String {
        let nowDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        
        let currentDate = dateFormatter.string(from: nowDate)
        
        return currentDate
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        recordedDuration = audioRecorder.currentTime
        audioRecorder.stop()
    }
}

// MARK: AudioRecordable
extension RecordSoundViewController: AudioRecordable {
    func audioRecorder(_ audioPlayer: VodaAudioRecorder, didFinishedWithUrl url: URL?) {
        guard let recordedUrl = url else {
            return
        }
        recordedAudioUrl = recordedUrl
        print("recordedAudioURL: \(recordedUrl)")
        
        performSegue(withIdentifier: SegueIdentifier.stopRecording, sender: self)
    }
    
    func audioRecorder(_ audioPlayer: VodaAudioRecorder, didChangedStatus status: AudioRecordStatus) {
        print("recordStatus: \(status)")
        setupRecordButtonUI(status)
    }
    
    func audioRecorder(_ audioPlayer: VodaAudioRecorder, didUpdateCurrentTime currentTime: TimeInterval) {
        recordTime.text = currentTime.stringFromTimeInterval()
        recordedDuration = currentTime
    }
}
