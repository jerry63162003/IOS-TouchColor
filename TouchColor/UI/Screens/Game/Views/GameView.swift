import UIKit

class GameView: UIView {

    weak var delegate: GameViewDelegate?

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(color: .darkPurple383357)
        addSubviews()
        setupLayout()
        configurePauseButtonAction()
        configureRestartButtonAction()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(score: Int) {
        scoreNumberLabel.text = "\(score)"
    }

    // MARK: Actions

    func configurePauseButtonAction() {
        pauseButton.buttonActionClosure = { [weak self] in
            guard let sself = self else { return }
            sself.delegate?.gameViewDidTapPause(sself)
        }
    }

    func configureRestartButtonAction() {
//        restartButton.buttonActionClosure = { [weak self] in
//            guard let sself = self else { return }
//            sself.delegate?.gameViewDidTapRestart(sself)
//        }
    }

    // MARK: Subviews

    private func addSubviews() {
        addSubview(bgImageView)
        addSubview(topView)
        topView.addSubview(pauseButton)
//        topView.addSubview(restartButton)
        topView.addSubview(scoreView)
//        scoreView.addSubview(scoreTextLabel)
        scoreView.addSubview(scoreImageView)
        scoreImageView.addSubview(scoreNumberLabel)
        addSubview(boardContainerView)
    }

    private let topView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()

    private let pauseButton = Button(image: #imageLiteral(resourceName: "返回"))
//    private let restartButton = Button(image: UIImage(asset: .restartIcon))

    private let scoreView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        return view
    }()
    
    private let bgImageView: UIImageView = {
        let bgImageView = UIImageView(image: #imageLiteral(resourceName: "bg"))
        return bgImageView
    }()

    private let scoreTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = score.localized
        label.font = UIFont(name: FontFamily.BebasNeue.bold.rawValue, size: 17)
        label.textColor = UIColor(color: .lightPurple7D75C7)
        return label
    }()

    private let scoreNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "0"
        label.font = UIFont(name: FontFamily.BebasNeue.bold.rawValue, size: 46)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.textColor = UIColor(color: .white)
        return label
    }()
    
    private let scoreImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "实时分数"))
        return imageView
    }()

    let boardContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()

    var boardView: GameBoardView? {
        didSet {
            if let oldValue = oldValue {
                oldValue.removeFromSuperview()
            }
            if let boardView = boardView {
                configureBoardView(boardView)
            }
        }
    }

    // MARK: Layout

    private func setupLayout() {
        topView.snp.makeConstraints {
            guard let topViewSuperview = topView.superview else { return }
            $0.top.equalTo(20)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.height.greaterThanOrEqualTo(72)
            $0.height.equalTo(topViewSuperview).multipliedBy(0.15).priority(.low)
        }
        
        bgImageView.snp.makeConstraints {
            $0.top.left.right.bottom.equalTo(self)
        }
        
        pauseButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.left.equalToSuperview().offset(16)
            $0.centerYWithinMargins.equalToSuperview().offset(-10)
        }
        pauseButton.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        scoreView.snp.makeConstraints {
            $0.centerWithinMargins.equalToSuperview()
            $0.left.greaterThanOrEqualTo(pauseButton.snp.right).offset(16)
            $0.right.equalToSuperview().offset(-16)
//            $0.right.lessThanOrEqualTo(restartButton.snp.left).offset(-16)
        }
        scoreImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-30)
            $0.right.equalToSuperview()
        }
        scoreNumberLabel.snp.makeConstraints {
            $0.top.right.left.bottom.equalToSuperview()
        }
//        scoreTextLabel.snp.makeConstraints {
//            $0.top.equalTo(scoreNumberLabel.snp.bottom)
//            $0.centerXWithinMargins.equalToSuperview()
//            $0.left.greaterThanOrEqualTo(0)
//            $0.right.lessThanOrEqualTo(0)
//            $0.bottom.equalToSuperview()
//        }
//        restartButton.snp.makeConstraints {
//            $0.right.equalToSuperview()
//            $0.centerYWithinMargins.equalToSuperview()
//        }
//        restartButton.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        boardContainerView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.bottom.equalTo(-16)
        }
    }

    private func configureBoardView(_ boardView: GameBoardView) {
        boardView.delegate = self
        boardContainerView.addSubview(boardView)
        boardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
