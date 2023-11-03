# その他画像をダウンロード
$INPUT_FILE = $PWD.Path + "\csv\etc.csv"
$OUTPUT_DIR = $PWD.Path + "\temp\etc\"
$objcsv = @(Import-Csv $INPUT_FILE)

$i = 1
$max = $objcsv.count

Write-Host "start downLoad"
foreach($csv in $objcsv)
{
    Write-Host "[" $i "/" $max "]" $csv.Name
    $extention = [System.IO.Path]::GetExtension($csv.URL)
    if($csv.UsageType -eq 1)
    {
        $outputfile = $OUTPUT_DIR + "ICON_" + $csv.Name + $extention
    }
    else
    {
        $outputfile = $OUTPUT_DIR + $csv.Name + $extention
    }
    Invoke-WebRequest -Uri $csv.URL -OutFile $outputfile
    $i++
}
Write-Host "end downLoad"
