# ========================================
# Alarm Suara Monitoring battery Laptop
# by: Arif Johar Taufiq (arifjt@gmail.com)
# ytube: www.youtube.com/@ArifJTaufiq
# =======================================
$Threshold = 35    # Persentase baterai minimum (dalam %)
$CheckInterval = 30 # Interval pengecekan dalam detik

# Loop pemantauan
while ($true) {
    # Mendapatkan informasi baterai
    $BatteryStatus = Get-CimInstance -Namespace root/WMI -ClassName BatteryStatus
    $FullCapacity = (Get-CimInstance -Namespace root/WMI -ClassName BatteryFullChargedCapacity).FullChargedCapacity

    # Menghitung persentase baterai
    if ($FullCapacity -ne 0) {
        $Percent = [math]::Round(($BatteryStatus.RemainingCapacity / $FullCapacity) * 100)
    } else {
        $Percent = 0  # Default jika tidak terdeteksi
    }

    Write-Host "Level baterai saat ini: $Percent%"

    # Memeriksa apakah baterai di bawah ambang batas
    if ($Percent -lt $Threshold) {
        Write-Host "Peringatan: Baterai rendah ($Percent%)! Memutar alarm..."
        # Alarm suara menggunakan text-to-speech bawaan Windows
        $voice = New-Object -ComObject SAPI.SpVoice
        $voice.Speak("BUT THE RAY HAM PEAR HA BISH SEGERA CHARGE")
    }

    # Tunggu sebelum memeriksa lagi
    Start-Sleep -Seconds $CheckInterval
}
