//
//  XCStrings.swift
//  LoctableConvert
//
//  Created by 1024jp on 2025-03-01.
//

public extension XCStrings {
    
    init(locTable: LocTable, languages: [String: String]? = nil)  {
        
        self.sourceLanguage = "en"
        self.version = "1.0"
        self.strings = locTable.strings(languages: languages)
    }
}


public struct XCStrings: Codable {
    
    struct LocalizeString: Codable {
        
        var comment: String?
        var localizations: [Language: Localization]
    }
    
    
    struct Localization: Codable {
        
        var stringUnit: StringUnit
    }
    
    struct StringUnit: Codable {
        
        enum State: String, Codable {
            
            case translated
        }
        
        var state: State = .translated
        var value: Localized
    }
    
    var sourceLanguage: String
    var version: String
    var strings: [KeyString: LocalizeString]
}


extension XCStrings.Localization {
    
    init(localized: Localized) {
        
        self.stringUnit = .init(value: localized)
    }
}
