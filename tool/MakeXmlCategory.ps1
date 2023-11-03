# 生徒毎の誕生日カテゴリ作成(XML)
using namespace System.Xml
$INPUT_FILE = $PWD.Path + "\csv\halo-icon.csv"
$OUTPUT_FILENAME = "category.xml"
$OUTPUT_FILE = $PWD.Path + "\BACalendar\xml\" + $OUTPUT_FILENAME

$objcsv = Import-Csv $INPUT_FILE 
[xml]$doc = [XmlDocument]::new()

Write-Host "start make" $OUTPUT_FILENAME

#<?xml version="1.0" encoding="UTF-8"?>
$dec = $doc.CreateXmlDeclaration("1.0", "UTF-8", $null)
$doc.AppendChild($dec) | Out-Null

#<skin version="1.0">
$skin = $doc.CreateNode("element", "skin", "")
$skin.SetAttribute("version", "1.0")
$doc.AppendChild($skin)| Out-Null

#skin:<elements>
$elements = $doc.CreateNode("element", "elements", "")
$skin.AppendChild($elements)| Out-Null

#skin:elements:<bitmap id="bitmap.icon.halo.xxx" file="images/icon/halo-xxx.png">
#skin:elements:<bitmap id="bitmap.icon.icon.xxx" file="images/icon/icon-xxx.png">
foreach($csv in $objcsv)
{
    $bitmap = $doc.CreateNode("element", "bitmap", "")
    $bitmap.SetAttribute("id", "bitmap.icon.halo." + $csv.LastName.ToLower() + "-" + $csv.FirstName.ToLower())
    $bitmap.SetAttribute("file", "images/icons/halo-" + $csv.LastName.ToLower() + "-" + $csv.FirstName.ToLower() + ".png")
    $elements.AppendChild($bitmap) | Out-Null

    $bitmap = $doc.CreateNode("element", "bitmap", "")
    $bitmap.SetAttribute("id", "bitmap.icon." + $csv.LastName.ToLower() + "-" + $csv.FirstName.ToLower())
    $bitmap.SetAttribute("file", "images/icons/icon-" + $csv.LastName.ToLower() + "-" + $csv.FirstName.ToLower() + ".png")
    $elements.AppendChild($bitmap) | Out-Null
}

#skin:<categories>
$categories = $doc.CreateNode("element", "categories", "")
$skin.AppendChild($categories)| Out-Null

#skin:categories:*
foreach($csv in $objcsv)
{
    # skin:categories:<category id="xxx">
    $category = $doc.CreateNode("element", "category", "")
    $category.SetAttribute("id", $csv.LastName + " " + $csv.FirstName)
    $categories.AppendChild($category) | Out-Null

    # skin:categories:category:<appearance target="x" layer="x" priority="x" element="bitmap.icon.halo.xxx" align="x" showalways="x" offset="x">
    $appearance = $doc.CreateNode("element", "appearance", "")
    $appearance.SetAttribute("target", "1")
    $appearance.SetAttribute("layer", "5")
    $appearance.SetAttribute("priority", "1")
    $appearance.SetAttribute("element", "bitmap.icon.halo." + $csv.LastName.ToLower() + "-" + $csv.FirstName.ToLower())
    $appearance.SetAttribute("align", "BOTTOM-CENTER")
    $appearance.SetAttribute("showalways", "1")
    $appearance.SetAttribute("offset", "0,18")
    $category.AppendChild($appearance) | Out-Null

    # skin:categories:category:<appearance target="x" layer="x" priority="x" element="bitmap.icon.xxx" align="x" showalways="x" offset="x">
    $appearance = $doc.CreateNode("element", "appearance", "")
    $appearance.SetAttribute("target", "30")
    $appearance.SetAttribute("layer", "0")
    $appearance.SetAttribute("priority", "1")
    $appearance.SetAttribute("element", "bitmap.icon." + $csv.LastName.ToLower() + "-" + $csv.FirstName.ToLower())
    $appearance.SetAttribute("align", "TOP")
    $appearance.SetAttribute("showalways", "1")
    $appearance.SetAttribute("offset", "0,-8")
    $category.AppendChild($appearance) | Out-Null

    # skin:categories:category:<appearance target="x" layer="x" element="bitmap.event.bg" align="x" offset="x">
    $appearance = $doc.CreateNode("element", "appearance", "")
    $appearance.SetAttribute("target", "1")
    $appearance.SetAttribute("layer", "-1")
    $appearance.SetAttribute("element", "bitmap.event.bg")
    $appearance.SetAttribute("offset", "0,-2")
    $category.AppendChild($appearance) | Out-Null
}

$doc.Save($OUTPUT_FILE) | Out-Null

Write-Host "end make" $OUTPUT_FILENAME