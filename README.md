# User Management Project

This iOS app is structured with a modular architecture and split into multiple Swift packages for better scalability and maintainability. It utilizes dependency injection to ensure that components are loosely coupled and easily testable.

<img width="737" alt="sc" src="https://github.com/user-attachments/assets/824e2c43-eb6c-4ff0-89ae-f43a33639d3a" />


## Key Features

- **Dependency Injection**: The project uses dependency injection to manage dependencies between components.
The project uses a protocol `DataServiceProtocol` to define the interface for data services. The `DataService` class implements this protocol to fetch data from a remote service, while the `MockDataService` class provides mock data for testing.

- **Protocol**: A protocol is defined to outline the required methods for data services.

```swift
protocol DataServiceProtocol {
    func getPersonList() async throws -> [Person]
}
```

- **Mock Data Service**: A mock data service is implemented to simulate data operations for testing purposes. which uses `Core` package to load a json file

```swift
public actor MockDataService: DataServiceProtocol {
    var throwError: Bool
    public init(throwError: Bool = false) {
        self.throwError = throwError
    }

    public func getPersonList() async throws -> [Person] {
        guard throwError == false else {
            throw CustomError.undefined
        }
        return try Core.FileManager.contents(of: "people", in: Bundle.module) as [Person]
    }
}
```

- **ViewModel**: The PersonViewModel class uses the data service to load and filter user data.

```swift
extension PeopleView {
    @Observable @MainActor
    class ViewModel {
        private let service: DataServiceProtocol
        // Implementation of view model
    }
}
```

## License

This project is licensed under the BSD 3-Clause License - see the LICENSE file for details.
