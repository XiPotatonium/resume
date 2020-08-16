function Build-Pdf {
    param ($src)

    if (!(Test-Path $src)) {
        Write-Output "File $src not exists"
        return
    }

    $srcFile = Get-Item $src
    $targetName = $srcFile.BaseName + ".pdf"

    if (!(Test-Path $targetName)) {
        xelatex.exe $src
    } else {
        $targetFile = Get-Item $targetName
        if ($targetFile.LastWriteTime -lt $srcFile.LastWriteTime) {
            xelatex.exe $src
        } else {
            Write-Output "File $targetName is already up-to-date"
        }
    }
}

Build-Pdf resume.tex
Build-Pdf resume-cn.tex

Remove-Item *.aux
Remove-Item *.log
Remove-Item *.out