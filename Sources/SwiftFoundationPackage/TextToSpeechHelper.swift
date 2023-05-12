//
//  TextToSpeechHelper.swift
//  FirstResponderSystem
//
//  Created by Michael Kacos on 5/4/23.
//

import AVFoundation
import Foundation

public class TextToSpeechHelper {
    let synthesizer = AVSpeechSynthesizer()

    func text2speech(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        // utterance.rate = 0.52
        synthesizer.speak(utterance)
    }
}
