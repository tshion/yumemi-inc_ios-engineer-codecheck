/// 詳細画面の遷移パラメータ
struct DetailViewParams {

    /// データの変換
    static func parse(_ item: [String: Any]) -> DetailViewParams {
        let owner = item["owner"] as? [String: Any]
        return DetailViewParams(
            avatarUrl: owner?["avatar_url"] as? String,
            forksCount: item["forks_count"] as? Int ?? 0,
            fullName: item["full_name"] as? String,
            language: item["language"] as? String ?? "",
            openIssuesCount: item["open_issues_count"] as? Int ?? 0,
            stargazersCount: item["stargazers_count"] as? Int ?? 0,
            wachersCount: item["wachers_count"] as? Int ?? 0
        )
    }


    /// アバター画像のURL
    let avatarUrl: String?
    
    /// フォーク数
    let forksCount: Int

    /// 表示名
    let fullName: String?

    /// プログラミング言語
    let language: String

    /// 公開中のIssue の数
    let openIssuesCount: Int

    /// スター数
    let stargazersCount: Int

    /// ウォッチャー数
    let wachersCount: Int
}
