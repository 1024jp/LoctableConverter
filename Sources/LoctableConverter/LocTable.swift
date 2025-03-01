//
//  LocTable.swift
//  LoctableConvert
//
//  Created by 1024jp on 2025-03-01.
//

public typealias Language = String
public typealias KeyString = String
public typealias Localized = String

public typealias LocTable = [Language: [KeyString: Localized]]

extension LocTable {
    
    func strings(languages: [String: String]? = nil) -> [KeyString: XCStrings.LocalizeString] {
        
        self.keyStrings.reduce(into: [:]) { dict, keyString in
            let localizations = self.localizations(key: keyString, languages: languages)
            dict[keyString] = .init(localizations: localizations)
        }
    }
    
    
    private var keyStrings: [KeyString] {
        
        self.values.first?.keys.sorted() ?? []
    }
    
    
    private func localizations(key: KeyString, languages: [String: String]? = nil) -> [Language: XCStrings.Localization] {
        
        self.reduce(into: [:]) { dict, item in
            let language = if let languages { languages[item.key] } else { item.key }
            
            guard
                let language,
                let localized = item.value[key]
            else { return }
            
            dict[language] = .init(localized: localized)
        }
    }
}
