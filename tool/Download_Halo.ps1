# HALO画像をダウンロード
$INPUT_FILE = $PWD.Path + "\csv\halo-icon.csv"
$OUTPUT_DIR = $PWD.Path + "\temp\halo\"
$objcsv = Import-Csv $INPUT_FILE

$i = 1
$max = $objcsv.count

Write-Host "start downLoad"
foreach($csv in $objcsv)
{
    Write-Host "[" $i "/" $max "]" $csv.FullNameJP "(" $csv.LastName $csv.FirstName ")"
    $extention = [System.IO.Path]::GetExtension($csv.HaloImageURL).Split('?')[0]
    $outputfile = $OUTPUT_DIR + "HALO_" + $csv.LastName + "_" + $csv.FirstName + $extention
    Invoke-WebRequest -Uri $csv.HaloImageURL -OutFile $outputfile
    $i++
}
Write-Host "end downLoad"
