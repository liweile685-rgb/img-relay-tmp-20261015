Add-Type -AssemblyName System.Drawing
$dir = "f:\Obsidian-Trae\Trae_Lab_Exemption\img_fusion_tmp"
foreach ($n in @('base','ref_E','ref_C')) {
  $img = [System.Drawing.Image]::FromFile("$dir\$n.png")
  $w = $img.Width
  if ($w -gt 1600) { $w = 1600 }
  $h = [int]($img.Height * $w / $img.Width)
  $bmp = New-Object System.Drawing.Bitmap($w, $h)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode = 'HighQualityBicubic'
  $g.DrawImage($img, 0, 0, $w, $h)
  $enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
  $ep = New-Object System.Drawing.Imaging.EncoderParameters(1)
  $ep.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]90)
  $bmp.Save("$dir\$n.jpg", $enc, $ep)
  $g.Dispose(); $bmp.Dispose(); $img.Dispose()
}
Get-ChildItem "$dir\*.jpg" | Select-Object Name, Length
