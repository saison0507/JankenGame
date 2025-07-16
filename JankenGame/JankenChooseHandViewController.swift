import UIKit

class JankenChooseHandViewController: UIViewController {
    
        @IBOutlet weak var JankenChooseHandTitleLabel: UILabel!
        @IBOutlet weak var RockButton: UIButton!
        @IBOutlet weak var ScissorsButton: UIButton!
        @IBOutlet weak var PaperButton: UIButton!
        @IBOutlet weak var OKButton: UIButton!
    
        private var selectedHand: JankenHand? = nil
        var presenter: JankenChooseHandPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            let user = JankenUserPlayer()
            let cpu = JankenCPUPlayer()
            presenter = JankenChooseHandPresenter(jankenUserPlayer: user, jankenCPUPlayer: cpu)
            }
        }
    
    @IBAction func didTapRockButton(_ sender: UIButton) {
        selectedHand = .guHand
    }
    
    @IBAction func didTapScissorsButton(_ sender: UIButton) {
        selectedHand = .chokiHand
    }
    
    @IBAction func didTapPaperButton(_ sender: UIButton) {
        selectedHand = .paHand
    }
    
    @IBAction func didTapOKButton(_ sender: UIButton) {
        guard let selectedHand else {
            JankenChooseHandTitleLabel.text = "手を選んでください"
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
}

