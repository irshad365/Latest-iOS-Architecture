# User Management Project

This project is designed to manage user data efficiently. It utilizes dependency injection to ensure that components are loosely coupled and easily testable.

## Key Features

- **Dependency Injection**: The project uses dependency injection to manage dependencies between components.
The project uses a protocol `DataServiceProtocol` to define the interface for data services. The `DataService` class implements this protocol to fetch data from a remote service, while the `MockDataService` class provides mock data for testing.

- **Protocol**: A protocol is defined to outline the required methods for data services.

```swift
protocol DataServiceProtocol {
    func getPersonList() async throws -> [Person]
}
```

- **Mock Data Service**: A mock data service is implemented to simulate data operations for testing purposes.

```swift
actor MockDataService: DataServiceProtocol {
    func getPersonList() async throws -> [Person] {
        return [
            Person(id: UUID(), name: "John", age: 30),
            Person(id: UUID(), name: "Doe", age: 30)
        ]
    }
}
```

- **ViewModel**: The PersonViewModel class uses the data service to load and filter user data.

```swift
@MainActor
class PersonViewModel: ObservableObject {
    private let service: DataServiceProtocol
    // Implementation of view model
}
```

## License

This project is licensed under the BSD 3-Clause License - see the LICENSE file for details.
