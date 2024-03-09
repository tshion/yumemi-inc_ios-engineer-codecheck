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

    /// フォーク数
    private lazy var viewForks = {
        let view = UILabel()
        view.text = "\(args.forksCount) forks"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// アバター画像
    private lazy var viewImage = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// Issue 数
    private lazy var viewIssues = {
        let view = UILabel()
        view.text = "\(args.openIssuesCount) open issues"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// プログラミング言語
    private lazy var viewLanguage = {
        let view = UILabel()
        view.text = "Written in \(args.language)"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// スター数
    private lazy var viewStars = {
        let view = UILabel()
        view.text = "\(args.stargazersCount) stars"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// タイトル(リポジトリ名)
    private lazy var viewTitle = {
        let view = UILabel()
        view.text = args.fullName
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// ウォッチ数
    private lazy var viewWatchers = {
        let view = UILabel()
        view.text = "\(args.wachersCount) watchers"
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

        view.backgroundColor = .white

        let viewScroll = UIScrollView()
        viewScroll.backgroundColor = .red // TODO
        viewScroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewScroll)

        let viewBody = UIStackView()
        viewBody.alignment = .fill
        viewBody.axis = .vertical
        viewBody.backgroundColor = .yellow // TODO
        viewBody.translatesAutoresizingMaskIntoConstraints = false
        viewScroll.addSubview(viewBody)
        
        if let avatarUrl = args.avatarUrl, let url = URL(string: avatarUrl) {
            URLSession.shared.dataTask(with: url) { (data, res, err) in
                let img = UIImage(data: data!)!
                DispatchQueue.main.async { [weak self] in
                    self?.viewImage.image = img
                }
            }.resume()
        }
        viewBody.addArrangedSubview(viewImage)
 
        viewBody.addArrangedSubview(viewTitle)

        let viewColumns = UIStackView()
        viewColumns.alignment = .top
        viewColumns.axis = .horizontal
        viewColumns.translatesAutoresizingMaskIntoConstraints = false
        viewBody.addArrangedSubview(viewColumns)

        viewColumns.addArrangedSubview(viewLanguage)

        let viewStats = UIStackView()
        viewStats.alignment = .trailing
        viewStats.axis = .vertical
        viewStats.translatesAutoresizingMaskIntoConstraints = false
        viewColumns.addArrangedSubview(viewStats)

        viewStats.addArrangedSubview(viewStars)
        viewStats.addArrangedSubview(viewWatchers)
        viewStats.addArrangedSubview(viewForks)
        viewStats.addArrangedSubview(viewIssues)

        NSLayoutConstraint.activate([
            viewScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewScroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            viewBody.topAnchor.constraint(equalTo: viewScroll.topAnchor),
            viewBody.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewBody.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewBody.bottomAnchor.constraint(equalTo: viewScroll.bottomAnchor),

            viewImage.heightAnchor.constraint(equalTo: viewImage.widthAnchor),
            viewImage.centerXAnchor.constraint(equalTo: viewBody.centerXAnchor),

            viewTitle.centerXAnchor.constraint(equalTo: viewBody.centerXAnchor),
        ])
    }
}
