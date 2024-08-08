//
//  SongModels.swift
//  Music App
//
//  Created by kushal  on 26/06/24.
//

import SwiftUI

// now we create song model list
struct SongsModel: Identifiable {
    var id: UUID = .init()
    var artist: String
    var audio_url: String
    var cover: String
    var title: String
    var isFavourite: Bool = false
}
 // demo list of songs
var sampleSongModel: [SongsModel] = [
    .init(artist: "Diljit Dosanjh", audio_url: "", cover: "https://i.pinimg.com/474x/ea/84/47/ea844719234bf46482d2ab80b48cbf2f.jpg", title: "G.O.A.T."),
    .init(artist: "Travis Scott", audio_url: "", cover: "https://i.pinimg.com/474x/31/b0/32/31b0329034441c84e0d619b72b97e799.jpg", title: "MELTDOWN"),
    .init(artist: "Future", audio_url: "", cover: "https://i.pinimg.com/564x/50/97/97/5097977e0f29d4e171cc56dcd212e95d.jpg", title: "Like That"),
    .init(artist: "Karan Aujla", audio_url: "", cover: "https://i.pinimg.com/474x/36/60/a4/3660a4751adba5ea11b00ccae1062050.jpg", title: "Tareefan"),
    .init(artist: "Ariana Grande", audio_url: "", cover: "https://i.pinimg.com/736x/78/f7/97/78f797264c48c15d950a2f187dad02e1.jpg", title: "Supernatural"),
    .init(artist: "Kendric Lamar", audio_url: "", cover: "https://i.pinimg.com/736x/e0/50/ea/e050eac01c3d4f5f057d0189f633d4c4.jpg", title: "Not Like Us"),
    .init(artist: "The Weeknd", audio_url: "", cover: "https://i.pinimg.com/736x/6f/96/16/6f9616f300947764da78aaad919cf76b.jpg", title: "Is there someone else?"),
    .init(artist: "Travis Scott", audio_url: "", cover: "https://i.pinimg.com/736x/a5/10/76/a510766fb0675c08e0136ce5a7bed81e.jpg", title: "SICKO MODE"),
    .init(artist: "Playboi Carti", audio_url: "", cover: "https://i.pinimg.com/474x/34/61/88/346188d0cb4f570cf494129a637737f0.jpg", title: "Vamp Anthem"),
    .init(artist: "The Weeknd", audio_url: "", cover: "https://i.pinimg.com/474x/d1/ab/1d/d1ab1d900c873f82bd247b05ee4eddfc.jpg", title: "Blinding Lights"),
    .init(artist: "Kendric Lamar", audio_url: "", cover: "https://i.pinimg.com/474x/96/15/d0/9615d02e50c4a90711559a18e55af297.jpg", title: "Euphoria"),
    .init(artist: "SZA", audio_url: "", cover: "https://i.pinimg.com/564x/4a/54/3d/4a543ddc1897e807dfc9c1a356ef1f85.jpg", title: "Kill Bill")
]
