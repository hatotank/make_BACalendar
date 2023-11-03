$color = "Yellow"

# 01 Download_Halo.ps1(HALO画像をダウンロード)
Write-Host "exec Download_Halo.ps1" -ForegroundColor $color
. .\Download_Halo.ps1
Write-Host ""

# 02 Download_Icon.ps1(ICON画像をダウンロード)
Write-Host "exec Download_Icon.ps1" -ForegroundColor $color
. .\Download_Icon.ps1
Write-Host ""

# 03 Download_etc.ps1(その他画像をダウンロード)
Write-Host "exec Download_etc.ps1" -ForegroundColor $color
. .\Download_etc.ps1
Write-Host ""

# 04 Resize_Halo.ps1(HALO画像をリサイズ)
Write-Host "exec Resize_Halo.ps1" -ForegroundColor $color
. .\Resize_Halo.ps1
Write-Host ""

# 05 Resize_Icon.ps1(ICON画像をリサイズ)
Write-Host "exec Resize_Icon.ps1" -ForegroundColor $color
. .\Resize_Icon.ps1
Write-Host ""

# 06 Other_Processing.ps1(その他画像処理(S.C.H.A.L.Eアイコンの加工))
Write-Host "exec Other_Processing1.ps1" -ForegroundColor $color
. .\Other_Processing1.ps1
Write-Host ""

# 07 Other_Processing2.ps1(Googleが提供する日本の祝日にカテゴリを追加(iCalendar))
Write-Host "exec Other_Processing2.ps1" -ForegroundColor $color
. .\Other_Processing2.ps1
Write-Host ""

# 08 MakeSchedule_JapaneseSaturdayBlue.ps1(日本向け土曜日を青色にするカテゴリ作成(iCalendar))
Write-Host "exec MakeSchedule_JapaneseSaturdayBlue.ps1" -ForegroundColor $color
. .\MakeSchedule_JapaneseSaturdayBlue.ps1
Write-Host ""

# 09 MakeSchedule_BlueArchiveBirthday.ps1(生徒毎の誕生日カテゴリ作成(iCalendar))
Write-Host "exec MakeSchedule_BlueArchiveBirthday.ps1" -ForegroundColor $color
. .\MakeSchedule_BlueArchiveBirthday.ps1
Write-Host ""

# 10 MakeXmlCategory.ps1(生徒毎の誕生日カテゴリ作成(XML))
Write-Host "exec MakeXmlCategory.ps1" -ForegroundColor $color
. .\MakeXmlCategory.ps1
Write-Host ""
