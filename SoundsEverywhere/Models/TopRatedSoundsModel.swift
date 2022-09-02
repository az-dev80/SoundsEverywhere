//
//  TopRatedSoundsModel.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 6.11.21.
//

import Foundation

struct TopRatedSoundsModel: Codable {
    let count: Int
    let next: String?
    let results: [Resulter]
    let previous: String?
}

//struct Resulters: Codable {
//    let id: Int
//    let url: String
//    let name: String
//    let tags: [String]
//    let resultDescription, created: String
//    let license: String
//    let type: TypeEnums
//    let username: String
//    let pack: String?
//    let download, bookmark: String
//    let previews: Previewss
//    let images: Imagess
//    let numDownloads, numRatings: Int
//    let avgRating: Float
//
//    enum CodingKeys: String, CodingKey {
//        case id, url, name, tags
//        case resultDescription = "description"
//        case created, license, type, username, pack, download, bookmark, previews, images
//        case numDownloads = "num_downloads"
//        case avgRating = "avg_rating"
//        case numRatings = "num_ratings"
//    }
//}
//
//struct Imagess: Codable {
//    let spectralM, spectralL, spectralBWL: String
//    let waveformBWM, waveformBWL, waveformL, waveformM: String
//    let spectralBWM: String
//
//    enum CodingKeys: String, CodingKey {
//        case spectralM = "spectral_m"
//        case spectralL = "spectral_l"
//        case spectralBWL = "spectral_bw_l"
//        case waveformBWM = "waveform_bw_m"
//        case waveformBWL = "waveform_bw_l"
//        case waveformL = "waveform_l"
//        case waveformM = "waveform_m"
//        case spectralBWM = "spectral_bw_m"
//    }
//}
//
//struct Previewss: Codable {
//    let previewLqOgg: String
//    let previewLqMp3: String
//    let previewHqOgg: String
//    let previewHqMp3: String
//
//    enum CodingKeys: String, CodingKey {
//        case previewLqOgg = "preview-lq-ogg"
//        case previewLqMp3 = "preview-lq-mp3"
//        case previewHqOgg = "preview-hq-ogg"
//        case previewHqMp3 = "preview-hq-mp3"
//    }
//}
//
//enum TypeEnums: String, Codable {
//    case wav = "wav"
//    case aif = "aif"
//    case aiff = "aiff"
//    case mp3 = "mp3"
//    case m4a = "m4a"
//    case flac = "flac"
//}
