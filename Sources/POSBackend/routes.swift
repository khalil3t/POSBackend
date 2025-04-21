import Vapor

// MARK: - In-memory ProductStore

actor ProductStore {
    private var products: [Product] = []

    func getAll() -> [Product] {
        return products
    }

    func add(_ new: [Product]) {
        products.append(contentsOf: new)
    }

    func setAll(_ all: [Product]) {
        products = all
    }
}

let productStore = ProductStore()

// MARK: - Persistent SalesStore

actor SalesStore {
    private let filePath = "sales.json"

    func save(_ newSales: [SaleRecord]) throws {
        var existing = try load()
        existing.append(contentsOf: newSales)
        let data = try JSONEncoder().encode(existing)
        try data.write(to: URL(fileURLWithPath: filePath))
    }

    func load() throws -> [SaleRecord] {
        let url = URL(fileURLWithPath: filePath)
        guard FileManager.default.fileExists(atPath: url.path) else {
            return []
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([SaleRecord].self, from: data)
    }
}

let salesStore = SalesStore()

// MARK: - Routes

func routes(_ app: Application) throws {
    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    // MARK: - Products

    app.get("products") { req async -> [Product] in
        await productStore.getAll()
    }

    app.post("products") { req async throws -> HTTPStatus in
        let newProducts = try req.content.decode([Product].self)
        await productStore.setAll(newProducts)
        print("✅ Received \(newProducts.count) products")
        return .ok
    }

    // MARK: - Sales

    app.post("sales") { req async throws -> HTTPStatus in
        let sales = try req.content.decode([SaleRecord].self)
        try await salesStore.save(sales)
        print("🧾 Saved \(sales.count) sales to file")
        return .ok
    }

    app.get("sales") { req async throws -> [SaleRecord] in
        try await salesStore.load()
    }
}
