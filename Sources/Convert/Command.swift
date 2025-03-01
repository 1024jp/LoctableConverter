//
//  Command.swift
//  LoctableConverter
//
//  Created by 1024jp on 2025-03-01.
//

import Foundation
import ArgumentParser
import LoctableConverter

@main
struct Command: ParsableCommand {
    
    @Argument(help: "A path to the loctable file.")
    var input: URL
    
    @Argument(help: "The path to the result xcstrings file.")
    var output: URL
    
    
    func run() throws {
        
        let data = try Data(contentsOf: self.input)
        
        guard var plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        plist["LocProvenance"] = nil
        
        guard let locTable = plist as? LocTable else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        let xcStrings = XCStrings(locTable: locTable, languages: languageTable)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let jsonData = try encoder.encode(xcStrings)
        try jsonData.write(to: self.output)
    }
}


extension URL: @retroactive ExpressibleByArgument {
    
    public init?(argument: String) {
        
        self.init(filePath: argument)
    }
}
