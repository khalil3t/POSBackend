import Vapor

public func configure(_ app: Application) async throws {
    try routes(app) // This registers routes.swift
}
