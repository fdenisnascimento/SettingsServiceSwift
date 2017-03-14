//
//  Specification.swift
//  omaha-settings-service-swift
//
//  Created by Denis Nascimento on 10/03/17.
//
//

import Vapor
import Fluent
import Foundation

final class Specification: Model {
  
  var exists: Bool = false
  
  var id: Node?
  var uuid : Node?
  var terminal_id : Node?
  var feature_id : Node?
  var value : String
  var status : String
  var updated_at : Int
  var created_at : Int
  

  
  init(node: Node, in context: Context) throws {
    id = nil
    uuid = UUID().uuidString.makeNode()
    created_at =  Int(NSDate().timeIntervalSince1970)
    updated_at =  Int(NSDate().timeIntervalSince1970)
    terminal_id = try node.extract("terminal_id")
    feature_id = try node.extract("feature_id")
    value = try node.extract("value")
    status = try node.extract("status")
    
  }
  
  func makeNode(context: Context) throws -> Node {
    return try Node(node: [
      "id": id,
      "uuid": uuid,
      "created_at": created_at,
      "updated_at": updated_at,
      "terminal_id": terminal_id,
      "feature_id": feature_id,
      "value": value,
      "status" : status
      ])
  }
}


extension Specification: Preparation {
  
  static func prepare(_ database: Database) throws {
    
    try database.create("specifications") { creator in
      creator.id()
      creator.string("uuid", optional: false, unique: true)
      creator.parent(Terminal.self, optional: false, unique: true, default: nil)
      creator.parent(Feature.self, optional: false, unique: true, default: nil)
      creator.string("value", length: 20, optional: true,unique: false,default: nil)
      creator.string("status", length: 20, optional: true,unique: false,default: nil)
      creator.int("created_at")
      creator.int("updated_at")
    }
    
  }
  
  static func revert(_ database: Database) throws {
    try database.delete("specifications")
  }
}

extension Specification {
  func terminal() throws -> Parent<Terminal> {
    return try parent(terminal_id)
  }
}


extension Specification {
  func feature() throws -> Parent<Feature> {
    return try parent(feature_id)
  }
}

