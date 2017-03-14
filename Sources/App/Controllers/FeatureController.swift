//
//  SettingController.swift
//  omaha-settings-service-swift
//
//  Created by Denis Nascimento on 10/03/17.
//
//

import Foundation
import Vapor
import HTTP

final class FeatureController: ResourceRepresentable {
  
  func index(request: Request) throws -> ResponseRepresentable {
    return try Feature.all().makeNode().converted(to: JSON.self)
  }
  
  func create(request: Request) throws -> ResponseRepresentable {
    var feature = try request.feature()
//    let hasFeature = try Feature.query().filter("name", feature.name ).first()
    
//    if hasFeature == nil  {
        try feature.save()
//    }
    
    return feature
  }
  
  func show(request: Request, feature: Feature) throws -> ResponseRepresentable {
    return feature
  }
  
  func delete(request: Request, feature: Feature) throws -> ResponseRepresentable {
    try feature.delete()
    return JSON([:])
  }
  
  func update(request: Request, feature: Feature) throws -> ResponseRepresentable {
    let new = try request.terminal()
    var feature = feature
    new.id = feature.id
    try feature.save()
    return feature
  }
  
  
  func makeResource() -> Resource<Feature> {
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
  func feature() throws -> Feature {
    guard let json = json else { throw Abort.badRequest }
    return try Feature(node: json)
  }
}

