//
//  Product.swift
//  Domain
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

public struct Product {
    public let sku: String
    public let name: String
    public let url: String
    public let seller: Seller
    public let brand: Brand
    public let status: ProductStatus
    public let objective: ProductObjective
    public let productType: ProductType
    public let images: [ProductImage]
    public let price: Price
    public let productLine: ProductLine
    public let stocks: [String]
    public let totalAvailable: Int?
    public let isBundle: Bool
    public let bundleProducts: String?
    public let parentBundles: [ParentBundle]?
    public let totalAvailableByStocks: [TotalAvailableByStocks]
    public let displayName: String
    public let color: ProductColor
    public let tags: [String]
    public let promotionPrices: [PromotionPrices]
    public let promotions: [String]
    public let flashSales: [String]
    public let attributeSet: AttributeSet
    public let categories: [ProductCategory]
    public let magentoId: Int?
    public let seoInfo: SeoInfo
    public let rating: Rating
    public let allActiveFlashSales: [String]
    
    public var discount: Int {
        let supplierPrice = price.supplierSalePrice
        let sellPrice = price.sellPrice
        var discount = 0
        if sellPrice > 0 && sellPrice > supplierPrice {
            discount = Int((abs(sellPrice - supplierPrice)/sellPrice)*100)
        }
        return discount
    }
    
    public init(sku: String, name: String, url: String, seller: Seller, brand: Brand, status: ProductStatus, objective: ProductObjective, productType: ProductType, images: [ProductImage], price: Price, productLine: ProductLine, stocks: [String], totalAvailable: Int?, isBundle: Bool, bundleProducts: String?, parentBundles: [ParentBundle]?, totalAvailableByStocks: [TotalAvailableByStocks], displayName: String, color: ProductColor, tags: [String], promotionPrices: [PromotionPrices], promotions: [String], flashSales: [String], attributeSet: AttributeSet, categories: [ProductCategory], magentoId: Int?, seoInfo: SeoInfo, rating: Rating, allActiveFlashSales: [String]) {
        self.sku = sku
        self.name = name
        self.url = url
        self.seller = seller
        self.brand = brand
        self.status = status
        self.objective = objective
        self.productType = productType
        self.images = images
        self.price = price
        self.productLine = productLine
        self.stocks = stocks
        self.totalAvailable = totalAvailable
        self.isBundle = isBundle
        self.bundleProducts = bundleProducts
        self.parentBundles = parentBundles
        self.totalAvailableByStocks = totalAvailableByStocks
        self.displayName = displayName
        self.color = color
        self.tags = tags
        self.promotionPrices = promotionPrices
        self.promotions = promotions
        self.flashSales = flashSales
        self.attributeSet = attributeSet
        self.categories = categories
        self.magentoId = magentoId
        self.seoInfo = seoInfo
        self.rating = rating
        self.allActiveFlashSales = allActiveFlashSales
    }
}

//MARK: - Seller

public struct Seller {
    public let id: Int
    public let name: String
    public let displayName: String
    
    public init(id: Int, name: String, displayName: String) {
        self.id = id
        self.name = name
        self.displayName = displayName
    }
}

//MARK: - Brand

public struct Brand {
    public let code: String
    public let name: String
    
    public init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

//MARK: - ProductStatus

public struct ProductStatus {
    public let publish: Bool
    public let sale: String
    
    public init(publish: Bool, sale: String) {
        self.publish = publish
        self.sale = sale
    }
}

//MARK: - ProductObjective

public struct ProductObjective {
    public let code: String
    public let name: String
    
    public init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

//MARK: - ProductType

public struct ProductType {
    public let code: String
    public let name: String
    
    public init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

//MARK: - ProductImage

public struct ProductImage {
    public let url: String
    public let priority: Int
    public let path: String
    
    public init(url: String, priority: Int, path: String) {
        self.url = url
        self.priority = priority
        self.path = path
    }
}

//MARK: - Price

public struct Price {
    public let supplierSalePrice: Double
    public let sellPrice: Double
    
    public init(supplierSalePrice: Double?, sellPrice: Double?) {
        self.supplierSalePrice = supplierSalePrice ?? 0
        self.sellPrice = sellPrice ?? 0
    }
}

//MARK: - ProductLine

public struct ProductLine {
    public let code: String
    public let name: String
    
    public init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

//MARK: - ProductColor

public struct ProductColor {
    public let code: String?
    public let name: String?
    
    public init(code: String?, name: String?) {
        self.code = code
        self.name = name
    }
}

//MARK: - PromotionPrices

public struct PromotionPrices {
    public let channel: String
    public let terminal: String
    public let finalPrice: Double
    public let promotionPrice: Double?
    public let bestPrice: Double
    public let flashSalePrice: Double?
    
    public init(channel: String, terminal: String, finalPrice: Double, promotionPrice: Double?, bestPrice: Double, flashSalePrice: Double?) {
        self.channel = channel
        self.terminal = terminal
        self.finalPrice = finalPrice
        self.promotionPrice = promotionPrice
        self.bestPrice = bestPrice
        self.flashSalePrice = flashSalePrice
    }
}

//MARK: - AttributeSet

public struct AttributeSet {
    public let id: Int?
    public let name: String?
    
    public init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}

//MARK: - ProductCategory

public struct ProductCategory {
    public let id: Int
    public let code: String
    public let name: String
    public let level: Int
    public let parentId: Int
    
    public init(id: Int, code: String, name: String, level: Int, parentId: Int) {
        self.id = id
        self.code = code
        self.name = name
        self.level = level
        self.parentId = parentId
    }
}

//MARK: - SeoInfo

public struct SeoInfo {
    public let metaKeyword: String?
    public let metaTitle: String?
    public let metaDescription: String?
    public let shortDescription: String?
    public let description: String?
    
    public init(metaKeyword: String?, metaTitle: String?, metaDescription: String?, shortDescription: String?, description: String?) {
        self.metaKeyword = metaKeyword
        self.metaTitle = metaTitle
        self.metaDescription = metaDescription
        self.shortDescription = shortDescription
        self.description = description
    }
}

//MARK: - Rating

public struct Rating {
    public let averagePoint: Double?
    public let voteCount: Int?
    
    public init(averagePoint: Double?, voteCount: Int?) {
        self.averagePoint = averagePoint
        self.voteCount = voteCount
    }
}

//MARK: - TotalAvailableByStocks

public struct TotalAvailableByStocks {
    let type: String
    let total: Double
    
    public init(type: String, total: Double) {
        self.type = type
        self.total = total
    }
}

//MARK: - ParentBundle

public struct ParentBundle: Decodable {
    let sku: String?
    let name: String?
    let displayName: String?
    
    public init(sku: String?, name: String?, displayName: String?) {
        self.sku = sku
        self.name = name
        self.displayName = displayName
    }
}
