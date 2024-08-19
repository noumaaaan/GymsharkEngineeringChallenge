//
//  MockProduct.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation

// Used for Previews.
struct MockProduct {
    let product: Product = .init(
        id: 6676631978083,
        sku: "B1A2Q",
        inStock: true,
        sizeInStock: [
            .xs,
            .s,
            .l,
            .xl,
            .xxl
        ],
        availableSizes: [
            .init(
                inStock: true,
                inventoryQuantity: 1,
                size: .xs,
                price: 1000
            ),
            .init(
                inStock: true,
                inventoryQuantity: 1,
                size: .s,
                price: 1000
            ),
            .init(
                inStock: false,
                inventoryQuantity: 0,
                size: .m,
                price: 1000
            ),
            .init(
                inStock: true,
                inventoryQuantity: 1,
                size: .l,
                price: 1000
            ),
            .init(
                inStock: true,
                inventoryQuantity: 1,
                size: .xl,
                price: 1000
            ),
            .init(
                inStock: true,
                inventoryQuantity: 1,
                size: .xxl,
                price: 1000
            )
        ],
        handle: "gymshark-flex-high-waisted-leggings-atlas-blue-marl-aw21",
        title: "Flex High Waisted Leggings",
        description: "<p><strong>FLEXPRESS YOURSELF</strong></p>\n<p><br data-mce-fragment=\"1\">Feel a fit that's true to you in the Flex High Waisted Leggings. Boasting a secure high waisted fit, body contouring and a seamless waistband, they'll stay with you as you bring your best: set by set, rep by rep.</p>\n<p><br data-mce-fragment=\"1\"><strong>Note</strong>: Due to the nature of this colour, these leggings may appear slightly sheer when stretched</p>\n<p> </p>\n<p><br data-mce-fragment=\"1\">- High rise fit<br data-mce-fragment=\"1\">- Body contouring<br data-mce-fragment=\"1\">- Sweat-wicking fabric<br data-mce-fragment=\"1\">- Heat sealed branding to hip<br data-mce-fragment=\"1\">- Jacquard branding to back waistband<br data-mce-fragment=\"1\">- 57% Nylon, 36% Polyester, 7% Elastane<br data-mce-fragment=\"1\">- Model is <meta charset=\"utf-8\"><span data-mce-fragment=\"1\" lang=\"EN-GB\" class=\"TextRun  BCX0 SCXP164468478\" data-contrast=\"none\" data-usefontface=\"false\" xml:lang=\"EN-GB\"><span data-mce-fragment=\"1\" class=\"NormalTextRun  BCX0 SCXP164468478\">5’8” and wears a size XS</span></span><br data-mce-fragment=\"1\">- SKU: B1A2Q-UBBM</p>",
        type: "Womens Leggings",
        fit: nil,
        labels: [
            .goingFast
        ],
        colour: "Atlas Blue Marl",
        price: "£1000.00",
        featuredMedia: .init(
            src: "https://cdn.shopify.com/s/files/1/1326/4923/products/FlexHighWaistedLeggingsAtlasBlueMarl-B1A2Q.A-Edit_BK_d2f952d5-9415-4e5e-ae58-4e6dc3e8acca.jpg?v=1647010482"
        ),
        media: [
            .init(
                src: "https://cdn.shopify.com/s/files/1/1326/4923/products/FlexHighWaistedLeggingsAtlasBlueMarl-B1A2Q.A-Edit_BK_d2f952d5-9415-4e5e-ae58-4e6dc3e8acca.jpg?v=1647010482"
            ),
            .init(
                src: "https://cdn.shopify.com/s/files/1/1326/4923/products/FlexHighWaistedLeggingsAtlasBlueMarl-B1A2Q.B-Edit_BK_2cb96d34-7025-43d2-8604-5960d8784c67.jpg?v=1647010482"
            ),
            .init(
                src: "https://cdn.shopify.com/s/files/1/1326/4923/products/FlexHighWaistedLeggingsAtlasBlueMarl-B1A2Q.C-Edit_BK_92532fcb-1134-49c1-984c-1840ed7cdb3b.jpg?v=1647010482"
            ),
            .init(
                src: "https://cdn.shopify.com/s/files/1/1326/4923/products/FlexHighWaistedLeggingsAtlasBlueMarl-B1A2Q.D1-Edit_BK_cae28099-f663-4610-a16d-7b97b3e20d7f.jpg?v=1647010482"
            ),
            .init(
                src: "https://cdn.shopify.com/s/files/1/1326/4923/products/FlexHighWaistedLeggingsAtlasBlueMarl-B1A2Q.D2-Edit_BK_468a7e35-7a61-4cd4-8738-a47c1b76136a.jpg?v=1647010482"
            ),
            .init(
                src: "https://cdn.shopify.com/s/files/1/1326/4923/products/FlexHighWaistedLeggingsAtlasBlueMarl-B1A2Q.D3-Edit_BK_829b92ae-5fd5-4172-904b-9f5c0bd21d1b.jpg?v=1647010482"
            )
        ]
    )
}
