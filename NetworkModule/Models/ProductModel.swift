//
//  ProductModel.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Domain
import SwiftyJSON

protocol NetworkParsableType {
    init(data: Any)
}

struct ProductObject: NetworkParsableType {
    let sku: String
    let products: [ProductModel]!
    
    init(data: Any) {
        let json = JSON(data)
        sku = json["sku"].stringValue
    }
}

struct ProductModel: Decodable {
    let sku: String
    let name: String
    let url: String
    let seller: SellerModel
    let brand: BrandModel
    let status: ProductStatusModel
    let objective: ProductObjectiveModel
    let productType: ProductTypeModel
    let images: [ProductImageModel]
    let price: PriceModel
    let productLine: ProductLineModel
    let stocks: [String]
    let totalAvailable: Int?
    let isBundle: Bool
    let bundleProducts: String?
    let parentBundles: [ParentBundleModel]?
    let totalAvailableByStocks: [TotalAvailableByStocksModel]
    let displayName: String
    let color: ProductColorModel
    let tags: [String]
    let promotionPrices: [PromotionPricesModel]
    let promotions: [String]
    let flashSales: [String]
    let attributeSet: AttributeSetModel
    let categories: [CategoryModel]
    let magentoId: Int?
    let seoInfo: SeoInfoModel
    let rating: RatingModel
    let allActiveFlashSales: [String]
}

extension ProductModel: DomainConvertible {
    
    func asDomain() -> Product {
        return Product(sku: sku, name: name, url: url, seller: seller.asDomain(), brand: brand.asDomain(), status: status.asDomain(), objective: objective.asDomain(), productType: productType.asDomain(), images: images.asDomain(), price: price.asDomain(), productLine: productLine.asDomain(), stocks: stocks, totalAvailable: totalAvailable, isBundle: isBundle, bundleProducts: bundleProducts, parentBundles: parentBundles?.asDomain(), totalAvailableByStocks: totalAvailableByStocks.asDomain(), displayName: displayName, color: color.asDomain(), tags: tags, promotionPrices: promotionPrices.asDomain(), promotions: promotions, flashSales: flashSales, attributeSet: attributeSet.asDomain(), categories: categories.asDomain(), magentoId: magentoId, seoInfo: seoInfo.asDomain(), rating: rating.asDomain(), allActiveFlashSales: allActiveFlashSales)
    }
}

//MARK: - SellerModel

struct SellerModel: Decodable {
  let id: Int
  let name: String
  let displayName: String
}

extension SellerModel: DomainConvertible {
    func asDomain() -> Seller {
        return Seller(id: id, name: name, displayName: displayName)
    }
}

//MARK: - BrandModel

struct BrandModel: Decodable {
  let code: String
  let name: String
}

extension BrandModel: DomainConvertible {
    func asDomain() -> Brand {
        return Brand(code: code, name: name)
    }
}

//MARK: - ProductStatusModel

struct ProductStatusModel: Decodable {
  let publish: Bool
  let sale: String
}

extension ProductStatusModel: DomainConvertible {
    func asDomain() -> ProductStatus {
        return ProductStatus(publish: publish, sale: sale)
    }
}

//MARK: - ProductObjectiveModel

struct ProductObjectiveModel: Decodable {
  let code: String
  let name: String
}

extension ProductObjectiveModel: DomainConvertible {
    func asDomain() -> ProductObjective {
        return ProductObjective(code: code, name: name)
    }
}

//MARK: - ProductTypeModel

struct ProductTypeModel: Decodable {
  let code: String
  let name: String
}

extension ProductTypeModel: DomainConvertible {
    func asDomain() -> ProductType {
        return ProductType(code: code, name: name)
    }
}

//MARK: - ProductImageModel

struct ProductImageModel: Decodable {
    let url: String
    let priority: Int
    let path: String
}

extension ProductImageModel: DomainConvertible {
    func asDomain() -> ProductImage {
        return ProductImage(url: url, priority: priority, path: path)
    }
}

//MARK: - PriceModel

struct PriceModel: Decodable {
  let supplierSalePrice: Double?
  let sellPrice: Double?
}

extension PriceModel: DomainConvertible {
    func asDomain() -> Price {
        return Price(supplierSalePrice: supplierSalePrice, sellPrice: sellPrice)
    }
}

//MARK: - ProductLineModel

struct ProductLineModel: Decodable {
  let code: String
  let name: String
}

extension ProductLineModel: DomainConvertible {
    func asDomain() -> ProductLine {
        return ProductLine(code: code, name: name)
    }
}

//MARK: - ProductColorModel

struct ProductColorModel: Decodable {
  let code: String?
  let name: String?
}

extension ProductColorModel: DomainConvertible {
    func asDomain() -> ProductColor {
        return ProductColor(code: code, name: name)
    }
}

//MARK: - PromotionPricesModel

struct PromotionPricesModel: Decodable {
    let channel: String
    let terminal: String
    let finalPrice: Double
    let promotionPrice: Double?
    let bestPrice: Double
    let flashSalePrice: Double?
}

extension PromotionPricesModel: DomainConvertible {
    func asDomain() -> PromotionPrices {
        return PromotionPrices(channel: channel, terminal: terminal, finalPrice: finalPrice, promotionPrice: promotionPrice, bestPrice: bestPrice, flashSalePrice: flashSalePrice)
    }
}

//MARK: - AttributeSetModel

struct AttributeSetModel: Decodable {
  let id: Int?
  let name: String?
}

extension AttributeSetModel: DomainConvertible {
    func asDomain() -> AttributeSet {
        return AttributeSet(id: id, name: name)
    }
}

//MARK: - CategoryModel

struct CategoryModel: Decodable {
    let id: Int
    let code: String
    let name: String
    let level: Int
    let parentId: Int
}

extension CategoryModel: DomainConvertible {
    func asDomain() -> ProductCategory {
        return ProductCategory(id: id, code: code, name: name, level: level, parentId: parentId)
    }
}

//MARK: - SeoInfoModel

struct SeoInfoModel: Decodable {
  let metaKeyword: String?
  let metaTitle: String?
  let metaDescription: String?
  let shortDescription: String?
  let description: String?
}

extension SeoInfoModel: DomainConvertible {
    func asDomain() -> SeoInfo {
        return SeoInfo(metaKeyword: metaKeyword, metaTitle: metaTitle, metaDescription: metaDescription, shortDescription: shortDescription, description: description)
    }
}

//MARK: - RatingModel

struct RatingModel: Decodable {
  let averagePoint: Double?
  let voteCount: Int?
}

extension RatingModel: DomainConvertible {
    func asDomain() -> Rating {
        return Rating(averagePoint: averagePoint, voteCount: voteCount)
    }
}

//MARK: - TotalAvailableByStocksModel

public struct TotalAvailableByStocksModel: Decodable {
    let type: String
    let total: Double
}

extension TotalAvailableByStocksModel: DomainConvertible {
    public func asDomain() -> TotalAvailableByStocks {
        return TotalAvailableByStocks(type: type, total: total)
    }
}

//MARK: - ParentBundleModel

public struct ParentBundleModel: Decodable {
    let sku: String?
    let name: String?
    let displayName: String?
}

extension ParentBundleModel: DomainConvertible {
    public func asDomain() -> ParentBundle {
        return ParentBundle(sku: sku, name: name, displayName: displayName)
    }
}
