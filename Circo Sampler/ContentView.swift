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
    @State var masterPlayer: AVAudioPlayer?
    
    @State var player1: AVAudioPlayer?
    @State var player2: AVAudioPlayer?
    
    @State var docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    @State var audioFile = URL(string: "")
    
    @State var rate = Float(1.0)
    
    var body: some View {
        HStack{
            
            Button(action: {
                recorder?.record()
                print("recording")
                print(recorder?.settings)
            }, label: {
                Text("Record")
                Image(systemName: "record.circle")
            })
            
            Button(action: {
                recorder?.stop()
            }, label: {
                Text("Stop")
                Image(systemName: "stop.circle")
            })
            
            Button(action: {
                do {
                    masterPlayer = try AVAudioPlayer(contentsOf: recorder!.url)
                    masterPlayer?.prepareToPlay()
                    masterPlayer?.play()
                } catch {
                    print("Can't play: \(error)")
                }
            }, label: {
                Text("Play")
                Image(systemName: "play.circle")
            })
        }.onAppear() {
            setup()
        }
        
        Slider(value: $rate, in: 0.5...1.5)
            .onChange(of: rate, perform: { value in
                masterPlayer?.rate = value
            })
        
        HStack{
            Button(action: {
                do {
                    player1 = try AVAudioPlayer(contentsOf: recorder!.url)
                    player1?.prepareToPlay()
                } catch {
                    print("Can't play: \(error)")
                }
            }, label: {
                Text("Store 1")
            })
            
            Button(action: {
                player1?.play()
            }, label: {
                Text("Play 1")
            })
        }
        
        HStack{
            Button(action: {
                do {
                    player2 = try AVAudioPlayer(contentsOf: recorder!.url)
                    player2?.prepareToPlay()
                } catch {
                    print("Can't play: \(error)")
                }
            }, label: {
                Text("Store 2")
            })
            
            Button(action: {
                player2?.play()
            }, label: {
                Text("Play 2")
            })
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
        masterPlayer?.enableRate = true
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
