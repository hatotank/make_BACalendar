# ICON画像をダウンロード
$INPUT_FILE = $PWD.Path + "\csv\halo-icon.csv"
$OUTPUT_DIR = $PWD.Path + "\temp\icon\"
$objcsv = Import-Csv $INPUT_FILE

$i = 1
$max = $objcsv.count

Write-Host "start downLoad"
foreach($csv in $objcsv)
{
    Write-Host "[" $i "/" $max "]" $csv.FullNameJP "(" $csv.LastName $csv.FirstName ")"
    $extention = [System.IO.Path]::GetExtension($csv.IconImageURL).Split('?')[0]
    $outputfile = $OUTPUT_DIR + "ICON_" + $csv.LastName + "_" + $csv.FirstName + $extention
    Invoke-WebRequest -Uri $csv.IconImageURL -OutFile $outputfile
    $i++
}
Write-Host "end downLoad"
