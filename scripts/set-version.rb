#!/usr/bin/env ruby

# 注意事項
# * 前提: プロジェクトルートで実行すること


# 作業対象のパス設定
PATH = "#{Dir.pwd}/Build.xcconfig"


# コマンドライン引数の検証
unless ARGV.length == 3 then
    puts("引数を３つ指定してください")
    exit
end

MAJOR = ARGV[0]
unless /^\d+$/.match?(MAJOR) then
    puts("major には正整数を指定してください")
    exit
end

MINOR = ARGV[1]
unless /^\d{1,2}$/.match?(MINOR) then
    puts("minor には1 ~ 2桁の正整数を指定してください")
    exit
end

PATCH = ARGV[2]
unless /^\d{1,2}$/.match?(PATCH) then
    puts("patch には1 ~ 2桁の正整数を指定してください")
    exit
end


# バージョン情報の算出
VERSION_CODE = MAJOR.to_i * 10000 + MINOR.to_i * 100 + PATCH.to_i
VERSION_NAME = "#{MAJOR}.#{MINOR}.#{PATCH}"


# ファイル出力
text = ""
File.open(PATH, "r") { |file|
    text = file.read
}
text = text.gsub(/^(APP_VERSION_CODE = )(\d+)$/) { "#{$1}#{VERSION_CODE}" }
text = text.gsub(/^(APP_VERSION_NAME = )(\d[\d\.]{0,}\d)$/) { "#{$1}#{VERSION_NAME}" }
File.open(PATH, "w") { |file|
    file.write(text)
}


# 終了表示
puts("Set code: #{VERSION_CODE}, name: #{VERSION_NAME}")
