//
//  ContentView.swift
//  Circo Sampler
//
//  Created by Paul Circo on 4/15/21.
//

import SwiftUI
import AVKit

struct ContentView: View {

    var body: some View {
        TestView()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TestView: View {
    
    @State var recorder: AVAudioRecorder?
    @State var masterPlayer: AVAudioPlayer?
    
    @State var player1: AVAudioPlayer?
    @State var player2: AVAudioPlayer?
    @State var player3: AVAudioPlayer?
    @State var player4: AVAudioPlayer?
    @State var player5: AVAudioPlayer?
    @State var player6: AVAudioPlayer?
    @State var player7: AVAudioPlayer?
    @State var player8: AVAudioPlayer?
    
    @State var docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    @State var audioFile = URL(string: "")
    
    @State var rate = Float(1.0)
    
    var body: some View {
        HStack{
            
            Button(action: {
                recorder?.record()
                print("recording")
            }, label: {
                Text("Record")
                Image(systemName: "record.circle")
            })
            
            Button(action: {
                recorder?.stop()
                setupMasterPlayer()
            }, label: {
                Text("Stop")
                Image(systemName: "stop.circle")
            })
            
            Button(action: {
                do {
                    masterPlayer?.play()
                }
            }, label: {
                Text("Play")
                Image(systemName: "play.circle")
            })
        }.onAppear() {
            setup()
        }
        
        Slider(value: $rate, in: 0.1...1.9)
            .onChange(of: rate, perform: { value in
                masterPlayer?.rate = value
                print(rate)
            })
        
        HStack{
            Button(action: {
                setupPlayer1()
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
                setupPlayer2()
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
        
    }

    func setupMasterPlayer() {
        masterPlayer = try! AVAudioPlayer(contentsOf: recorder!.url)
        masterPlayer?.enableRate = true
    }

    func setupPlayer1() {
        do {
            player1 = try AVAudioPlayer(contentsOf: recorder!.url)
            player1?.enableRate = true
            player1?.rate = rate
            player1?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer2() {
        do {
            player2 = try AVAudioPlayer(contentsOf: recorder!.url)
            player2?.enableRate = true
            player2?.rate = rate
            player2?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer3() {
        do {
            player3 = try AVAudioPlayer(contentsOf: recorder!.url)
            player3?.enableRate = true
            player3?.rate = rate
            player3?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer4() {
        do {
            player4 = try AVAudioPlayer(contentsOf: recorder!.url)
            player4?.enableRate = true
            player4?.rate = rate
            player4?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer5() {
        do {
            player5 = try AVAudioPlayer(contentsOf: recorder!.url)
            player5?.enableRate = true
            player5?.rate = rate
            player5?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer6() {
        do {
            player6 = try AVAudioPlayer(contentsOf: recorder!.url)
            player6?.enableRate = true
            player6?.rate = rate
            player6?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer7() {
        do {
            player7 = try AVAudioPlayer(contentsOf: recorder!.url)
            player7?.enableRate = true
            player7?.rate = rate
            player7?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer8() {
        do {
            player8 = try AVAudioPlayer(contentsOf: recorder!.url)
            player8?.enableRate = true
            player8?.rate = rate
            player8?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

}
