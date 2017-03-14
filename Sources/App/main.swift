import Vapor
import VaporPostgreSQL

import SwiftyBeaverVapor
import SwiftyBeaver

let drop = Droplet()

try drop.addProvider(VaporPostgreSQL.Provider.self)

drop.preparations.append(Terminal.self)
drop.preparations.append(Feature.self)
drop.preparations.append(Specification.self)

//Meke log
let log = drop.log.self

let console = ConsoleDestination()
console.format = "$DHH:mm:ss$d $L: $M"  // hour, minute, second, loglevel and message
console.minLevel = .info // just log .info, .warning & .error

let sbProvider = SwiftyBeaverProvider(destinations: [console])
drop.addProvider(sbProvider)



//Routes

drop.resource("terminals", TerminalController())
drop.resource("features", FeatureController())
drop.resource("specifications", SpecificationController())


drop.run()

