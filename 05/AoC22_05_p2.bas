option explicit

Dim stacks(540) as String
Dim sp as String Ptr

sp = @stacks(0)

Declare Function pop(byref sp as String Ptr, stack as Integer) as String
Declare Function push(byref sp as String Ptr, stack as Integer, a as String) as Integer

' yeah this is awful but idgaf
push(sp, 0, "H")
push(sp, 0, "R")
push(sp, 0, "B")
push(sp, 0, "D")
push(sp, 0, "Z")
push(sp, 0, "F")
push(sp, 0, "L")
push(sp, 0, "S")

push(sp, 1, "T")
push(sp, 1, "B")
push(sp, 1, "M")
push(sp, 1, "Z")
push(sp, 1, "R")

push(sp, 2, "Z")
push(sp, 2, "L")
push(sp, 2, "C")
push(sp, 2, "H")
push(sp, 2, "N")
push(sp, 2, "S")

push(sp, 3, "S")
push(sp, 3, "C")
push(sp, 3, "F")
push(sp, 3, "J")

push(sp, 4, "P")
push(sp, 4, "G")
push(sp, 4, "H")
push(sp, 4, "W")
push(sp, 4, "R")
push(sp, 4, "Z")
push(sp, 4, "B")

push(sp, 5, "V")
push(sp, 5, "J")
push(sp, 5, "Z")
push(sp, 5, "G")
push(sp, 5, "D")
push(sp, 5, "N")
push(sp, 5, "M")
push(sp, 5, "T")

push(sp, 6, "G")
push(sp, 6, "L")
push(sp, 6, "N")
push(sp, 6, "W")
push(sp, 6, "F")
push(sp, 6, "S")
push(sp, 6, "P")
push(sp, 6, "Q")

push(sp, 7, "M")
push(sp, 7, "Z")
push(sp, 7, "R")

push(sp, 8, "M")
push(sp, 8, "C")
push(sp, 8, "L")
push(sp, 8, "G")
push(sp, 8, "V")
push(sp, 8, "R")
push(sp, 8, "T")


Sub Split(Text As String, Delim As String, Count As Long, Ret() As String)
'https://www.freebasic.net/forum/viewtopic.php?t=13975
	Dim As Long x, p
	If Count < 1 Then
		Do 
			x = InStr(x + 1, Text, Delim)
			p += 1
		Loop Until x = 0
		Count = p - 1
	ElseIf Count = 1 Then
		ReDim Ret(Count - 1)
		Ret(0) = Text
	Else
		Count -= 1
	End If
	Dim RetVal(Count) As Long
	x = 0
	p = 0
	Do Until p = Count
		x = InStr(x + 1,Text,Delim)
		RetVal(p) = x
		p += 1
	Loop
	ReDim Ret(Count)
	Ret(0) = Left(Text, RetVal(0) - 1 )
	p = 1
	Do Until p = Count
		Ret(p) = Mid(Text, RetVal(p - 1) + 1, RetVal(p) - RetVal(p - 1) - 1 )
		p += 1
	Loop
	Ret(Count) = Mid(Text, RetVal(Count - 1) + 1)
	
End Sub


Dim T as String
Dim As String s()
dim cur as String

Dim temp(60) as String

Open "input.txt" For Input As #1
If Err>0 Then 
	Print "Error accessing file"
	Sleep 
  Else 
   'Dim text as String
   While Not Eof(1)
	  Line Input #1,T
	  'text=text+T+Chr(10)
      split T, " ", 6, S()
      '1 is n crates
      '3 is source
      '5 is dest
      for i as Integer = 0 to val(S(1))-1
        temp(i) = pop(sp, val(S(3))-1)
        next
      for k as Integer = 0 to val(S(1))-1
        push(sp, val(S(5))-1, temp(val(S(1))-1-k))
        next
   Wend 
end if 
Close 1

for j as Integer = 0 to 8
    print pop(sp, j)
    next


Function pop(byref sp as String Ptr, stack as Integer) as String
    'Assume 9 stacks, each 60 long
    Dim start as Integer = 60*stack
    Dim a as String
    for i as Integer = start to start+60
        if i < 539 then
            if *(sp+i+1) = "" then
                a = *(sp+i)
                *(sp+i) = ""
                return a
            end if
        else
            a = *(sp+i)
            *(sp+i) = ""
            return a
        end if
        next
    return "none"
    End Function



Function push(byref sp as String Ptr, stack as Integer, a as String) as Integer
    Dim start as Integer = 60*stack
    for i as Integer = start to start+60
        if i < 539 then
            if *(sp+i+1) = "" then
                *(sp+i+1) = a
                return 1
            end if
        else
            *(sp+i) = a
            return 1
        end if
        next
    return 0
    End Function


