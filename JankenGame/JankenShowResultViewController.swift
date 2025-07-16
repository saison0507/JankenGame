//
//  JankenShowResultViewController.swift
//  JankenGame
//
//  Created by 石坂拓人 on 2025/05/26.
//

import UIKit

class JankenShowResultViewController: UIViewController {
    
    @IBOutlet weak var myChooseHandImageView: UIImageView!
    @IBOutlet weak var rivalChooseHandImageView: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var rivalNameLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    var gameManager: JankenGameManager?
    var user: JankenUserPlayer?
    var rival: JankenCPUPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.isHidden = true
        nextButton.isHidden = true
        setImage()
        setVsLabel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vsLabel.layer.cornerRadius = vsLabel.frame.height / 2
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.setResultLabel()
            self?.setNextButton()
        }
    }
    
    private func setImage() {
        setMyHandImage(user?.CHOSEN_HAND)
        setRivalHandImage(rival?.CHOSEN_HAND)
    }
    
    private func setMyHandImage(_ hand: JankenHand?) {
        switch hand {
        case .guHand:
            myChooseHandImageView.image = UIImage(named: "guhand")
        case .chokiHand:
            myChooseHandImageView.image = UIImage(named: "chokihand")
        case .paHand:
            myChooseHandImageView.image = UIImage(named: "pahand")
        default :
            myChooseHandImageView.image = UIImage(named: "guhand")
        }
    }
    
    private func setRivalHandImage(_ hand: JankenHand?) {
        switch hand {
        case .guHand:
            rivalChooseHandImageView.image = UIImage(named: "guhand")
        case .chokiHand:
            rivalChooseHandImageView.image = UIImage(named: "chokihand")
        case .paHand:
            rivalChooseHandImageView.image = UIImage(named: "pahand")
        default :
            rivalChooseHandImageView.image = UIImage(named: "guhand")
        }
    }
    
    private func setVsLabel() {
        vsLabel.textColor = .black
        vsLabel.clipsToBounds = true
        vsLabel.backgroundColor = .yellow
    }
    
    private func setResultLabel() {
        switch gameManager?.playJankenGame() {
        case .DRAW:
            resultLabel.text = "D"
        case .WIN:
            resultLabel.text = "W"
        case .LOSE:
            resultLabel.text = "L"
        case .none:
            resultLabel.text = "E"
        }
        resultLabel.isHidden = false
    }
    
    private func setNextButton() {
        switch gameManager?.playJankenGame() {
        case .DRAW:
            nextButton.setTitle("D", for: .normal)
        case .WIN:
            nextButton.setTitle("W", for: .normal)
        case .LOSE:
            nextButton.setTitle("L", for: .normal)
        case .none:
            nextButton.setTitle("E", for: .normal)
        }
        nextButton.isHidden = false
    }
}

class DiagonalLineView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(2.0)
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: rect.width, y: rect.height))

        context.strokePath()
    }
}

