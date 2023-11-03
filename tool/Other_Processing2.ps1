# Googleが提供する日本の祝日にカテゴリを追加
$INPUT_FILE = $PWD.Path + "\temp\etc\basic.ics"
$OUTPUT_FILE = $PWD.Path + "\BACalendar\ics\JapaneseHolidays.ics"
$CRLF = "`r`n"

$lines = Get-Content $INPUT_FILE -Encoding UTF8
$body = ""

Write-Host "start processing"
foreach($line in $lines)
{
    $body += $line + $CRLF
    if($line.Contains("SUMMARY"))
    {
        $body += "CATEGORIES:Japanese_Holidays" + $CRLF
    }
}
$body | ForEach-Object{ $_+"`n" } | ForEach-Object{ [Text.Encoding]::UTF8.GetBytes($_) } | Set-Content -Encoding Byte -Path $OUTPUT_FILE
Write-Host "end processing"
