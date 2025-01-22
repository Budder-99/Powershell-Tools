Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Service Desk Remote Tool Kit - Made by Owen Chandler-Budd"
$form.Size = New-Object System.Drawing.Size(600,500)  # Increased height to accommodate all buttons
$form.BackColor = [System.Drawing.Color]::FromArgb(33, 44, 65)
$form.ForeColor = [System.Drawing.Color]::White

# Create the description label
$descriptionLabel = New-Object System.Windows.Forms.Label
$descriptionLabel.Text = "ServiceDesk toolkit!"
$descriptionLabel.AutoSize = $true
$descriptionLabel.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 12)
$descriptionLabel.Location = New-Object System.Drawing.Point(10,20)
$descriptionLabel.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($descriptionLabel)

# Create the label
$label = New-Object System.Windows.Forms.Label
$label.Text = "Enter the name of the PC you need to action. Will ping machine upon name entered"
$label.AutoSize = $true
$label.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 12)
$label.Location = New-Object System.Drawing.Point(10,60)
$label.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($label)

# Adjust form width based on label width
$form.Width = [System.Math]::Max($form.Width, $label.PreferredWidth + 40)

# Create the text box
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,100)
$textBox.Size = New-Object System.Drawing.Size(($form.Width - 40),30)  # Corrected width calculation
$textBox.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 12)
$textBox.BackColor = [System.Drawing.Color]::FromArgb(33, 44, 65)
$textBox.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($textBox)

# Create the Refresh Software Centre button
$buttonRefresh = New-Object System.Windows.Forms.Button
$buttonRefresh.Text = "Refresh Software Centre"
$buttonRefresh.Location = New-Object System.Drawing.Point(10,140)
$buttonRefresh.Size = New-Object System.Drawing.Size(120,60)
$buttonRefresh.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 12)
$buttonRefresh.BackColor = [System.Drawing.Color]::FromArgb(33, 44, 65)
$buttonRefresh.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonRefresh)

# Create the Remote Reboot button
$buttonReboot = New-Object System.Windows.Forms.Button
$buttonReboot.Text = "Remote Reboot"
$buttonReboot.Location = New-Object System.Drawing.Point(10,220)
$buttonReboot.Size = New-Object System.Drawing.Size(120,60)
$buttonReboot.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 12)
$buttonReboot.BackColor = [System.Drawing.Color]::FromArgb(33, 44, 65)
$buttonReboot.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonReboot)

# Create the Ping Machine button
$buttonPing = New-Object System.Windows.Forms.Button
$buttonPing.Text = "Ping Machine"
$buttonPing.Location = New-Object System.Drawing.Point(10,300)
$buttonPing.Size = New-Object System.Drawing.Size(120,60)
$buttonPing.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 12)
$buttonPing.BackColor = [System.Drawing.Color]::FromArgb(33, 44, 65)
$buttonPing.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonPing)

# Create the Disable Smartcard Policy button
$buttonSmartcardPolicy = New-Object System.Windows.Forms.Button
$buttonSmartcardPolicy.Text = "Disable Smartcard Policy"
$buttonSmartcardPolicy.Location = New-Object System.Drawing.Point(10,380)  # Adjusted position
$buttonSmartcardPolicy.Size = New-Object System.Drawing.Size(160,60)  # Adjusted size
$buttonSmartcardPolicy.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 12)
$buttonSmartcardPolicy.BackColor = [System.Drawing.Color]::FromArgb(33, 44, 65)
$buttonSmartcardPolicy.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonSmartcardPolicy)

# Define the Refresh Software Centre button click event
$buttonRefresh.Add_Click({
    $ComputerName = $textBox.Text
    [System.Windows.Forms.MessageBox]::Show("Refresh Software Centre button clicked. Computer Name: $ComputerName", "Debug", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    if ([string]::IsNullOrEmpty($ComputerName)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a computer name.")
        return
    }

    try {
        [System.Windows.Forms.MessageBox]::Show("Starting refresh process for $ComputerName", "Debug", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        # Refresh software logic here...
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Error: Unable to connect to the specified computer. Please check the computer name and try again.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

# Define the Remote Reboot button click event
$buttonReboot.Add_Click({
    $ComputerName = $textBox.Text
    [System.Windows.Forms.MessageBox]::Show("Remote Reboot button clicked. Computer Name: $ComputerName", "Debug", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    
    if ([string]::IsNullOrEmpty($ComputerName)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a computer name.")
        return
    }

    try {
        [System.Windows.Forms.MessageBox]::Show("This PC is being restarted.", "Warning", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        # Restart logic here...
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Error: Unable to restart the specified computer. Please check the computer name and try again.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

# Define the Ping Machine button click event
$buttonPing.Add_Click({
    $ComputerName = $textBox.Text
    [System.Windows.Forms.MessageBox]::Show("Ping Machine button clicked. Computer Name: $ComputerName", "Debug", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    
    if ([string]::IsNullOrEmpty($ComputerName)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a computer name.")
        return
    }

    # Ping machine logic
    try {
        # Test connection (ping) to the machine
        $pingResult = Test-Connection -ComputerName $ComputerName -Count 1 -Quiet
        
        # Show the result in a message box
        if ($pingResult) {
            [System.Windows.Forms.MessageBox]::Show("The machine $ComputerName is reachable.", "Ping Result", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        } else {
            [System.Windows.Forms.MessageBox]::Show("The machine $ComputerName is not reachable.", "Ping Result", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Error: Unable to ping the specified computer. Please check the computer name and try again.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

# Define the Disable Smartcard Policy button click event
$buttonSmartcardPolicy.Add_Click({
    $ComputerName = $textBox.Text
    if ([string]::IsNullOrEmpty($ComputerName)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a computer name.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    # Define the script block to disable the smartcard policy
    $ScriptBlock = {
        Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name scforceoption -Value 0
        $newValue = Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name scforceoption
        Write-Warning "Smartcard policy set to OFF for the duration of this window being open. Please reset it later."
    }

    try {
        # Invoke the script block on the remote computer
        Invoke-Command -ComputerName $ComputerName -ScriptBlock $ScriptBlock -ErrorAction Stop

        # Notify the user that the smartcard policy has been disabled
        [System.Windows.Forms.MessageBox]::Show("Smartcard policy disabled on $ComputerName.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

        # Ask user if they want to re-enable the policy
        $confirmation = [System.Windows.Forms.MessageBox]::Show("Are you ready to re-enable the Smartcard policy? Click Yes to re-enable or No to leave it disabled.", "Confirm Re-enable", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
        if ($confirmation -eq [System.Windows.Forms.DialogResult]::Yes) {
            # Re-enable the smartcard policy
            $ReenableScriptBlock = {
                Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name scforceoption -Value 1
            }
            Invoke-Command -ComputerName $ComputerName -ScriptBlock $ReenableScriptBlock -ErrorAction Stop
            [System.Windows.Forms.MessageBox]::Show("Smartcard policy re-enabled on $ComputerName.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        }
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Error: Unable to modify the smartcard policy on the specified computer. Please check the computer name and try again.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

# Event for Enter key to trigger ping when the user presses it
$textBox.Add_KeyDown({
    param($sender, $e)
    if ($e.KeyCode -eq [System.Windows.Forms.Keys]::Enter) {
        $ComputerName = $textBox.Text
        if (![string]::IsNullOrEmpty($ComputerName)) {
            try {
                # Test connection (ping) to the machine
                $pingResult = Test-Connection -ComputerName $ComputerName -Count 1 -Quiet
                # Show the result in a message box
                if ($pingResult) {
                    [System.Windows.Forms.MessageBox]::Show("The machine $ComputerName is reachable.", "Ping Result", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
                } else {
                    [System.Windows.Forms.MessageBox]::Show("The machine $ComputerName is not reachable.", "Ping Result", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
                }
            } catch {
                [System.Windows.Forms.MessageBox]::Show("Error: Unable to ping the specified computer. Please check the computer name and try again.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            }
        }
    }
})

# Show the form
$form.ShowDialog()
