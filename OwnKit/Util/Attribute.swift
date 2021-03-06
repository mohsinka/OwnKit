//
//  Attribute.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/12/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public enum StringAttributes {
    case Font(UIFont)
    case ParagraphStyle(NSParagraphStyle)
    case Alignment(NSTextAlignment)
    case Color(UIColor)
    case BackgroundColor(UIColor)
    case Ligature(Bool)
    case Kern(Float)
    case StrikethroughStyle(NSUnderlineStyle)
    case UnderlineStyle(NSUnderlineStyle)
    case StrokeColor(UIColor)
    case StrokeWidth(Float)
    case Shadow(NSShadow)
    case TextEffect(String)
    case Attachment(NSTextAttachment)
    case Link(NSURL)
    case BaselineOffset(Float)
    case UnderLineColor(UIColor)
    case StrikethroughColor(UIColor)
    case Obliqueness(Float)
    case Expansion(Float)
    case WritingDirection(NSWritingDirection)
    case VerticalGlyphForm(Bool)
    case Custom(name: String, value: AnyObject)
    
    var name: String {
        switch self {
        case .Font: return NSFontAttributeName
        case .ParagraphStyle: return NSParagraphStyleAttributeName
        case .Alignment: return NSParagraphStyleAttributeName
        case .Color: return NSForegroundColorAttributeName
        case .BackgroundColor: return NSBackgroundColorAttributeName
        case .Ligature: return NSLigatureAttributeName
        case .Kern: return NSKernAttributeName
        case .StrikethroughStyle: return NSStrikethroughStyleAttributeName
        case .UnderlineStyle: return NSUnderlineStyleAttributeName
        case .StrokeColor: return NSStrokeColorAttributeName
        case .StrokeWidth: return NSStrokeWidthAttributeName
        case .Shadow: return NSShadowAttributeName
        case .TextEffect: return NSTextEffectAttributeName
        case .Attachment: return NSAttachmentAttributeName
        case .Link: return NSLinkAttributeName
        case .BaselineOffset: return NSBaselineOffsetAttributeName
        case .UnderLineColor: return NSUnderlineColorAttributeName
        case .StrikethroughColor: return NSStrikethroughColorAttributeName
        case .Obliqueness: return NSObliquenessAttributeName
        case .Expansion: return NSExpansionAttributeName
        case .WritingDirection: return NSWritingDirectionAttributeName
        case .VerticalGlyphForm: return NSVerticalGlyphFormAttributeName
        case .Custom(name: let name, value: _): return name
        }
    }
    
    var value: AnyObject {
        switch self {
        case .Font(let font): return font
        case .ParagraphStyle(let style): return style
        case .Alignment(let alignment):
            let style = NSMutableParagraphStyle()
            style.alignment = alignment
            return style
        case .Color(let color): return color
        case .BackgroundColor(let color): return color
        case .Ligature(let ligature): return ligature
        case .Kern(let spacing): return spacing
        case .StrikethroughStyle(let style): return style.rawValue
        case .UnderlineStyle(let style): return style.rawValue
        case .StrokeColor(let color): return color
        case .StrokeWidth(let width): return width
        case .Shadow(let shadow): return shadow
        case .TextEffect(let effect): return effect
        case .Attachment(let attachment): return attachment
        case .Link(let url): return url
        case .BaselineOffset(let offset): return offset
        case .UnderLineColor(let color): return color
        case .StrikethroughColor(let color): return color
        case .Obliqueness(let skew): return skew
        case .Expansion(let factor): return factor
        case .WritingDirection(let direction): return direction.rawValue
        case .VerticalGlyphForm(let vertical): return vertical
        case .Custom(name: _, value: let value): return value
        }
    }
}

public final class Attribute {
    private var stringAttributes = [StringAttributes]()
    private func copy() -> Attribute {
        let copy = Attribute()
        copy.stringAttributes = stringAttributes
        return copy
    }
}

public extension Attribute {
    var attributes: [String: AnyObject] {
        var attributes = [String: AnyObject]()
        stringAttributes.forEach { attributes[$0.name] = $0.value }
        return attributes
    }
    
    convenience init(_ attribute: StringAttributes) {
        self.init()
        stringAttributes.append(attribute)
    }
    
    convenience init(_ attributes: [StringAttributes]) {
        self.init()
        self.stringAttributes += attributes
    }
    
    @warn_unused_result
    func string(string: String) -> NSAttributedString {
        return mutableString(string)
    }
    
    @warn_unused_result
    func mutableString(string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string, attributes: attributes)
    }
    
    func add(attribute: StringAttributes) -> Attribute {
        let copy = self.copy()
        copy.stringAttributes.append(attribute)
        return copy
    }
    
    func add(attributes: [StringAttributes]) -> Attribute {
        let copy = self.copy()
        copy.stringAttributes += attributes
        return copy
    }
}