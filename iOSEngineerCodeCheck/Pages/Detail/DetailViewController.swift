import UIKit

/// 詳細画面
///
/// - Attention: UI をコードベースで実装しています
class DetailViewController : UIViewController {

    /// 詳細画面のViewController を生成する
    ///
    /// - Parameters:
    ///    - args: 画面遷移パラメータ
    static func newInstance(_ args: DetailViewParams) -> UIViewController {
        let vc = DetailViewController(args: args)
        return vc
    }

    
    /// 画面遷移パラメータ
    private var args: DetailViewParams? = nil

//    private lazy var viewImage = {
//        
//    }()

    /// この画面で基礎になるView
    private lazy var viewRoot = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// タイトル(リポジトリ名)
    private lazy var viewTitle = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(args: DetailViewParams) {
        super.init(nibName: nil, bundle: nil)
        self.args = args
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        viewTitle.text = args?.fullName
        viewRoot.addSubview(viewTitle)

        let viewScroll = UIScrollView()
        viewScroll.backgroundColor = .white
        viewScroll.translatesAutoresizingMaskIntoConstraints = false
        viewScroll.addSubview(viewRoot)
        view.addSubview(viewScroll)

        NSLayoutConstraint.activate([
            viewScroll.topAnchor.constraint(equalTo: view.topAnchor),
            viewScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),

//            viewTitle.centerXAnchor.constraint(equalTo: viewRoot.centerXAnchor),
        ])
    }
}
