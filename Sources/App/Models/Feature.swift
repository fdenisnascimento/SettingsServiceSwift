//
//  Setting.swift
//  omaha-settings-service-swift
//
//  Created by Denis Nascimento on 10/03/17.
//
//


import Vapor
import Fluent
import Foundation

final class Feature: Model {
  
  var exists: Bool = false
  
  var id: Node?
  var uuid : Node?
  var name : String
  var updated_at : Int
  var created_at : Int
  
  
  init(node: Node, in context: Context) throws {
    id = nil
    uuid = UUID().uuidString.makeNode()
    name = try node.extract("name")
    created_at =  Int(NSDate().timeIntervalSince1970)
    updated_at =  Int(NSDate().timeIntervalSince1970)
    
  }
  
  func makeNode(context: Context) throws -> Node {
    return try Node(node: [
      "id": id,
      "uuid": uuid,
      "name": name,
      "created_at": created_at,
      "updated_at": updated_at
      
      ])
  }
}

extension Feature: Preparation {
  
  static func prepare(_ database: Database) throws {
    
    try database.create("features") { creator in
      creator.id()
      creator.string("uuid", optional: true,unique: true,default: nil)
      creator.string("name",length: 100, optional: true,unique: true,default: nil)
      creator.int("created_at")
      creator.int("updated_at")
    }
    
  }
  
  static func revert(_ database: Database) throws {
    try database.delete("features")
  }
}
