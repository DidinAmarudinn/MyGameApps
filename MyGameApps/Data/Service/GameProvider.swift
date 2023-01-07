//
//  GameProvider.swift
//  MyGameApps
//
//  Created by didin amarudin on 02/01/23.
//

import Foundation
import CoreData
class GameProvider {
    private let entityName = "Favorite"
    lazy var presistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "GameData")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved Error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = presistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    func getAllFavoritesGames(completion: @escaping(_ game: [GameDataModel]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [GameDataModel] = []
                for result in results {
                    let game = GameDataModel(
                        id: result.value(forKey: "id") as? Int32,
                        name: result.value(forKey: "name") as? String,
                        released: result.value(forKey: "released") as? String,
                        image: result.value(forKey: "image") as? Data,
                        rating: result.value(forKey: "rating") as? Double
                    )
                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func checkIsFavorite(_ id: Int,completion: @escaping(_ isFavorite: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                let result = try taskContext.fetch(fetchRequest)
                completion(result.count > 0)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func addToFavorite(_ data: DetailGame, _ image: Data, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: entityName, in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(data.id, forKey: "id")
                game.setValue(data.name, forKey: "name")
                game.setValue(data.released, forKey: "released")
                game.setValue(data.rating, forKey: "rating")
                game.setValue(image, forKey: "image")
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    func deleteFromFavorite(_ id: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
}
