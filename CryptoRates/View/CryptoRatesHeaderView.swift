//
//  RatesHeaderView.swift
//  CryptoRates
//
//  Created by Admin on 20/04/2020.
//

import UIKit

class CryptoRatesHeaderView: UICollectionReusableView {
    
    public var animator : UIViewPropertyAnimator!

    let blurEffect = UIBlurEffect(style: .regular)
    var visualEffectView : UIVisualEffectView?
    
    
    let logoTextImageView : UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "LOGO_TEXT_WHITE"))
            iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    let logoImageView : UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "LOGO_WHITE"))
        iv.translatesAutoresizingMaskIntoConstraints = false
          iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupGradientLayer()
   
        addSubview(logoImageView)
        addSubview(logoTextImageView)
        logoTextImageView.alpha = 0
        
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        setupVisualEffectBlur()
        setupShadowParameters()
        let size = UIScreen.main.bounds.size
        refreshConstraints(size: size)
    }
    
    
    public func refreshConstraints(size: CGSize) {
        NSLayoutConstraint.deactivate(logoImageView.constraints)
        NSLayoutConstraint.deactivate(logoTextImageView.constraints)
      
        if size.width < size.height {
                setLogoPortraitConstraints(size: size)
        } else {
            setLogoLandscapeConstraints(size: size)
        }
       
    }
    
    
    
    fileprivate func setLogoPortraitConstraints(size: CGSize) {
        logoImageView.centerInSuperview(size: CGSize(width: size.width * 0.9, height: size.height * 0.3 * 0.35))
        logoTextImageView.centerInSuperview(size: CGSize(width: size.width * 0.45, height: size.height * 0.175 * 0.35))
    }
    
    fileprivate func setLogoLandscapeConstraints(size: CGSize) {
        logoImageView.centerInSuperview(size: CGSize(width: size.width * 0.45, height: size.height * 0.5 * 0.35))
        logoTextImageView.centerInSuperview(size: CGSize(width: size.width * 0.35, height: size.height * 0.29 * 0.35))
     }
    

    
    
    fileprivate func setupGradientLayer() {
        let gradientView = GradientView(frame: bounds)
        addSubview(gradientView)
    }
    
    fileprivate func setupShadowParameters() {
        layer.shadowColor = UIColor(red: 253/255.0, green: 82/255.0, blue: 143/255.0, alpha: 1.0).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
    }
    
    
    
    fileprivate func setupVisualEffectBlur() {
        
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: { [weak self] in
            if let visualEffectView = self?.visualEffectView {
                self?.addSubview(visualEffectView)
                           visualEffectView.fillSuperview()
                           visualEffectView.alpha = 0
           
            }
        
            
            })
        animator.pausesOnCompletion = true
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
