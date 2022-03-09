//
//  Element.swift
//  Notepad
//
//  Created by Rudd Fawcett on 10/14/16.
//  Copyright © 2016 Rudd Fawcett. All rights reserved.
//

import Foundation

/// A String type enum to keep track of the different elements we're tracking with regex.
public enum Element: String {
    case unknown = "x^"

    case h1 = "^(\\#[^\\#](.*))$"
    case h2 = "^(\\#{2}(.*))$"
    case h3 = "^(\\#{3}(.*))$"

    case body = ".*"

    case bold = "(^|[\\W_])(?:(?!\\1)|(?=^))(\\*|_)\\2(?=\\S)(.*?\\S)\\2\\2(?!\\2)(?=[\\W_]|$)"
    case italic = "(^|[\\W_])(?:(?!\\1)|(?=^))(\\*|_)(?=\\S)((?:(?!\\2).)*?\\S)\\2(?!\\2)(?=[\\W_]|$)"
    case boldItalic = "(\\*\\*\\*\\w+(\\s\\w+)*\\*\\*\\*)"
    case strikeThrough = "(~~)(?=\\S)(.+?)(?<=\\S)\\1"
    case codeInline = "`([^`\n\r]+)`"
    case codeBlock = "^((?:(?:[ ]{4}|\\t).*(\\R|$))+)(?=\\W|$)"
    case codeFenced = "^`{3}([\\S]+)?\n([\\s\\S]+)\n`{3}(?=\\W|$)"

    case url = "\\[([^\\]]+)\\]\\(([^\\)\"\\s]+)(?:\\s+\"(.*)\")?\\)"
    case image = "\\!\\[([^\\]]+)\\]\\(([^\\)\"\\s]+)(?:\\s+\"(.*)\")?\\)"

    case checkBoxUnchecked = "^(\\s*)([-*+])\\s+(\\[ ])(?=\\W|$)"
    case checkBoxChecked =   "^(\\s*)([-*+])\\s+(\\[[xX]])(?=\\W|$)"
    case listItemUnordered = "^(\\s*)([-*+])\\s.(.*)"
    case listItemOrdered =   "^(\\s*)(\\d+\\.)\\s.(.*)"

    case quote = "(^> ?.+?)((\n\n\\w)|\\Z|$)"

    /// Converts an enum value (type String) to a NSRegularExpression.
    ///
    /// - returns: The NSRegularExpression.
    func toRegex() -> NSRegularExpression {
        return self.rawValue.toRegex()
    }

    /// Returns an Element enum based upon a String.
    ///
    /// - parameter string: The String representation of the enum.
    ///
    /// - returns: The Element enum match.
    func from(string: String) -> Element {
        switch string {
        case "h1": return .h1
        case "h2": return .h2
        case "h3": return .h3
        case "body": return .body
        case "bold": return .bold
        case "italic": return .italic
        case "boldItalic": return .boldItalic
        case "strikeThrough": return .strikeThrough
        case "codeInline": return .codeInline
        case "codeBlock": return .codeBlock
        case "codeFenced": return .codeFenced
        case "url": return .url
        case "image": return .image
        case "listItemUnordered": return .listItemUnordered
        case "listItemOrdered": return .listItemOrdered
        case "checkBoxUnchecked": return .checkBoxUnchecked
        case "checkBoxChecked": return .checkBoxChecked
        case "quote": return .quote
        default: return .unknown
        }
    }
}
