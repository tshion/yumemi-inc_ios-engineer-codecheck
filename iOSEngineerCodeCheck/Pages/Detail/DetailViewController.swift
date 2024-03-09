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
    private let args: DetailViewParams

    /// 画面表示のメイン部分
    private lazy var viewBody = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// アバター画像
    private lazy var viewImage = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// タイトル(リポジトリ名)
    private lazy var viewTitle = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    init(args: DetailViewParams) {
        self.args = args
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Always initialize DetailViewController using init(args:)")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let avatarUrl = args.avatarUrl, let url = URL(string: avatarUrl) {
            URLSession.shared.dataTask(with: url) { (data, res, err) in
                let img = UIImage(data: data!)!
                DispatchQueue.main.async { [weak self] in
                    self?.viewImage.image = img
                }
            }.resume()
        }
        viewBody.addSubview(viewImage)

        let viewScroll = UIScrollView()
        viewScroll.backgroundColor = .red
        viewScroll.translatesAutoresizingMaskIntoConstraints = false
        viewScroll.addSubview(viewBody)

        view.backgroundColor = .white
        view.addSubview(viewScroll)

        NSLayoutConstraint.activate([
            viewScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            viewBody.centerXAnchor.constraint(equalTo: viewScroll.centerXAnchor),

            viewImage.heightAnchor.constraint(equalTo: viewImage.widthAnchor),
            viewImage.centerXAnchor.constraint(equalTo: viewBody.centerXAnchor),
        ])
    }
}
