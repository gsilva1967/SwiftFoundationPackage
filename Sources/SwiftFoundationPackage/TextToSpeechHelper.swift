//
//  TextToSpeechHelper.swift
//  FirstResponderSystem
//
//  Created by Michael Kacos on 5/4/23.
//

import Foundation
import AVFoundation

public class TextToSpeechHelper {
    let synthesizer = AVSpeechSynthesizer()
    
    func text2speech(text: String) {
                     
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            //utterance.rate = 0.52
            self.synthesizer.speak(utterance)
        }
}
