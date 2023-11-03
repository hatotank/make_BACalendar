# その他画像処理(S.C.H.A.L.Eアイコンの加工)
Add-Type -AssemblyName System.Drawing
$INPUT_DIR = $PWD.Path + "\temp\etc\ICON_SCHALE.png"
$OUTPUT_DIR = $PWD.Path + "\BACalendar\images\"
$WIDTH = [int]24
$HEIGHT = [int]24

Write-Host "start processing"
$saturation = [float]0.0
$img_src = New-Object System.Drawing.Bitmap($INPUT_DIR)
$rect = New-Object System.Drawing.Rectangle(46,10,598,602)
# トリミング
$img_src = $img_src.Clone($rect, $img_src.PixelFormat)
$img_dst = New-Object System.Drawing.Bitmap($WIDTH,$HEIGHT)

$graphics = [System.Drawing.Graphics]::FromImage($img_dst)
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.DrawImage($img_src, (New-Object System.Drawing.Rectangle(0, 0, $WIDTH, $HEIGHT)),0,0,$img_src.Width,$img_src.Height,[System.Drawing.GraphicsUnit]::Pixel,$ia)

# References 彩度を変更して画像を表示する
# https://dobon.net/vb/dotnet/graphics/saturation.html
$cm = New-Object System.Drawing.Imaging.ColorMatrix
$rwgt = [float]0.3086;
$gwgt = [float]0.6094;
$bwgt = [float]0.0820;
$cm.Matrix01 = $cm.Matrix02 = ([float]1 - $saturation) * $rwgt;
$cm.Matrix00 = $cm.Matrix01 + $saturation;
$cm.Matrix10 = $cm.Matrix12 = ([float]1 - $saturation) * $gwgt;
$cm.Matrix11 = $cm.Matrix10 + $saturation;
$cm.Matrix20 = $cm.Matrix21 = ([float]1 - $saturation) * $bwgt;
$cm.Matrix22 = $cm.Matrix20 + $saturation;
$cm.Matrix33 = $cm.Matrix44 = [float]1;
$ia = New-Object System.Drawing.Imaging.ImageAttributes
$ia.SetColorMatrix($cm)

$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.DrawImage($img_src, (New-Object System.Drawing.Rectangle(0, 0, $WIDTH, $HEIGHT)),0,0,$img_src.Width,$img_src.Height,[System.Drawing.GraphicsUnit]::Pixel,$ia)
$img_dst.Save(($OUTPUT_DIR + "today-black.png"), [System.Drawing.Imaging.ImageFormat]::Png)

# References 明るさを変更して画像を表示する
# https://dobon.net/vb/dotnet/graphics/brightness.html
[float[][]]$colorMatrixElements = 
    @(
        (1,0,0,0,0),
        (0,1,0,0,0),
        (0,0,1,0,0),
        (0,0,0,1,0),
        (1,1,1,0,1)
    )
$ia.SetColorMatrix($colorMatrixElements)

$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.DrawImage($img_src, (New-Object System.Drawing.Rectangle(0, 0, $WIDTH, $HEIGHT)),0,0,$img_src.Width,$img_src.Height,[System.Drawing.GraphicsUnit]::Pixel,$ia)
$img_dst.Save(($OUTPUT_DIR + "today-white.png"), [System.Drawing.Imaging.ImageFormat]::Png)

Write-Host "end processing"
