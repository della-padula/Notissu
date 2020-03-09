//
//  BookmarkPresenter.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/02/18.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation
import CoreData

class BookmarkPresenter: BookmarkPresenterProtocol {
    private var view: BookmarkViewProtocol!
    private var model = BookmarkModel()
    
    init(view: BookmarkViewProtocol) {
        self.view = view
    }
    
    func fetchBookmarkNotice() {
        let managedContext = CoreDataUtil.shared.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Favorite")
        var resultCount: Int = 0
        do {
            let result = try managedContext.fetch(fetchRequest)
            var favoriteList = [FavoriteNotice]()
            
            for notice in result as! [NSManagedObject] {
                resultCount += 1
                
                let title = notice.value(forKey: "title") as! String
                let url = notice.value(forKey: "url") as! String
                let date = notice.value(forKey: "date") as! String
                let author = notice.value(forKey: "author") as! String
                let isNotice = notice.value(forKey: "isNotice") as! Bool
                let deptCode = notice.value(forKey: "deptCode") as! Int
                let deptName = notice.value(forKey: "deptName") as! String
                let hasAttachment = (notice.value(forKey: "hasAttachment") as? Bool) ?? false
                
                favoriteList.append(FavoriteNotice(notice: Notice(author: author, title: title, url: url, date: date, isNotice: isNotice, hasAttachment: hasAttachment), deptCode: DeptCode(rawValue: deptCode) ?? DeptCode.IT_Computer, deptName: DeptName(rawValue: deptName) ?? DeptName.IT_Computer))
            }
            self.model.appendBookmarkList(list: favoriteList)
            self.view.applyListToTableView(list: favoriteList)
            print("Retrieve Notice : \(resultCount)")
            
        } catch {
            print("ERROR")
        }
    }
    
    func removeBookmark(bookmark: FavoriteNotice) {
        let managedContext = CoreDataUtil.shared.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "title = %@ AND date = %@ AND deptCode = %i", bookmark.notice.title!, bookmark.notice.date!, bookmark.deptCode.rawValue)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let objectToDelete = result[0] as! NSManagedObject
            print("result : \(objectToDelete.value(forKey: "title") ?? "")")
            managedContext.delete(objectToDelete)

            do {
                try managedContext.save()
                self.model.removeBookmark(bookmark: bookmark)
            } catch {
                print(error)
                return
            }
        } catch {
            print(error)
            return
        }
    }
    
    func removeBookmark(at: Int) {
        self.removeBookmark(bookmark: self.getBookmark(at: at))
    }
    
    func getBookmark(at: Int) -> FavoriteNotice {
        return self.model.getBookmark(at: at)
    }
    
    func getBookmarkCount() -> Int {
        return self.model.getBookmarkCount()
    }
}
