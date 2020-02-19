Sub CreateSQLstatements()

    ' find the edge of the column
    Edge = 0
    For Col = 1 To 100
        If Cells(1, Col) = "" And Edge = 0 Then
            Edge = Col
        End If
    Next Col
    
    ' cycle through each row
    Row = 2
    Do While Cells(Row, 1) <> ""
    
        Fields = ""
        Values = ""
        
        For Col = 1 To Edge - 1
            Head = Cells(1, Col)
            Data = Cells(Row, Col)
            
            Fields = Fields & Head & ","
            Values = Values & "'" & Data & "',"
        Next Col
        
        Sql = Replace("INSERT INTO policy (" & Fields & ") VALUES (" & Values & ");", ",)", ")")
        
        
        Cells(Row, Edge) = Sql
        
        Row = Row + 1
    Loop
    MsgBox (Row & " rows")

End Sub
