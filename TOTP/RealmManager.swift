//
//  RealmData.swift
//  TOTP
//
//  Created by Taras Markevych on 3/24/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import RealmSwift

struct DocumentsDirectory {
    static let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last!
    static let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: Constants.iCloud.appId)?.appendingPathComponent(Constants.iCloud.documents)
}

class RealmManager {
    
    static let shared = RealmManager()
    
    fileprivate let fileManager = FileManager.default
    fileprivate let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: Constants.iCloud.appId)?.appendingPathComponent(Constants.iCloud.documents, isDirectory: true)
    fileprivate let iCloudDocumentToCheckURL = FileManager.default.url(forUbiquityContainerIdentifier: Constants.iCloud.appId)?.appendingPathComponent(Constants.iCloud.documents, isDirectory: true).appendingPathComponent(Constants.iCloud.realm, isDirectory: false)
    
    func saveNewUser(name: String?, issuer: String?, token: String, isFav: Bool = false, completionHandler: @escaping((Bool)->())) {
        do {
            let realm = try Realm()
            let newUser = User()
            newUser.name = name
            newUser.issuer = issuer
            newUser.token = token
            newUser.isFavourite = isFav
            try realm.write {
                realm.add(newUser, update: .all)
                widgetDataMigration()
                completionHandler(true)
            }
        } catch {
            print("Can't add user")
            completionHandler(false)
        }
    }
    
    func fetchCodesList() -> [User]? {
        var userList: Results<User>?
        do {
            let realm = try Realm()
            userList = realm.objects(User.self)
            return userList?.toArray()
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func getUserBy(token: String?) -> User? {
        guard let primaryKey = token else {
            print("No primary key for user")
            return nil
        }
        do {
            let realm = try Realm()
            return realm.object(ofType: User.self, forPrimaryKey: primaryKey)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func removeObject(user: User, completionHandler: @escaping((Bool)->())) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(user)
                widgetDataMigration()
                completionHandler(true)
            }
        } catch let error {
            print(error)
            completionHandler(false)
        }
    }
    
    func widgetDataMigration() {
        let archiveURL = FileManager.sharedContainerURL().appendingPathComponent(Constants.settings.contentsJson)
        let encoder = JSONEncoder()
        let users = fetchCodesList() ?? []
        if let dataToSave = try? encoder.encode(users) {
            do {
                try dataToSave.write(to: archiveURL)
                print("Shared container updated")
            } catch {
                print("Error: Can't write contents")
                return
            }
        }
    }
    
    
    func uploadDatabaseToCloudDrive() throws {
        if !isCloudEnabled() {
            print("iCloud disabled")
            throw CloudError.uploadError("iCloud unavailable. Please login to your iCLoud and try again")
        }
        let iCloudDocumentsURL = fileManager.url(forUbiquityContainerIdentifier: Constants.iCloud.appId)?.appendingPathComponent(Constants.iCloud.documents, isDirectory: true)
        let iCloudDocumentToCheckURL = iCloudDocumentsURL?.appendingPathComponent(Constants.iCloud.realm, isDirectory: false)
        if (fileManager.fileExists(atPath: iCloudDocumentToCheckURL?.path ?? "")) {
            do {
                try fileManager.removeItem(at: iCloudDocumentToCheckURL!)
                let realm = try Realm()
                try realm.write {
                    try realm.writeCopy(toFile: iCloudDocumentToCheckURL!)
                }
                print("Successfully updated")
            } catch let error {
                throw CloudError.uploadError(error.localizedDescription)
            }
        } else {
            print("Need to store create new file")
            do {
                let realm = try Realm()
                try realm.write {
                    try realm.writeCopy(toFile: iCloudDocumentToCheckURL!)
                }
                print("Successfully created")
            } catch let error {
                throw CloudError.uploadError(error.localizedDescription)
            }
        }
    }
    
    func downloadDatabaseFromCloudDrive() throws {
        if !isCloudEnabled() {
            print("iCloud disabled")
            throw CloudError.uploadError("iCloud unavailable. Please login to your iCLoud and try again")
        }
        var isDownloaded = false
        while !isDownloaded {
            if fileManager.fileExists(atPath: iCloudDocumentToCheckURL?.path ?? "") {
                isDownloaded = true
                do {
                    if fileManager.fileExists(atPath: Realm.Configuration.defaultConfiguration.fileURL!.path) {
                        print("Remove old copy \(String(describing: Realm.Configuration.defaultConfiguration.fileURL?.path))")
                        try fileManager.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
                    }
                    try fileManager.copyItem(at: DocumentsDirectory.iCloudDocumentsURL!.appendingPathComponent(Constants.iCloud.realm), to: DocumentsDirectory.localDocumentsURL.appendingPathComponent(Constants.iCloud.realm))
                    self.runMigrationIfNeeded()
                    let realm = try Realm()
                    try realm.write {
                        let arrays = self.fetchCodesList()
                        print("Fetched items \(String(describing: arrays?.count))")
                    }
                    widgetDataMigration()
                    print("Successfully downloaded")
                } catch let error {
                    throw CloudError.downloadError(error.localizedDescription)
                }
            } else {
                do {
                    guard let downloadUrl = iCloudDocumentToCheckURL else {
                        throw CloudError.downloadError("No saved backups")
                    }
                    try fileManager.startDownloadingUbiquitousItem(at: downloadUrl)
                } catch let error {
                    throw CloudError.downloadError(error.localizedDescription)
                }
            }
        }
    }
    
    func runMigrationIfNeeded() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
                    if (oldSchemaVersion < 4) {}
        })
    }
    
    private func isCloudEnabled() -> Bool {
        if DocumentsDirectory.iCloudDocumentsURL != nil {
            return true
        } else {
            return false
        }
    }
}
//MARK: - Folders
extension RealmManager {
    
    func createFolder(name: String, completionHandler: @escaping((Result<Any?, Error>)->())) {
        do {
            let realm = try Realm()
            let newFolder = Folder()
            newFolder.name = name
            newFolder.id = UUID().uuidString
            try realm.write {
                realm.add(newFolder, update: .all)
                completionHandler(.success(nil))
            }
        } catch let error {
            print("Can't add Folder: \(error)")
            completionHandler(.failure(error))
        }
    }
    
    func addFolderItems(items: List<User>, for folder: Folder,  completionHandler: @escaping((Result<Any?, Error>)->())) {
        do {
            let realm = try Realm()
            folder.codes = items
            try realm.write {
                realm.add(folder, update: .modified)
                completionHandler(.success(nil))
            }
        } catch let error {
            print("Can't add folder: \(error)")
            completionHandler(.failure(error))
        }
    }
    
    func removeFolder(folder: Folder, completionHandler: @escaping((Result<Any?, Error>)->())) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(folder)
                widgetDataMigration()
                completionHandler(.success(nil))
            }
        } catch let error {
            print("Folder deteltion error:", error)
            completionHandler(.failure(error))
        }
    }
    func fetchFolders() -> [Folder]? {
        var userList: Results<Folder>?
        do {
            let realm = try Realm()
            userList = realm.objects(Folder.self)
            return userList?.toArray()
        } catch let error {
            print(error)
            return nil
        }
    }
}


extension Realm {
    func list<T: Object>(_ type: T.Type) -> List<T> {
        let objects = self.objects(type)
        let list = objects.reduce(List<T>()) { list, element -> List<T> in
            list.append(element)
            return list
        }
        
        return list
    }
}
