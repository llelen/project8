////
////  test.swift
////  project8
////
////  Created by Ayane on 3/10/19.
////  Copyright © 2019 Ayane. All rights reserved.
////
//
//import Foundation
//func loadLevels() {
//    var clueString = ""
//    var solutionString = ""
//    var letterBits = [String]()
//    
//    if let levelFileURL = Bundle.main.url(forResource: "level\(0)", withExtension: "txt") {
//        if let levelContents = try? String(contentsOf: levelFileURL) {
//            var lines = levelContents.components(separatedBy: "\n")
//            lines.shuffle()
//            
//            for (index, line) in lines.enumerated() {
//                let parts = line.components(separatedBy: ": ")
//                let answer = parts[0]
//                let clue = parts[1]
//                
//                clueString += "\(index + 1). \(clue)\n"
//                
//                let solutionWord = answer.replacingOccurrences(of: "|", with: "")
//                solutionString += "\(solutionWord.count) letters\n"
//                solutions.append(solutionWord)
//                
//                let bits = answer.components(separatedBy: "|")
//                letterBits += bits
//            }
//        }
//    }
//    
//    // Now configure the buttons and labels
//}
