//
//  FileExtension.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/02/28.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation
import UIKit

public enum FileTypeIcon {
    case etc, image, movie, audio, zip, pdf, presentation, text, spreadsheet
    
    public var fileTypeImageName: String {
        switch self {
        case .pdf:
            return "noticeFileIcoPdf"
        case .presentation:
            return "noticeFileIcoPptx"
        case .text:
            return "noticeFileIcoDocument"
        case .spreadsheet:
            return "noticeFileIcoSheet"
        case .movie:
            return "noticeFileIcoVideo"
        case .audio:
            return "noticeFileIcoAudio"
        case .image:
            return "noticeFileIcoImage"
        case .zip:
            return "noticeFileIcoArchive"
        default:
            return "noticeFileIcoEtcfile"
        }
    }
    
    public var iconImage: UIImage {
        return UIImage(named: self.fileTypeImageName) ?? UIImage()
    }
}

@objc public extension NSString {
    static var acceptableAudioTypes: [NSString] {
        return String.acceptableAudioTypes as [NSString]
    }
    static var acceptableMovieTypes: [NSString] {
        return String.acceptableMovieTypes as [NSString]
    }
    
    static var acceptableImageTypes: [NSString] {
        return String.acceptableImageTypes as [NSString]
    }
    
    static var acceptableZipTypes: [NSString] {
        return String.acceptableZipTypes as [NSString]
    }
    
    static var acceptablePdfTypes: [NSString] {
        return String.acceptablePdfTypes as [NSString]
    }
    
    static var acceptablePresentationTypes: [NSString] {
        return String.acceptablePresentationTypes as [NSString]
    }
    
    static var acceptableTextTypes: [NSString] {
        return String.acceptableTextTypes as [NSString]
    }
    
    static var acceptableSpreadsheetTypes: [NSString] {
        return String.acceptableSpreadsheetTypes as [NSString]
    }
    
    var fileTypeIconImage: UIImage {
        return String(self).fileTypeIconImage
    }
}

public extension String {
    static var acceptableAudioTypes: [String] {
        return ["mp3", "wav", "flac", "tta", "tak", "aac", "wma", "ogg", "m4a"]
    }
    static var acceptableMovieTypes: [String] {
        return ["mp4", "m4v", "avi", "asf", "wmv", "mkv", "ts", "mpg", "mpeg", "mov", "flv", "ogv"]
    }
    static var acceptableImageTypes: [String] {
        return ["jpg", "jpeg", "gif", "bmp", "png", "tif", "tga", "psd", "ai", "sketch", "tiff", "webp", "heic"]
    }
    
    static var acceptableZipTypes: [String] {
        return ["zip", "gz", "bz2", "rar", "7z", "lzh", "alz"]
    }
    
    static var acceptablePdfTypes: [String] {
        return ["pdf"]
    }
    
    static var acceptablePresentationTypes: [String] {
        return ["odp", "ppt", "pptx", "key", "show"]
    }
    
    static var acceptableTextTypes: [String] {
        return ["doc", "docx", "hwp", "txt", "rtf", "xml", "wks", "wps", "xps", "md", "odf", "odt", "pages"]
    }
    
    static var acceptableSpreadsheetTypes: [String] {
        return ["ods", "csv", "tsv", "xls", "xlsx", "numbers", "cell"]
    }
    
    var fileTypeIcon: FileTypeIcon {
        let pathExtension: String = (self as NSString).pathExtension
        let ext: String = pathExtension.isEmpty ? self : pathExtension.lowercased()
        if String.acceptableMovieTypes.contains(ext) {
            return .movie
        } else if String.acceptableAudioTypes.contains(ext) {
            return .audio
        } else if String.acceptableImageTypes.contains(ext) {
            return .image
        } else if String.acceptableZipTypes.contains(ext) {
            return .zip
        } else if String.acceptablePdfTypes.contains(ext) {
            return .pdf
        } else if String.acceptablePresentationTypes.contains(ext) {
            return .presentation
        } else if String.acceptableTextTypes.contains(ext) {
            return .text
        } else if String.acceptableSpreadsheetTypes.contains(ext) {
            return .spreadsheet
        }
        return .etc
    }
    
    var fileTypeIconImage: UIImage {
        return fileTypeIcon.iconImage
    }
}

