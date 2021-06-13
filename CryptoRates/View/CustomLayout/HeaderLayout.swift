//
//  HeaderViewLayout.swift
//  CryptoRates
//
//  Created by Admin on 20/04/2020.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout {
    
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = super.layoutAttributesForElements(in: rect) ?? [UICollectionViewLayoutAttributes()]
        //added
        let headerIndexPath = IndexPath(item: 0, section: 0)
        let headerAttributes = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: headerIndexPath) ?? UICollectionViewLayoutAttributes()
        
        
        if !layoutAttributes.contains(headerAttributes) {
            layoutAttributes.append(headerAttributes)
        }
        
        
        layoutAttributes.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
                if let collectionView = collectionView {
                    
                    let contentOffsetY = collectionView.contentOffset.y
                  let size = UIScreen.main.bounds.size
                    if contentOffsetY > 0 {
                        if size.width < size.height {
                            if contentOffsetY > attributes.frame.height * 0.6 {
                                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: collectionView.frame.width, height: attributes.frame.height * 0.4)
                            }
                        } else  {
                            if contentOffsetY > attributes.frame.height * 0.5 {
                                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: collectionView.frame.width, height: attributes.frame.height * 0.5)
                            }
                        }
                        return
                    }
                    let height = attributes.frame.height - contentOffsetY
                    let width = collectionView.frame.width
                    attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
                    
                }
            }
        })
        
        
        return layoutAttributes
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
     
        return true
    }
    
    
}
