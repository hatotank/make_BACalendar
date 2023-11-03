# ICON画像をリサイズ
Add-Type -AssemblyName System.Drawing
$INPUT_DIR = $PWD.Path + "\temp\icon\"
$OUTPUT_DIR = $PWD.Path + "\BACalendar\images\icons\"
$WIDTH = [int]32
$HEIGHT = [int]32
$objitems = Get-ChildItem $INPUT_DIR -File *.png

$i = 1
$max = $objitems.count

Write-Host "start resize"
foreach ($item in $objitems)
{
    Write-Host "[" $i "/" $max "]" $item.Name "->" $item.Name.Replace("_","-").ToLower()
    $img_src = New-Object System.Drawing.Bitmap($item.FullName)
    $img_dst = New-Object System.Drawing.Bitmap($WIDTH, $HEIGHT)
    $graphics = [System.Drawing.Graphics]::FromImage($img_dst)
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.DrawImage($img_src, (New-Object System.Drawing.Rectangle(0, 0, $img_dst.Width, $img_dst.Height)))
    $img_dst.Save(($OUTPUT_DIR + $item.Name.Replace("_","-").ToLower()), [System.Drawing.Imaging.ImageFormat]::Png)
    $i++
}
Write-Host "end resize"
