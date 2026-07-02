Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Network Adapter Reset"
$form.Size = New-Object System.Drawing.Size(420, 180)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "Select a network adapter (confirm with IT if unsure):"
$label.Location = New-Object System.Drawing.Point(20, 20)
$label.AutoSize = $true

$combo = New-Object System.Windows.Forms.ComboBox
$combo.Location = New-Object System.Drawing.Point(20, 45)
$combo.Size = New-Object System.Drawing.Size(360, 25)
$combo.DropDownStyle = "DropDownList"

$status = New-Object System.Windows.Forms.Label
$status.Location = New-Object System.Drawing.Point(20, 115)
$status.Size = New-Object System.Drawing.Size(360, 25)
$status.AutoSize = $false

$button = New-Object System.Windows.Forms.Button
$button.Text = "Restart"
$button.Location = New-Object System.Drawing.Point(20, 80)
$button.Size = New-Object System.Drawing.Size(100, 28)

$adapters = Get-NetAdapter
foreach ($adapter in $adapters) {
    [void]$combo.Items.Add($adapter.Name)
}

if ($combo.Items.Count -gt 0) {
    $combo.SelectedIndex = 0
}

$button.Add_Click({
    if ($combo.SelectedItem) {
        $name = $combo.SelectedItem.ToString()
        try {
            Restart-NetAdapter -Name $name -Confirm:$false -ErrorAction Stop
            $status.Text = "Network adapter '$name' restarted. Please check if online."
        }
        catch {
            $status.Text = "Error restarting '$name': $($_.Exception.Message)"
        }
    }
})

$form.Controls.AddRange(@($label, $combo, $button, $status))
[void]$form.ShowDialog()
