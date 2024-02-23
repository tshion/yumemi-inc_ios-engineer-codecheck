#!/usr/bin/env ruby

# アプリバージョン文字列の抽出
#
# 注意事項
# * ".ruby-version" に記載されているバージョンで実行してください


require 'pathname'


# 作業対象ファイルの設定と検証
PATH = Pathname.new(__dir__).join("../Build.xcconfig")
unless FileTest.exist?(PATH) then
    puts("#{PATH} にファイルが存在しません")
    exit 1
end


# ファイル読み込み
text = ""
File.open(PATH, "r") { |file|
    text = file.read
}


# アプリバージョン文字列の抽出
VERSION_NAME = text.scan(/^APP_VERSION_NAME = (\d[\d\.]{0,}\d)$/)

# 終了表示
puts(VERSION_NAME)
