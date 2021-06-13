//
//  AboutViewController.swift
//  CryptoRates
//
//  Created by Admin on 20/06/2020.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    
    
    private var poweredByImageView: UIImageView?
    
    private let titleTextlabel: UILabel = {
        var titleLabelText = "CryptoRates"
        let label = UILabel()
        //label.font = UIFont(name: "AbrilFatface-Regular", size: 36)
         //  label.textColor = UIColor(red: 0.039, green: 0.192, blue: 0.259, alpha: 1)
           //label.lineBreakMode = .byWordWrapping
           
          
        label.text = titleLabelText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
       
        
        return label
    }()
    
    private let descriptionTextlabel: UILabel = {
           var titleLabelText = "Created by Farkhat Samarkanov\r\n\r\ne-mail: farhatsamarkanov@gmail.com\r\n\r\nThis app is made merely as portfolio content. Amount of requests to refresh quotes per month is limited!"
           let label = UILabel()
           label.font = UIFont(name: "AbrilFatface-Regular", size: 5)
            //  label.textColor = UIColor(red: 0.039, green: 0.192, blue: 0.259, alpha: 1)
        label.lineBreakMode = .byWordWrapping
              

              let paragraphStyle = NSMutableParagraphStyle()
              paragraphStyle.lineHeightMultiple = 0.8
              let attrString = NSMutableAttributedString(string: titleLabelText)
              attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value:paragraphStyle,
                                      range: NSRange(location: 0, length:attrString.length))
              label.attributedText = attrString
              label.sizeToFit()
              
             
           
           label.textAlignment = .natural
           label.translatesAutoresizingMaskIntoConstraints = false
           label.numberOfLines = 0
           
           
           return label
       }()
    
    private let mainContainerView : UIView = {
        let containerView = UIView()
        //containerView.backgroundColor = .lightGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let poweredByContainerView : UIView = {
        let containerView = UIView()
      //  containerView.backgroundColor = .gray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let titleLabelContainerView : UIView = {
        let containerView = UIView()
       // containerView.backgroundColor = .red
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let descriptionLabelContainerView : UIView = {
        let containerView = UIView()
       // containerView.backgroundColor = .yellow
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
 
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition(in: view, animation: { (nil) in
            if self.poweredByImageView != nil {
                self.configureConstraints(size: size)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        poweredByImageView = {
               let poweredByImageView = UIImageView()
               poweredByImageView.translatesAutoresizingMaskIntoConstraints = false
               poweredByImageView.contentMode = .scaleAspectFit
               poweredByImageView.image = UIImage(named: "poweredBy")
               return poweredByImageView
           }()
        configureSubviews()
        configureConstraints(size: view.frame.size)
        configureFonts()
    }
    
    private func configureFonts() {
        let frameSize = view.frame
        if frameSize.width < frameSize.height {
            let width = frameSize.width
            titleTextlabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: width/15)
            descriptionTextlabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: width/20)
        } else {
            let height = frameSize.height
            titleTextlabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: height/15)
            descriptionTextlabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: height/20)
        }
        
    }
    
    private func configureSubviews(){
        view.addSubview(mainContainerView)
        mainContainerView.addSubview(poweredByContainerView)
        if let poweredByImageView = poweredByImageView {
            poweredByContainerView.addSubview(poweredByImageView)
            mainContainerView.addSubview(titleLabelContainerView)
            titleLabelContainerView.addSubview(titleTextlabel)
            mainContainerView.addSubview(descriptionLabelContainerView)
            descriptionLabelContainerView.addSubview(descriptionTextlabel)
        }
        
        
    }
    
    
    private func configureConstraints(size: CGSize) {
        var constraints: [NSLayoutConstraint] = []
        if let poweredByImageView = poweredByImageView {
            constraints.append(contentsOf: mainContainerView.constraints)
            constraints.append(contentsOf: poweredByContainerView.constraints)
            constraints.append(contentsOf: poweredByImageView.constraints)
            constraints.append(contentsOf: titleLabelContainerView.constraints)
            constraints.append(contentsOf: titleTextlabel.constraints)
            constraints.append(contentsOf: descriptionLabelContainerView.constraints)
            constraints.append(contentsOf: descriptionTextlabel.constraints)
            NSLayoutConstraint.deactivate(constraints)
            
            mainContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            mainContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            if size.width < size.height {
              //  mainContainerView.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.6))
                let c1 = mainContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
                c1.priority = UILayoutPriority(rawValue: 999)
                c1.isActive = true
                
                let c2 = mainContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95)
                    c2.priority = UILayoutPriority(rawValue: 999)
                c2.isActive = true
            } else {
                // mainContainerView.centerInSuperview(constraintsToSuperview: CGSize(width: 0.5, height: 0.9))
              
                let c1 = mainContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9)
                c1.priority = UILayoutPriority(rawValue: 999)
                c1.isActive = true
               
                let c2 = mainContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95)
                c2.priority = UILayoutPriority(rawValue: 999)
                c2.isActive = true
               
              
            }
            poweredByContainerView.anchor(top: mainContainerView.topAnchor, leading: mainContainerView.leadingAnchor, bottom: nil, trailing: mainContainerView.trailingAnchor)
            poweredByContainerView.heightAnchor.constraint(equalTo: mainContainerView.heightAnchor, multiplier: 0.15).isActive = true
            
            poweredByImageView.centerInSuperview(constraintsToSuperview: CGSize(width: 0.6, height: 0.6))
            
            
            
            
            titleLabelContainerView.anchor(top: poweredByContainerView.bottomAnchor, leading: mainContainerView.leadingAnchor, bottom: nil, trailing: mainContainerView.trailingAnchor)
            titleLabelContainerView.heightAnchor.constraint(equalTo: mainContainerView.heightAnchor, multiplier: 0.1).isActive = true
            titleTextlabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.95, height: 0.8))
            
            descriptionLabelContainerView.anchor(top: titleLabelContainerView.bottomAnchor, leading: mainContainerView.leadingAnchor, bottom: mainContainerView.bottomAnchor, trailing: mainContainerView.trailingAnchor)
            
            descriptionTextlabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.95, height: 0.8))
        }
        
        
    }
}
