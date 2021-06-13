
// MARK:- TODO: add shadow to upperView

import Foundation
import UIKit
import RAGTextField
import MaterialComponents.MaterialIcons
import MaterialComponents.MDCFloatingButton
import SDWebImage

class ConverterViewController: UIViewController {
    private var chosenQuote: QuoteCached?
    private var upperView: UIView?
    private var baseQuotePrice: Double = -1.0
    private var resultQuotePrice: Double = -1.0
    
    private let lowerView : UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let baseQuoteLogoAndAmountContainerView : UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let baseQuoteLogoImageContainerView : UIView = {
        let containerView = UIView()
      //  containerView.backgroundColor = .lightGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let baseQuoteLogoButton: UIButton = {
        let logoButton = UIButton()
      //  logoButton.backgroundColor = .yellow
        logoButton.addTarget(self, action: #selector(baseLogoButtonTapped), for: .touchUpInside)
        logoButton.translatesAutoresizingMaskIntoConstraints = false
        logoButton.contentMode = .scaleAspectFit
        logoButton.titleLabel?.lineBreakMode = .byWordWrapping
        logoButton.titleLabel?.numberOfLines = 2
        logoButton.layer.borderColor = UIColor.white.cgColor
        logoButton.layer.borderWidth = 3.0
        logoButton.layer.cornerRadius = 8.0
        logoButton.setTitle("Choose currency", for: UIControl.State())
        return logoButton
    }()
    
    private let baseQuoteTextFieldContainerView : UIView = {
        let containerView = UIView()
        //containerView.backgroundColor = .yellow
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private var baseQuotePriceTextField: RAGTextField = {
        let outlineTextField = RAGTextField()
        let bgView = OutlineView(frame: .zero)
        bgView.lineWidth = 3
        bgView.lineColor = .white
        bgView.fillColor = nil
        bgView.cornerRadius = 6.0
        outlineTextField.textColor = .white
        outlineTextField.tintColor = .white
        outlineTextField.clearButtonMode = .whileEditing
        outlineTextField.keyboardType = .numbersAndPunctuation
        
       
       
        outlineTextField.placeholder = "Base currency amount"
        outlineTextField.textBackgroundView = bgView
        outlineTextField.textPadding = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        outlineTextField.textPaddingMode = .text
        outlineTextField.scaledPlaceholderOffset = 0.0
        outlineTextField.placeholderMode = .scalesWhenEditing
        outlineTextField.placeholderScaleWhenEditing = 0.8
        outlineTextField.adjustsFontSizeToFitWidth = true
        outlineTextField.font = UIFont .systemFont(ofSize: 20)
        outlineTextField.placeholderColor = .white
        return outlineTextField
    }()
    
    private let convertButtonContainerView : UIImageView = {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.clear.cgColor)
            let rectangle = CGRect(x: 0, y: 0, width: 100, height: 100)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        let imageView = UIImageView()
        imageView.image = img
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let convertButtonShadowView : UIImageView = {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.clear.cgColor)
            let rectangle = CGRect(x: 0, y: 0, width: 100, height: 100)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        let imageView = UIImageView()
        imageView.image = img
        imageView.layer.shadowColor = UIColor(red: 253/255.0, green: 82/255.0, blue: 143/255.0, alpha: 1.0).cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate var convertButton: MDCFloatingButton = {
        let floatingButton = MDCFloatingButton(shape: .default)
        floatingButton.setTitle("+", for: UIControl.State())
        floatingButton.setTitleColor(.white, for: UIControl.State())
        floatingButton.addTarget(self, action: #selector(convertButtonTapped), for: .touchDown)
        floatingButton.addTarget(self, action: #selector(convertButtonUntapped), for: .touchUpInside)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.isUserInteractionEnabled = true
        floatingButton.setGradientBackgroundColors([UIColor(red: 253/255.0, green: 82/255.0, blue: 143/255.0, alpha: 1.0), UIColor(red: 255/255.0, green: 170/255.0, blue: 104/255.0, alpha: 1.0)], direction: .toTopRight, for: UIControl.State())
        floatingButton.layer.masksToBounds = true
        return floatingButton
    }()
    
    private let resultQuoteLogoAndAmountContainerView : UIView = {
        let containerView = UIView()
      //  containerView.backgroundColor = .lightGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let resultQuoteLogoImageContainerView : UIView = {
        let containerView = UIView()
    //    containerView.backgroundColor = .gray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let resultQuoteLogoButton: UIButton = {
        let logoButton = UIButton()
     //   logoButton.backgroundColor = .yellow
        logoButton.translatesAutoresizingMaskIntoConstraints = false
        logoButton.contentMode = .scaleAspectFit
        logoButton.titleLabel?.lineBreakMode = .byWordWrapping
        logoButton.titleLabel?.numberOfLines = 2
        logoButton.setTitle("Choose currency", for: UIControl.State())
        logoButton.setTitleColor(.black, for: UIControl.State())
        logoButton.layer.borderColor = UIColor.black.cgColor
        logoButton.layer.borderWidth = 3.0
        logoButton.layer.cornerRadius = 8.0
        logoButton.addTarget(self, action: #selector(resultLogoButtonTapped), for: .touchUpInside)
        return logoButton
    }()
    
    private let resultQuoteTextFieldContainerView : UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private var resultQuotePriceTextField: RAGTextField = {
        let outlineTextField = RAGTextField()
        let bgView = OutlineView(frame: .zero)
        bgView.lineWidth = 3
        bgView.lineColor = .black
        bgView.fillColor = nil
        bgView.cornerRadius = 6.0
        outlineTextField.textColor = .black
        outlineTextField.tintColor = .black
        outlineTextField.placeholder = "Result currency amount"
        
        outlineTextField.textBackgroundView = bgView
        outlineTextField.textPadding = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        outlineTextField.textPaddingMode = .text
        outlineTextField.scaledPlaceholderOffset = 0.0
        outlineTextField.placeholderMode = .scalesWhenNotEmpty
        outlineTextField.placeholderScaleWhenEditing = 0.8
        outlineTextField.adjustsFontSizeToFitWidth = true
        outlineTextField.font = UIFont .systemFont(ofSize: 20)
        outlineTextField.placeholderColor = .black
        outlineTextField.isUserInteractionEnabled = false
        return outlineTextField
    }()
    
    fileprivate func configureSubviews() {
        
        upperView = {
            let upperView = UIView()
            let gradientView = GradientView(frame: upperView.bounds)
            upperView.addSubview(gradientView)
            upperView.translatesAutoresizingMaskIntoConstraints = false
            return upperView
        }()
        if let upperView = upperView {
            view.addSubview(upperView)
            upperView.addSubview(baseQuoteLogoAndAmountContainerView)
            baseQuoteLogoAndAmountContainerView.addSubview(baseQuoteLogoImageContainerView)
            baseQuoteLogoImageContainerView.addSubview(baseQuoteLogoButton)
            baseQuoteLogoAndAmountContainerView.addSubview(baseQuoteTextFieldContainerView)
            baseQuoteTextFieldContainerView.addSubview(baseQuotePriceTextField)
            
            upperView.addSubview(convertButtonContainerView)
            
            view.addSubview(convertButtonShadowView)
            
            view.addSubview(lowerView)
            lowerView.addSubview(resultQuoteLogoAndAmountContainerView)
            resultQuoteLogoAndAmountContainerView.addSubview(resultQuoteLogoImageContainerView)
            resultQuoteLogoImageContainerView.addSubview(resultQuoteLogoButton)
            resultQuoteLogoAndAmountContainerView.addSubview(resultQuoteTextFieldContainerView)
            resultQuoteTextFieldContainerView.addSubview(resultQuotePriceTextField)
            
            view.addSubview(convertButton)
            
        }
        baseQuotePriceTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.recievedChosenQuote(_:)), name: NotificationConstants.chosenQuoteNotificationName, object: nil)
        configureSubviews()
        
        
        
        configureConstraints(size: view.frame.size)
        configureTapGesture()
        configureFonts()
    }
    
    private func configureFonts() {
        let frameSize = view.frame
        if frameSize.width < frameSize.height {
            let width = frameSize.width
            resultQuotePriceTextField.placeholderFont = UIFont(name: FontsConstants.proximaNovaRegular, size: width/23)
            resultQuoteLogoButton.titleLabel?.font = UIFont(name: FontsConstants.proximaNovaRegular, size: width/23)
            baseQuoteLogoButton.titleLabel?.font = UIFont(name: FontsConstants.proximaNovaRegular, size: width/23)
            baseQuotePriceTextField.placeholderFont = UIFont(name: FontsConstants.proximaNovaRegular, size: width/23)
        } else {
            let height = frameSize.height
            resultQuotePriceTextField.placeholderFont = UIFont(name: FontsConstants.proximaNovaRegular, size: height/23)
            resultQuoteLogoButton.titleLabel?.font = UIFont(name: FontsConstants.proximaNovaRegular, size: height/23)
            baseQuoteLogoButton.titleLabel?.font = UIFont(name: FontsConstants.proximaNovaRegular, size: height/23)
            baseQuotePriceTextField.placeholderFont = UIFont(name: FontsConstants.proximaNovaRegular, size: height/23)
        }
        
        
        
    }
    
    
    
    private func configureConstraints(size: CGSize) {
        var constraints: [NSLayoutConstraint] = []
        if let upperView = upperView {
            constraints.append(contentsOf: upperView.constraints)
            constraints.append(contentsOf: baseQuoteLogoAndAmountContainerView.constraints)
            constraints.append(contentsOf: baseQuoteLogoImageContainerView.constraints)
            constraints.append(contentsOf: baseQuoteLogoButton.constraints)
            constraints.append(contentsOf: baseQuoteTextFieldContainerView.constraints)
            constraints.append(contentsOf: baseQuotePriceTextField.constraints)
            constraints.append(contentsOf: convertButtonContainerView.constraints)
            constraints.append(contentsOf: convertButtonShadowView.constraints)
            constraints.append(contentsOf: convertButton.constraints)
            constraints.append(contentsOf: lowerView.constraints)
            constraints.append(contentsOf: resultQuoteLogoAndAmountContainerView.constraints)
            constraints.append(contentsOf: resultQuoteLogoImageContainerView.constraints)
            constraints.append(contentsOf: resultQuoteLogoButton.constraints)
            constraints.append(contentsOf: resultQuoteTextFieldContainerView.constraints)
            constraints.append(contentsOf: resultQuotePriceTextField.constraints)
            NSLayoutConstraint.deactivate(constraints)
            
            if size.width < size.height {
                baseQuoteLogoAndAmountContainerView.centerInSuperview(constraintsToSuperview: CGSize(width: 0.9, height: 0.3))
                
                resultQuoteLogoAndAmountContainerView.centerInSuperview(constraintsToSuperview: CGSize(width: 0.95, height: 0.3))
                
                convertButtonContainerView.widthAnchor.constraint(equalTo: upperView.widthAnchor, multiplier: 0.3).isActive = true
            } else {
                baseQuoteLogoAndAmountContainerView.centerXAnchor.constraint(equalTo: upperView.centerXAnchor).isActive = true
                baseQuoteLogoAndAmountContainerView.centerYAnchor.constraint(equalTo: upperView.centerYAnchor, constant: -size.height * 0.08).isActive = true
                baseQuoteLogoAndAmountContainerView.widthAnchor.constraint(equalTo: upperView.widthAnchor, multiplier: 0.7).isActive = true
                baseQuoteLogoAndAmountContainerView.heightAnchor.constraint(equalTo: upperView.heightAnchor, multiplier: 0.5).isActive = true
                
                resultQuoteLogoAndAmountContainerView.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
                resultQuoteLogoAndAmountContainerView.centerYAnchor.constraint(equalTo: lowerView.centerYAnchor, constant: 0/*-size.height * 0.08*/).isActive = true
                resultQuoteLogoAndAmountContainerView.widthAnchor.constraint(equalTo: lowerView.widthAnchor, multiplier: 0.7).isActive = true
                resultQuoteLogoAndAmountContainerView.heightAnchor.constraint(equalTo: lowerView.heightAnchor, multiplier: 0.5).isActive = true
                
                convertButtonContainerView.widthAnchor.constraint(equalTo: upperView.heightAnchor, multiplier: 0.6).isActive = true
            }
            
            upperView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, constraintsToSuperview: CGSize(width: 0, height: 0.5))
            
            lowerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, constraintsToSuperview: CGSize(width: 0, height: 0.5))
            
            baseQuoteLogoImageContainerView.anchor(top: baseQuoteLogoAndAmountContainerView.topAnchor, leading: baseQuoteLogoAndAmountContainerView.leadingAnchor, bottom: baseQuoteLogoAndAmountContainerView.bottomAnchor, trailing: nil)
            baseQuoteLogoImageContainerView.widthAnchor.constraint(equalTo: baseQuoteLogoImageContainerView.heightAnchor).isActive = true
            
            baseQuoteLogoButton.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
            
            baseQuoteTextFieldContainerView.anchor(top: baseQuoteLogoAndAmountContainerView.topAnchor, leading: baseQuoteLogoImageContainerView.trailingAnchor, bottom: baseQuoteLogoAndAmountContainerView.bottomAnchor, trailing: baseQuoteLogoAndAmountContainerView.trailingAnchor)
            
            baseQuotePriceTextField.centerInSuperview(constraintsToSuperview: CGSize(width: 0.9, height: 0.6))
            
            
            resultQuoteLogoImageContainerView.anchor(top: resultQuoteLogoAndAmountContainerView.topAnchor, leading: resultQuoteLogoAndAmountContainerView.leadingAnchor, bottom: resultQuoteLogoAndAmountContainerView.bottomAnchor, trailing: nil,  constraintsToSuperview: CGSize(width: 0, height: 0))
            resultQuoteLogoImageContainerView.widthAnchor.constraint(equalTo: resultQuoteLogoImageContainerView.heightAnchor).isActive = true
            
            resultQuoteLogoButton.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
            
            resultQuoteTextFieldContainerView.anchor(top: resultQuoteLogoAndAmountContainerView.topAnchor, leading: resultQuoteLogoImageContainerView.trailingAnchor, bottom: resultQuoteLogoAndAmountContainerView.bottomAnchor, trailing: resultQuoteLogoAndAmountContainerView.trailingAnchor)
            
            resultQuotePriceTextField.centerInSuperview(constraintsToSuperview: CGSize(width: 0.9, height: 0.6))
            
            convertButtonContainerView.heightAnchor.constraint(equalTo: convertButtonContainerView.widthAnchor).isActive = true
            convertButtonContainerView.centerYAnchor.constraint(equalTo: upperView.bottomAnchor).isActive = true
            convertButtonContainerView.centerXAnchor.constraint(equalTo: upperView.centerXAnchor).isActive = true
            
            convertButtonShadowView.centerXAnchor.constraint(equalTo: convertButtonContainerView.centerXAnchor).isActive = true
            convertButtonShadowView.centerYAnchor.constraint(equalTo: convertButtonContainerView.centerYAnchor).isActive = true
            convertButtonShadowView.widthAnchor.constraint(equalTo: convertButtonContainerView.widthAnchor, multiplier: 0.8).isActive = true
            convertButtonShadowView.heightAnchor.constraint(equalTo: convertButtonContainerView.heightAnchor, multiplier: 0.8).isActive = true
            
            convertButton.centerXAnchor.constraint(equalTo: convertButtonContainerView.centerXAnchor).isActive = true
            convertButton.centerYAnchor.constraint(equalTo: convertButtonContainerView.centerYAnchor).isActive = true
            convertButton.widthAnchor.constraint(equalTo: convertButtonContainerView.widthAnchor, multiplier: 0.8).isActive = true
            convertButton.heightAnchor.constraint(equalTo: convertButtonContainerView.heightAnchor, multiplier: 0.8).isActive = true
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       coordinator.animateAlongsideTransition(in: view, animation: { (nil) in
            if self.upperView != nil {
                self.configureConstraints(size: size)
            }
        })
   
    }
    
    private func configureTapGesture () {
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(ConverterViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func recievedChosenQuote(_ notification: NSNotification) {
        if let notificationUserInfoKeys = notification.userInfo?.keys {
            if notificationUserInfoKeys.count > 0 {
                if notificationUserInfoKeys.first as! String == "baseLogoButton" {
                    if let quote = notification.userInfo?["baseLogoButton"] as? QuoteCached {
                        baseQuoteLogoButton.setTitle("", for: UIControl.State())
                        baseQuoteLogoButton.layer.borderWidth = 0
                        baseQuotePriceTextField.placeholder = "Base currency amount"
                        if let price = Double(quote.priceDouble) {
                            baseQuotePrice = price
                        }
                        if let unwrappedURL = URL(string: "https://www.cryptocompare.com\(quote.imageURL)") {
                            baseQuoteLogoButton.sd_setImage(with: unwrappedURL, for: UIControl.State()) { (image, error, SDImageCacheType, URL) in
                               if let image = image {
                                    self.baseQuoteLogoButton.setImage(image, for: UIControl.State())
                                }
                                if let error = error {
                                    print(error)
                                }
                                
                            }
                        }
                    }
                } else if notificationUserInfoKeys.first as! String == "resultLogoButton" {
                    if let quote = notification.userInfo?["resultLogoButton"] as? QuoteCached {
                        resultQuoteLogoButton.setTitle("", for: UIControl.State())
                        resultQuoteLogoButton.layer.borderWidth = 0
                        resultQuotePriceTextField.placeholder = "Result currency amount"
                        if let price = Double(quote.priceDouble) {
                            resultQuotePrice = price
                        }
                        if let unwrappedURL = URL(string: "https://www.cryptocompare.com\(quote.imageURL)") {
                            resultQuoteLogoButton.sd_setImage(with: unwrappedURL, for: UIControl.State()) { (image, error, SDImageCacheType, URL) in
                               if let image = image {
                                    self.resultQuoteLogoButton.setImage(image, for: UIControl.State())
                                }
                                if let error = error {
                                    print(error)
                                }
                               
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func baseLogoButtonTapped() {
        let logoCollectionVC = LogoCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        logoCollectionVC.setSourceButton(sourceButton: .baseLogoButton)
        let navigationController = UINavigationController(rootViewController: logoCollectionVC)
       
       
        navigationController.view.layoutIfNeeded()
        view.endEditing(true)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func resultLogoButtonTapped() {

        let logoCollectionVC = LogoCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        logoCollectionVC.setSourceButton(sourceButton: .resultLogoButton)
        let navigationController = UINavigationController(rootViewController: logoCollectionVC)
        
        navigationController.view.layoutIfNeeded()
        view.endEditing(true)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func convertButtonTapped() {
        UIView.animate(withDuration: 1.0) {
            self.convertButtonShadowView.layer.shadowOffset.height = 15
        }
        if baseQuotePriceTextField.text != ""  {
            if baseQuotePrice == -1 {
                baseQuotePriceTextField.placeholder = "Please choose base currency"
            } else if resultQuotePrice == -1 {
                resultQuotePriceTextField.placeholder = "Please choose result currency"
                resultQuotePriceTextField.text = "0"
            } else {
                resultQuotePriceTextField.text = String(Double(baseQuotePriceTextField.text!)! * baseQuotePrice / resultQuotePrice)
            }
            
            
        }
        view.endEditing(true)
    }
    
    @objc private func convertButtonUntapped() {
        UIView.animate(withDuration: 1.0) {
            self.convertButtonShadowView.layer.shadowOffset.height = 10
        }
    }
    
}

extension ConverterViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = ".0123456789"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
}


