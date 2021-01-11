Sub Upload(strTable, strServer, strDatabase)
    
    ' == connect to the database
    Set Conn = CreateObject("ADODB.connection")
    Conn.ConnectionTimeout = 30
    Conn.CommandTimeout = 30

    Conn.Open ("Driver={SQL Server};Server=" & strServer & ";Database=" & strDatabase)
    Conn.CommandTimeout = 3600

    ' Clean up the table first
    Conn.Execute "delete from [" & strTable & "]"

    Row = 2
    
    Do While Sheets(strTable).Cells(Row, 1) <> ""
    
        Fields = ""
        Values = ""
        For Col = 1 To 10 '-- if you need to check more columns, then increase this number.  I limited it to 10 to avoid VBA from scanning the entire sheet (which can take a long time)
        
            Head = Sheets(strTable).Cells(1, Col)
            
            If Head <> "" Then
                Cell = Sheets(strTable).Cells(Row, Col)
                
                ' == Maybe we need to do something with the date, like format it into a specific piece that the SQL code wants
                If IsDate(Cell) Then
                    ' TODO == if the cell contains a date, it may need to be formatted specically to the SQL format
                End If
                
                Cell = Replace(Cell, "'", "")
                
                'TODO - this is particularly nasty for SQL injections.  Considering that the script would mostly be used in a controleld environment, this is ok for now.
                Fields = Fields & "[" & Head & "],"
                
                Values = Values & "'" & Cell & "',"
            End If
            
        Next Col
            
        ' == for now we do not add the time stamp or the create by but the option is there if we need it
        'Fields = Fields & "_TimeStamp,_CreatedBy"
        'Values = Values & "CURRENT_TIMESTAMP,SYSTEM_USER"
     
        Fields = Mid(Fields, 1, Len(Fields) - 1)
        Values = Mid(Values, 1, Len(Values) - 1)
            
        Sql = "INSERT INTO [" & strTable & "] (" & Fields & ") VALUES(" & Values & ")"
        Conn.Execute (Sql)
        
        Row = Row + 1
    Loop
    
    Conn.Close
    MsgBox "All done"
End Sub
