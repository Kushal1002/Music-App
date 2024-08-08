//
//  SongManager.swift
//  Music App
//
//  Created by kushal  on 28/06/24.
//

import SwiftUI

class SongManager: ObservableObject {
    @Published private(set) var song: SongsModel = SongsModel(artist: "", audio_url: "", cover: "", title: "")
    
    func playSong(song: SongsModel) {
        self.song = song
    }
}
