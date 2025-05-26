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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapStartButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "JankenChooseHandViewController", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "JankenChooseHandViewController") as? JankenChooseHandViewController {
            nextVC.modalPresentationStyle = .fullScreen  // ← ここを修正
            self.present(nextVC, animated: true, completion: nil)
        }
    }
}
