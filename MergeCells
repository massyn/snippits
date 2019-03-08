 'When this proc is called, it will look for how many cells there are from the current cell with the same text, then merge them all

Sub Merger()
  Application.DisplayAlerts = False
  'What is my current column
  StartColumn = ActiveCell.Column
  StartRow = ActiveCell.Row

  ComparingContent = Cells(StartRow, StartColumn).Text

  CurrentRow = StartRow

  While Cells(CurrentRow, StartColumn).Text = ComparingContent And ComparingContent <> ""
    CurrentRow = CurrentRow + 1
  Wend

  CurrentRow = CurrentRow - 1
  If CurrentRow <> StartRow Then
    Range(Cells(StartRow, StartColumn), Cells(CurrentRow, StartColumn)).Merge
    Cells(CurrentRow + 1, StartColumn).Select
  Else
    MsgBox "Is this just one cell ?"
  End If
End Sub
