import UIKit


protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String
    let model: String
    
}

enum MobileError: Error {
    case isExist
    case notFound
}

final class Solution: MobileStorage {
    
    private var mobiles: Set<Mobile> = []
    
    func getAll() -> Set<Mobile> {
        return mobiles
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        for mobile in mobiles {
            if mobile.imei == imei {
                return mobile
            }
        }
        return nil
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        if mobiles.contains(mobile) {
            throw MobileError.isExist
        }
        mobiles.insert(mobile)
        return mobile
    }
    
    func delete(_ product: Mobile) throws {
        if mobiles.contains(product) {
            mobiles.remove(product)
        } else {
            throw MobileError.notFound
        }
    }
    
    func exists(_ product: Mobile) -> Bool {
        return mobiles.contains(product)
    }
}
