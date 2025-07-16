import UIKit

class JankenChooseHandViewController: UIViewController {
    
        @IBOutlet weak var JankenChooseHandTitleLabel: UILabel!
        @IBOutlet weak var RockButton: UIButton!
        @IBOutlet weak var ScissorsButton: UIButton!
        @IBOutlet weak var PaperButton: UIButton!
        @IBOutlet weak var OKButton: UIButton!
        @IBOutlet weak var CancelButton: UIButton!
    
        private var selectedHand: JankenHand? = nil
        var presenter: JankenChooseHandPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            let user = JankenUserPlayer()
            let cpu = JankenCPUPlayer()
            presenter = JankenChooseHandPresenter(jankenUserPlayer: user, jankenCPUPlayer: cpu)
            }
        setOKButton()
        setCancelButton()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedHand = nil
        setJankenChooseHandTitleLabel()
        resetButtonBorders()
    }
    
    private func setJankenChooseHandTitleLabel() {
        let attributedString = NSAttributedString(
            string: "出す手を選んでください",
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: 32),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        JankenChooseHandTitleLabel.attributedText = attributedString
    }
    
    private func setCancelButton() {
        var CancelButtonConfig = CancelButton.configuration ?? UIButton.Configuration.plain()
        CancelButtonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{
            incoming in var attributes = incoming;
            attributes.font = UIFont.systemFont(ofSize: 30); return attributes}
        CancelButtonConfig.background.backgroundColor = .white
        CancelButtonConfig.background.strokeColor = .gray
        CancelButtonConfig.background.strokeWidth = 2
        CancelButton.configuration = CancelButtonConfig
    }
    
    private func setOKButton() {
        var OKButtonConfig = OKButton.configuration ?? UIButton.Configuration.plain()
        OKButtonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{
            incoming in var attributes = incoming;
            attributes.font = UIFont.systemFont(ofSize: 50); return attributes}
        OKButtonConfig.background.backgroundColor = .white
        OKButtonConfig.background.strokeColor = .gray
        OKButtonConfig.background.strokeWidth = 2
        OKButton.configuration = OKButtonConfig
    }
    
    private func resetButtonBorders() {
        let buttons = [RockButton, ScissorsButton, PaperButton]
        for button in buttons {
            button?.layer.borderWidth = 0
            button?.layer.borderColor = nil
        }
    }
    
    private func updateButtonBorders(selectedButton: UIButton) {
        resetButtonBorders()
        let buttons = [RockButton, ScissorsButton, PaperButton]
        for button in buttons {
            button?.layer.borderWidth = 0
            button?.layer.borderColor = nil
        }
        
        // 選択したボタンに枠線を追加
        selectedButton.layer.borderWidth = 4
        selectedButton.layer.borderColor = UIColor.black.cgColor
        selectedButton.layer.cornerRadius = 8
    }
    
    @IBAction func didTapRockButton(_ sender: UIButton) {
        selectedHand = .guHand
        JankenChooseHandTitleLabel.text = "グーを選択中"
        JankenChooseHandTitleLabel.textColor = .black
        updateButtonBorders(selectedButton: sender)
        OKButton.backgroundColor = .white
    }
    
    @IBAction func didTapScissorsButton(_ sender: UIButton) {
        selectedHand = .chokiHand
        JankenChooseHandTitleLabel.text = "チョキを選択中"
        JankenChooseHandTitleLabel.textColor = .black
        updateButtonBorders(selectedButton: sender)
        OKButton.backgroundColor = .white
    }
    
    @IBAction func didTapPaperButton(_ sender: UIButton) {
        selectedHand = .paHand
        JankenChooseHandTitleLabel.text = "パーを選択中"
        JankenChooseHandTitleLabel.textColor = .black
        updateButtonBorders(selectedButton: sender)
        OKButton.backgroundColor = .white
    }
    
    @IBAction func didTapOKButton(_ sender: UIButton) {
        guard let selectedHand else {
            JankenChooseHandTitleLabel.text = "手が選択されていません"
            JankenChooseHandTitleLabel.textColor = .red
            UIView.animate(withDuration: 0.2, animations: {
                    self.JankenChooseHandTitleLabel.backgroundColor = UIColor.yellow.withAlphaComponent(0.7)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.JankenChooseHandTitleLabel.backgroundColor = UIColor.clear
                    })
                })
            return
        }
        presenter?.setUserHand(selectedHand: selectedHand)
        let gameManager = presenter?.createGameManager()
        let storyboard = UIStoryboard(name: "JankenShowResultViewController", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "JankenShowResultViewController") as? JankenShowResultViewController {
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.gameManager = gameManager
            nextVC.user = presenter?.userPlayer
            nextVC.rival = presenter?.cpuPlayer
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

