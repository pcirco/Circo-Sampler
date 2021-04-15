//
//  ContentView.swift
//  Circo Sampler
//
//  Created by Paul Circo on 4/15/21.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @State var recorder: AVAudioRecorder?
    @State var player: AVAudioPlayer?
    
    @State var docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    @State var audioFile = URL(string: "")
    
    var body: some View {
        HStack{
            Text("to be continued...")
        }
    }
    
    func setup() {
        
        audioFile = docDir
        audioFile?.appendPathComponent("scratch.caf")
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord)
        } catch {
            print(error)
        }
        
        let recordingSettings = [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 44100.0, AVNumberOfChannelsKey: 2, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue] as [String: Any]
        
        do {
            try recorder = AVAudioRecorder(url: audioFile!, settings: recordingSettings)
        } catch {
            print("recorder setup issues = \(error)")
        }
        
        recorder?.prepareToRecord()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
