//
//  String+Extension.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 17/08/2024.
//

import Foundation

extension String {
    var decodedHtml: String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        return attributedString?.string ?? self
    }
}
