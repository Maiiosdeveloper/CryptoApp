//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Mai on 03/11/2024.
//

import Foundation
import CoreData
class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    @Published var savedEntities: [PortfolioEntity] = []
    init() {
        // load container of core data
        container = .init(name: containerName)
        container.loadPersistentStores { [weak self] _, error in
            if let error {
                print("[🔥] Error loading core data:- \(error)")
            }else {
                // then fetch data from that containeer
                self?.getPortfolio()
            }
        }
        
    }
    // MARK:- public
    func update(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            }else {
                delete(entity: entity)
            }
        }else {
            add(coinID: coin.id, amount: amount)
        }
            
    }
    // MARK:- private func
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("[🔥] Error Fetching Request of Portfolio Entity:- \(error)")
        }
    }
    private func add(coinID: Int, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = Int32(coinID)
        entity.amount = amount
        applyChanges()
    }
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("[🔥] Error Saving in Core Data:- \(error)")
        }
    }
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
