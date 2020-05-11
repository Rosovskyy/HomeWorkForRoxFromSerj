//
//  JoinedString.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 09.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

final class JoinedString {
    let separator: String

    private (set) var result = ""

    init (separator: String = ", ") {
        self.separator = separator
    }

    func append(_ stringToAppend: String?) -> JoinedString {
        guard let stringToAppend = stringToAppend, stringToAppend.isNotBlank else { return self }

        if result.isNotBlank { result.append(separator) }

        result.append(stringToAppend)
        return self
    }
}

fileprivate extension String {
    /// Returns true if trimmed string is empty, false otherwise
    var isBlank: Bool {
        let trimmed = self.trimmingCharacters(in: CharacterSet.whitespaces)
        return trimmed.isEmpty
    }

    var isNotBlank: Bool {
        return !isBlank
    }
}
