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
        var nextButtonConfig = nextButton.configuration ?? UIButton.Configuration.plain()
        switch gameManager?.playJankenGame() {
        case .DRAW:
            nextButtonConfig.title = "もう一度"
            nextButtonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{ incoming in var attributes = incoming; attributes.font = UIFont.systemFont(ofSize: 100); return attributes}
        case .WIN, .LOSE:
            nextButtonConfig.title = "終了"
            nextButtonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{ incoming in var attributes = incoming; attributes.font = UIFont.systemFont(ofSize: 100); return attributes}
        case .none:
            nextButtonConfig.title = "もう一度"
            nextButtonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{ incoming in var attributes = incoming; attributes.font = UIFont.systemFont(ofSize: 100); return attributes}
        }
        nextButtonConfig.baseBackgroundColor = .white
        nextButton.isHidden = false
    }
    
    @IBAction func didTapNextButton() {
        switch gameManager?.playJankenGame() {
        case .DRAW, .none:
            resultLabel.text = "D"
            let storyboard = UIStoryboard(name: "JankenChooseHandViewController", bundle: nil)
            if let nextVC = storyboard.instantiateViewController(withIdentifier: "JankenChooseHandViewController") as? JankenChooseHandViewController {
                nextVC.modalPresentationStyle = .fullScreen
                self.present(nextVC, animated: true, completion: nil)
            }
            case .WIN, .LOSE:
                resultLabel.text = "W"
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let nextVC = storyboard.instantiateViewController(withIdentifier: "JankenStartingGameViewController") as? JankenStartingGameViewController {
                    nextVC.modalPresentationStyle = .fullScreen
                    self.present(nextVC, animated: true, completion: nil)
                }
            }
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

