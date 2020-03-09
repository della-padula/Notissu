//
//  BookmarkModel.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/02/18.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation

class BookmarkModel: BookmarkModelProtocol {
    private var bookmarkList: [FavoriteNotice] = [FavoriteNotice]()
    
    func removeBookmarkAll() {
        self.bookmarkList.removeAll()
    }
    
    func removeBookmark(bookmark: FavoriteNotice) {
        for (index, item) in bookmarkList.enumerated() {
            if item == bookmark {
                self.bookmarkList.remove(at: index)
            }
        }
    }
    
    func appendBookmarkList(list: [FavoriteNotice]) {
        self.bookmarkList.removeAll()
        self.bookmarkList.append(contentsOf: list)
    }
    
    func appendBookmark(bookmark: FavoriteNotice) {
        self.bookmarkList.append(bookmark)
    }
    
    func getBookmark(at: Int) -> FavoriteNotice {
        return self.bookmarkList[at]
    }
    
    func getBookmarkCount() -> Int {
        return self.bookmarkList.count
    }
}

extension FavoriteNotice: Equatable {
    static func == (left: FavoriteNotice, right: FavoriteNotice) -> Bool {
        return (left.notice == right.notice) && (left.deptCode == right.deptCode)
    }
}

extension Notice: Equatable {
    static func == (left: Notice, right: Notice) -> Bool {
        return (left.title == right.title) && (left.date == right.date) && (left.url == right.url)
    }
}
