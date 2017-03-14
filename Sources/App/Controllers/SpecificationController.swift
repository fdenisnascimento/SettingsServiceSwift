//
//  SpecificationController.swift
//  omaha-settings-service-swift
//
//  Created by Denis Nascimento on 10/03/17.
//
//

import Vapor
import HTTP

final class SpecificationController: ResourceRepresentable {
  
  func index(request: Request) throws -> ResponseRepresentable {
    return try Specification.all().makeNode().converted(to: JSON.self)
  }
  
  func create(request: Request) throws -> ResponseRepresentable {
    var specification = try request.specification()
    try specification.save()
    return specification
  }
  
  func show(request: Request, specification: Specification) throws -> ResponseRepresentable {
    return specification
  }
  
  func delete(request: Request, specification: Specification) throws -> ResponseRepresentable {
    try specification.delete()
    return JSON([:])
  }
  
  func update(request: Request, specification: Specification) throws -> ResponseRepresentable {
    let new = try request.terminal()
    var specification = specification
    new.id = specification.id
    try specification.save()
    return specification
  }
  
  
  func makeResource() -> Resource<Specification> {
    return Resource(
      index: index,
      store: create,
      show: show,
      modify: update,
      destroy: delete
    )
  }
}

extension Request {
  func specification() throws -> Specification {
    guard let json = json else { throw Abort.badRequest }
    return try Specification(node: json)
  }
}

