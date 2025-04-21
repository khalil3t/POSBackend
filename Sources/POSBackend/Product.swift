//
//  SwiftUIView.swift
//  POSBackend
//
//  Created by Mukwevho Andani on 2025/04/18.
//
import Vapor

struct Product: Content {
    let id: String
    let name: String
    let price: Double
    let costPrice: Double
    let category: String
    let barcode: String
    let scaleType: String
    let scaleUnit: Double
    let stock: Int
}
