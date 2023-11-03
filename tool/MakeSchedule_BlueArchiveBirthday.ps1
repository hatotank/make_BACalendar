# 生徒毎の誕生日カテゴリ作成(iCalendar)
$INPUT_FILE = $PWD.Path + "\csv\halo-icon.csv"
$OUTPUT_FILENAME = "BlueArchiveBirthday.ics"
$OUTPUT_FILE = $PWD.Path + "\BACalendar\ics\" + $OUTPUT_FILENAME
$CRLF = "`r`n"
$PRODID = "hatotank/BACalendar v1.0"
$START_DAY = (Get-Date "2023/01/01") # XXXX/01/01 - XXXX/12/31
$END_DAY   = $START_DAY.AddYears(1).AddDays(-1)

$day = $START_DAY
$objcsv = Import-Csv $INPUT_FILE | Sort-Object "Birthday"

Write-Host "start make" $OUTPUT_FILENAME
$body  = "BEGIN:VCALENDAR" + $CRLF
$body += "PRODID:-//" + $PRODID + "//EN" + $CRLF
$body += "VERSION:2.0" + $CRLF
$body += "METHOD:PUBLISH" + $CRLF

while($day.CompareTo($END_DAY) -le 0)
{
    $lists = $objcsv | Where-Object { $_.Birthday -eq ($day).ToString("MMdd") }
    foreach($list in $lists)
    {
        $body += "BEGIN:VEVENT" + $CRLF
        $body += "DTSTAMP:" + (Get-Date).ToString("yyyyMMddThhmmssZ") + $CRLF
        $body += "TRANSP:OPAQUE" + $CRLF
        $body += "UID:" + (New-Guid).ToString() + $CRLF
        $body += "SUMMARY:" + $list.LastName + " " + $list.FirstName + $CRLF
        $body += "CATEGORIES:" + $list.LastName + " " + $list.FirstName + $CRLF
        $body += "LAST-MODIFIED:" + (Get-Date).ToString("yyyyMMddThhmmssZ") + $CRLF
        $body += "RRULE:FREQ=YEARLY;BYMONTHDAY=" + ($day).ToString("%d") + ";BYMONTH=" + ($day).ToString("%M") + $CRLF
        $body += "DTSTART;VALUE=DATE:" + ($day).ToString("yyyyMMdd") + $CRLF
        $body += "DTEND;VALUE=DATE:" + ($day).AddDays(1).ToString("yyyyMMdd") + $CRLF
        $body += "END:VEVENT" + $CRLF
    }
    $day = $day.AddDays(1)
}
$body += "END:VCALENDAR" + $CRLF

$body | ForEach-Object{ $_+"`n" } | ForEach-Object{ [Text.Encoding]::UTF8.GetBytes($_) } | Set-Content -Encoding Byte -Path $OUTPUT_FILE

Write-Host "end make" $OUTPUT_FILENAME
