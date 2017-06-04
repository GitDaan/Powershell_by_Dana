      <# Precedence of commands: #>
# Alias > Function > Filter > Cmdlet > Application > ExternalScript > Script

# PowerShell looks at the first non-whitespace character of a line to determine which mode to start parsing in.
# If it sees [_aA-zZ] or & or . or \ then PowerShell parses in Command mode.

'C:\Program Files\Windows NT\Accessories\wordpad.exe'    #Outputs a string (Expression mode)
& 'C:\Program Files\Windows NT\Accessories\wordpad.exe'  #Starts the program (Command mode)
# Except if first non-whitespace is a keyword, then it runs in expression mode and waits on rest of command structure.

#Strings do not need to be inside quotes unless there are spaces
C:\Windows\system32\notepad.exe
& 'C:\Program Files' #the & and quotes were added by Powershell. Exercise - Just type in C:\Program Fi...

# Numbers are parsed as numbers unless inside strings. Numbers are assigned Int32, Int64, Double, or Decimal depending on decoration
 $Large = 123456789000000000
 $Large.GetType()              #Int64

 $Larger = 2.8637e+010
 $Larger.GetType()             #Double
 

 $Curr = (4.10).ToString('c')
 $Curr.GetType()                #String (but it is actually currency)
 $Curr                          # $4.10 

 $Small = 10
 $Small.GetType()              #Int32

 $Dec = 100.01d
 $Dec.GetType()                #Decimal

#Everything else is a string except @, $, (, `, or " '

# To execute an EXE or script whose name starts with a number you have to quote the name and use the call operator
& '64E1'
# however you do not need quotes for 
64E1.exe
64E1.ps1

#Expressions with ()
$S = (Get-Process)                 # only one statement
$S = $(Get-service; Start-service) #multiple statements
$S = @(123,456,789)                #Output is an array
$S[0]

### Array subexpressions do not wrap arrays inside of another array.

(Get-ChildItem C:\Windows).Length         #131
10 + (Get-ChildItem C:\Windows).Length    #141 - The power of parsing modes. It switched from expression to command

# & runs in child scope and is thrown away when command finishes
# . executes in the current scope