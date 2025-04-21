//
//  SaleRecord.swift
//  
//
//  Created by Mukwevho Andani on 2025/04/19.
//

import Vapor

struct SaleRecord: Content, Codable {
    var id: String
    var productName: String
    var quantity: Int
    var totalAmount: Double
    var timestamp: Date
}

