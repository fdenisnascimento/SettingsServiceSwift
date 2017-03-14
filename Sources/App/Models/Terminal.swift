//
//  Order.swift
//  omaha-settings-service-swift
//
//  Created by Denis Nascimento on 09/03/17.
//
//

import Vapor
import Fluent
import Foundation

final class Terminal: Model {
    
    var exists: Bool = false
    
    var id: Node?
    var uuid : Node?
    var merchant_id : String
    var number : String
    var updated_at : Int
    var created_at : Int
    
    
    
    init(node: Node, in context: Context) throws {
        id = nil
        uuid = UUID().uuidString.makeNode()
        merchant_id = try node.extract("merchant_id")
        number = try node.extract("number")
        created_at =  Int(NSDate().timeIntervalSince1970)
        updated_at =  Int(NSDate().timeIntervalSince1970)
        
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "uuid": uuid,
            "merchant_id": merchant_id,
            "number": number,
            "created_at": created_at,
            "updated_at": updated_at
            
            ])
    }
}

extension Terminal: Preparation {
    
    static func prepare(_ database: Database) throws {
        
        try database.create("terminals") { creator in
            creator.id()
            creator.string("uuid")
            creator.string("merchant_id")
            creator.string("number")
            creator.int("created_at")
            creator.int("updated_at")
        }
        
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("terminal")
    }
}

//struct AddNumberToTerminal: Preparation {
//    static func prepare(_ database: Database) throws {
//        try database.modify("terminals") { creator in
//            creator.string("number", length: 10, optional: false, unique: false, default: nil)
//            creator.int("created_at")
//            creator.int("updated_at")
//        }
//    }
//
//    static func revert(_ database: Database) throws {
//
//    }
//}




