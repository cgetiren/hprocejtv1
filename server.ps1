$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://localhost:8000/')
$listener.Start()
Write-Host 'Server started at http://localhost:8000/' -ForegroundColor Green

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    
    $localPath = $request.Url.LocalPath
    if ($localPath -eq '/') {
        $localPath = '/quiz.html'
    }
    
    $fileName = Join-Path (Get-Location) $localPath.TrimStart('/')
    
    if (Test-Path $fileName) {
        $content = Get-Content $fileName -Raw -Encoding UTF8
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($content)
        $response.ContentLength64 = $buffer.Length
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
    } else {
        $response.StatusCode = 404
        $notFoundBytes = [System.Text.Encoding]::UTF8.GetBytes("404 - File not found")
        $response.ContentLength64 = $notFoundBytes.Length
        $response.OutputStream.Write($notFoundBytes, 0, $notFoundBytes.Length)
    }
    
    $response.Close()
}