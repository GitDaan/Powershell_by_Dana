function Make-Choice {
$title = "Make A Choice"
$message = "Do you like Yes, No, or need some help"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&[Y]es", `
    "Deletes all the files in the folder."

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&[N]o", `
    "Retains all the files in the folder."

$Help = New-Object System.Management.Automation.Host.ChoiceDescription "&[?]Help", `
    "Get Help about the choices."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no, $Help)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($result)
    {
        0 {"You selected Yes."}
        1 {"You selected No."}
        2 {"You selected Help."}
    }
}