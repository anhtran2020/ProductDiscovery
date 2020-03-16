//
//  ProductDetailModel.swift
//  NetworkModule
//
//  Created by Anh Tran on 3/16/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Domain

struct ProductDetailModel: Decodable {
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
    let attributeGroups: [AttributeGroupModel]
}

extension ProductDetailModel: DomainConvertible {
    
    func asDomain() -> Product {
        return Product(sku: sku, name: name, url: url, seller: seller.asDomain(), brand: brand.asDomain(), status: status.asDomain(), objective: objective.asDomain(), productType: productType.asDomain(), images: images.asDomain(), price: price.asDomain(), productLine: productLine.asDomain(), stocks: stocks, totalAvailable: totalAvailable, isBundle: isBundle, bundleProducts: bundleProducts, parentBundles: parentBundles?.asDomain(), totalAvailableByStocks: totalAvailableByStocks.asDomain(), displayName: displayName, color: color.asDomain(), tags: tags, promotionPrices: promotionPrices.asDomain(), promotions: promotions, flashSales: flashSales, attributeSet: attributeSet.asDomain(), categories: categories.asDomain(), magentoId: magentoId, seoInfo: seoInfo.asDomain(), rating: rating.asDomain(), allActiveFlashSales: allActiveFlashSales, attributeGroups: attributeGroups.asDomain())
    }
}

//MARK: - AttributeGroups

struct AttributeGroupModel: Decodable {
    var name: String?
    var value: String?
}

extension AttributeGroupModel: DomainConvertible {
    public func asDomain() -> AttributeGroup {
        return AttributeGroup(name: name, value: value)
    }
}
