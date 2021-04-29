//
//  ContentView.swift
//  Circo Sampler
//
//  Created by Paul Circo on 4/15/21.
//

import SwiftUI
import AVKit


/**
 The Circo Sampler is a simple tabbed app that turns the user's iOS device into a basic audio sampler.  The app has two tabs: "Recording Mode" and "Playaback Mode."
 In "Recording Mode," the user is able to record, stop recording, and playback audio clips using the device's onboard microphone.  There is also a slider to control the playback rate of the recorded clips.
 When the user is satisfied with a recorded audio clip, they may tap on any of the 8 rectangles to store the audio clip in that rectangle.  When the user switches over to "Playback Mode," if they click on a rectangle that
 they have stored an audio clip in, the device will play the stored audio clip.
 */
struct ContentView: View {
    
    static var player1: AVAudioPlayer?
    static var player2: AVAudioPlayer?
    static var player3: AVAudioPlayer?
    static var player4: AVAudioPlayer?
    static var player5: AVAudioPlayer?
    static var player6: AVAudioPlayer?
    static var player7: AVAudioPlayer?
    static var player8: AVAudioPlayer?

    var body: some View {
        
        TabView(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
                content:  {
                    RecordView().tabItem { Text("Recording Mode") }.tag(1)
                    PlaybackView().tabItem { Text("Playback Mode") }.tag(2)
                })
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PlaybackView: View {
    
    @State var alert = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            VStack{
                
                HStack {
                    
                    Text("Playback Mode")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("AccentColor"))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                    
                    Button(action: {
                        alert = true
                    }, label: {
                        Image(systemName: "info.circle.fill")
                            .padding(.trailing)
                    })
                    .alert(isPresented: $alert, content: {
                        Alert(title: Text("Circo Sampler"),
                              message: Text("The Circo Sampler was developed by Paul Circo for the coding and composing course at the University of Nebraska-Lincoln.  Paul is a senior electrical engineering major with an emphasis in electronics and minors in physics and music technology.  In his free time, Paul loves watching sports, playing his trumpet, and listening to music.  Enjoy, and Go Big Red!"),
                              dismissButton: .default(Text("Close")))
                    })
                    
                    
                }
                
                
                HStack(){
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("1")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            ContentView.player1?.play()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("2")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            ContentView.player2?.play()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("3")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            ContentView.player3?.play()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("4")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            ContentView.player4?.play()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                }
                .padding(.horizontal)
                
                HStack(){
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("5")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            ContentView.player5?.play()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("6")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            ContentView.player6?.play()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("7")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            ContentView.player7?.play()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("8")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            ContentView.player8?.play()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                }
                .padding([.leading, .bottom, .trailing])
                
            }
            
        }
        
        
        
        
    }
    
}

struct RecordView: View {
    
    @State var recorder: AVAudioRecorder?
    @State var masterPlayer: AVAudioPlayer?
    
    @State var docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    @State var audioFile = URL(string: "")
    
    @State var rate = Float(1.0)
    
    @State var alert = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Recording Mode")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("AccentColor"))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                    
                    Button(action: {
                        alert = true
                    }, label: {
                        Image(systemName: "info.circle.fill")
                            .padding(.trailing)
                    })
                    .alert(isPresented: $alert, content: {
                        Alert(title: Text("Circo Sampler"),
                              message: Text("The Circo Sampler was developed by Paul Circo for the coding and composing course at the University of Nebraska-Lincoln.  Paul is a senior electrical engineering major with an emphasis in electronics and minors in physics and music technology.  In his free time, Paul loves watching sports, playing his trumpet, and listening to music.  Enjoy, and Go Big Red!"),
                              dismissButton: .default(Text("Close")))
                    })
                    
                }
                
                
                HStack{
                    
                    Button(action: {
                        recorder?.stop()
                        setupMasterPlayer()
                    }, label: {
                        Image(systemName: "stop.circle.fill")
                            .imageScale(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                    })
                    
                    
                    Button(action: {
                        do {
                            masterPlayer?.play()
                        }
                    }, label: {
                        Image(systemName: "play.circle.fill")
                            .imageScale(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                    })
                    .padding(.horizontal)
                    
                    Button(action: {
                        rate = 1.0
                        recorder?.record()
                        print("recording")
                    }, label: {
                        Image(systemName: "record.circle.fill")
                            .imageScale(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                    })
                    
                }.padding(.vertical).onAppear() {
                    setup()
                }
                
                Slider(value: $rate, in: 0.1...1.9)
                    .padding([.top, .leading, .trailing])
                    .onChange(of: rate, perform: { value in
                        masterPlayer?.rate = value
                        print(rate)
                    })
                Text("Playback Rate")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.bottom)
                    
                
                HStack(){
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("1")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            setupPlayer1()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("2")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            setupPlayer2()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("3")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            setupPlayer3()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("4")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            setupPlayer4()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                }
                .padding(.horizontal)
                
                HStack(){
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("5")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            setupPlayer5()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("6")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            setupPlayer6()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("7")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            setupPlayer7()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                    
                    RoundedRectangle(cornerRadius: 50, style: .circular)
                        .fill(Color.purple)
                        .overlay(Text("8")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor")))
                        .onTapGesture {
                            setupPlayer8()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("AccentColor"), lineWidth: 5))
                }
                .padding(.horizontal)
            
            }
            .padding(.bottom)
        
        
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
            ContentView.player1 = try AVAudioPlayer(contentsOf: recorder!.url)
            ContentView.player1?.enableRate = true
            ContentView.player1?.rate = rate
            ContentView.player1?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer2() {
        do {
            ContentView.player2 = try AVAudioPlayer(contentsOf: recorder!.url)
            ContentView.player2?.enableRate = true
            ContentView.player2?.rate = rate
            ContentView.player2?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer3() {
        do {
            ContentView.player3 = try AVAudioPlayer(contentsOf: recorder!.url)
            ContentView.player3?.enableRate = true
            ContentView.player3?.rate = rate
            ContentView.player3?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer4() {
        do {
            ContentView.player4 = try AVAudioPlayer(contentsOf: recorder!.url)
            ContentView.player4?.enableRate = true
            ContentView.player4?.rate = rate
            ContentView.player4?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer5() {
        do {
            ContentView.player5 = try AVAudioPlayer(contentsOf: recorder!.url)
            ContentView.player5?.enableRate = true
            ContentView.player5?.rate = rate
            ContentView.player5?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer6() {
        do {
            ContentView.player6 = try AVAudioPlayer(contentsOf: recorder!.url)
            ContentView.player6?.enableRate = true
            ContentView.player6?.rate = rate
            ContentView.player6?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer7() {
        do {
            ContentView.player7 = try AVAudioPlayer(contentsOf: recorder!.url)
            ContentView.player7?.enableRate = true
            ContentView.player7?.rate = rate
            ContentView.player7?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

    func setupPlayer8() {
        do {
            ContentView.player8 = try AVAudioPlayer(contentsOf: recorder!.url)
            ContentView.player8?.enableRate = true
            ContentView.player8?.rate = rate
            ContentView.player8?.prepareToPlay()
        } catch {
            print("Can't play: \(error)")
        }
    }

}
