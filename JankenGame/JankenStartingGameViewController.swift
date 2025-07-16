//
//  JankenStartingGameViewController.swift
//  JankenApp
//
//  Created by 石坂拓人 on 2025/05/25.
//

import UIKit

class JankenStartingGameViewController: UIViewController {
    
    @IBOutlet weak var jankenStartingGameLabel: UILabel!
    @IBOutlet weak var jankenStartingGameButton: UIButton!
    private var jankenUserPlayer: JankenUserPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartButton()
        
    }
    
    private func setStartButton() {
        var jankenStartingGameButtonConfig = jankenStartingGameButton.configuration ?? UIButton.Configuration.plain()
        jankenStartingGameButtonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{
            incoming in var attributes = incoming;
            attributes.font = UIFont.systemFont(ofSize: 50); return attributes}
        jankenStartingGameButtonConfig.background.strokeColor = .gray
        jankenStartingGameButtonConfig.background.strokeWidth = 2
        jankenStartingGameButton.configuration = jankenStartingGameButtonConfig
    }
    
    @IBAction func didTapStartButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "JankenChooseHandViewController", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "JankenChooseHandViewController") as? JankenChooseHandViewController {
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true, completion: nil)
        }
    }
}
