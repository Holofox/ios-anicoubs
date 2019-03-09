//
//  LoginViewController.swift
//  anicoubs
//
//  Created by Holofox on 05.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit
import PromiseKit
import SwiftyVK

class LoginViewController: UIViewController {
    
    // MARK: Property
    
    let projectNameLabel: UILabel = {
        var att = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 36)]
        var name = NSMutableAttributedString(string: "ANICOUBS", attributes: att)
        
        let label = UILabel()
            label.attributedText = name
            label.textColor = .white
            label.textAlignment = .center
            label.backgroundColor = UIColor.clear
        
        return label
    }()
 
    let sloganTextView: UITextView = {
        let textView = UITextView()
            textView.text = "Only freshly squeezed."
            textView.textColor = .white
            textView.textAlignment = .center
            textView.font = .systemFont(ofSize: 16)
            textView.backgroundColor = UIColor.clear
            textView.isEditable = false
            textView.isSelectable = false
        
        return textView
    }()
    
    let loginButton: ShimmerButton = {
        let shimmer = ShimmerButton()
            shimmer.setTitle("Log In", for: .normal)
            shimmer.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
            shimmer.gradientTint = Color.gradientStartColor
        
        return shimmer
    }()
    
    let registerTextView: UITextView = {
        let textView = UITextView()
            textView.text = "Don't have an account yet? @SignUp@"
            textView.textColor = .white
            textView.textAlignment = .center
            textView.attributedText = textView.attributedText?
                    .replace(placeholder: "@SignUp@", with: "Sign Up", url: "https://vk.com/join")
            textView.backgroundColor = UIColor.clear
            textView.dataDetectorTypes = .link
            textView.isEditable = false
        
        return textView
    }()
    
    let progress = ProgressHUD(title: "Authorization", theme: .dark)

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGradient(colors: [Color.gradientStartColor, Color.gradientEndColor], locations: [0.0, 1.0])
        
        [registerTextView, sloganTextView, loginButton, projectNameLabel, progress].forEach( view.addSubview(_:))
        
        projectNameLabel.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 40))
        projectNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        projectNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        sloganTextView.anchor(top: projectNameLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 30))
        
        registerTextView.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 30))
        
        loginButton.anchor(top: nil, leading: nil, bottom: registerTextView.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: .init(width: 150, height: 50))
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: Handler
    
    @objc func loginAction(sender: UIButton!) {
        
        progress.show()
        
        firstly {
            VKController.authorize()
        }.done { foo in
            self.present(TabBarController(), animated: true, completion: nil)
        }.catch { error in
            let alert = UIAlertController(title: "Authorize failed", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }.finally {
            self.progress.hide()
        }
        
    }
    
}
