import Vapor

struct LoginRequest: Content {
    var email: String
    var password: String
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, starter!"
    }
    
    router.get("users", Int.parameter, String.parameter) { req -> [String:String] in
        let id = try req.parameters.next(Int.self)
        let name = try req.parameters.next(String.self)
        return [String(id): name]
    }
    
    router.post("login") { req -> Future<HTTPStatus> in
        return try! req.content.decode(LoginRequest.self).map(to: HTTPStatus.self) { loginRequest in
            print(loginRequest.email) // user@vapor.codes
            print(loginRequest.password) // don't look!
            return .ok
        }
    }


    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
