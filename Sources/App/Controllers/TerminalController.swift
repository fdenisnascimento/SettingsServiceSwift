//
//  OrderController.swift
//  omaha-settings-service-swift
//
//  Created by Denis Nascimento on 09/03/17.
//
//

import Vapor
import HTTP

final class TerminalController: ResourceRepresentable {
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try Terminal.all().makeNode().converted(to: JSON.self)
    }
    
    func create(request: Request) throws -> ResponseRepresentable {        
        var terminal = try request.terminal()
        try terminal.save()
        return terminal
    }
    
    func show(request: Request, terminal: Terminal) throws -> ResponseRepresentable {
        return terminal
    }
    
    func delete(request: Request, terminal: Terminal) throws -> ResponseRepresentable {
        try terminal.delete()
        return JSON([:])
    }
    
    func update(request: Request, terminal: Terminal) throws -> ResponseRepresentable {
        let new = try request.terminal()
        var terminal = terminal
        new.id = terminal.id
        try terminal.save()
        return terminal
    }
    
    
    func makeResource() -> Resource<Terminal> {
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
    func terminal() throws -> Terminal {
        guard let json = json else { throw Abort.badRequest }
        return try Terminal(node: json)
    }
}

