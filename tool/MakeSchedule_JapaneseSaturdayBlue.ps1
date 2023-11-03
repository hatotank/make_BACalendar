# 日本向け土曜日を青色にするカテゴリ作成
$OUTPUT_FILENAME = "JapaneseSaturdayBlue.ics"
$OUTPUT_FILE = $PWD.Path + "\BACalendar\ics\" + $OUTPUT_FILENAME
$CRLF = "`r`n"
$PRODID = "hatotank/BACalendar v1.0"
$START_DAY = (Get-Date "2023/01/01")
$END_DAY   = (Get-Date "2030/12/31")

$day = $START_DAY

Write-Host "start make" $OUTPUT_FILENAME
$body  = "BEGIN:VCALENDAR" + $CRLF
$body += "PRODID:-//" + $PRODID + "//EN" + $CRLF
$body += "VERSION:2.0" + $CRLF
$body += "METHOD:PUBLISH" + $CRLF

while($day.CompareTo($END_DAY) -le 0)
{
    if($day.DayOfWeek -eq "Saturday")
    {
        $body += "BEGIN:VEVENT" + $CRLF
        $body += "DTSTAMP:" + (Get-Date).ToString("yyyyMMddThhmmssZ") + $CRLF
        $body += "TRANSP:TRANSPARENT" + $CRLF
        $body += "UID:" + (New-Guid).ToString() + $CRLF
        $body += "SUMMARY:*Japanese_Saturday_Blue" + $CRLF
        $body += "CATEGORIES:Japanese_Saturday_Blue" + $CRLF
        $body += "LAST-MODIFIED:" + (Get-Date).ToString("yyyyMMddThhmmssZ") + $CRLF
        $body += "DTSTART;VALUE=DATE:" + ($day).ToString("yyyyMMdd") + $CRLF
        $body += "DTEND;VALUE=DATE:" + ($day).AddDays(1).ToString("yyyyMMdd") + $CRLF
        $body += "END:VEVENT" + $CRLF
    }
    $day = $day.AddDays(1)
}
$body += "END:VCALENDAR" + $CRLF

$body | ForEach-Object{ $_+"`n" } | ForEach-Object{ [Text.Encoding]::UTF8.GetBytes($_) } | Set-Content -Encoding Byte -Path $OUTPUT_FILE

Write-Host "end make" $OUTPUT_FILENAME
