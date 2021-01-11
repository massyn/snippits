' ============================================================
' == Convert PowerPoint notes to a fully automated presentation
' == Author : Phil Massyn (@massyn)
' == Date : 2021.01.11

' == Update your presentation to have the text to be spoken in the notes
' == Do not use any animation
' == run the macro


Option Explicit

Sub doTheVoice()

    Dim intSlide As Integer
    Dim strNotes As String
    Dim strTrack As String
    Dim SAPIObj As Object
    Set SAPIObj = CreateObject("SAPI.SPvoice")
    Dim secs As Long
    Dim oShp As Shape
    Dim oEffect As Effect
    Dim shpCount As Double
    Dim osld As Shapes
    Dim shpNumber As Integer
    
    With ActivePresentation
        For intSlide = 1 To .Slides.Count
        
            ' ============================================================
            ' ==                                                        ==
            ' == delete any remaining media shapes that may still exist ==
            ' ==                                                        ==
            ' ============================================================
            
            Set osld = .Slides(intSlide).Shapes
            shpNumber = 1
            For shpCount = 1 To osld.Count
                If .Slides(intSlide).Shapes(shpNumber).Type = msoMedia Then
                    .Slides(intSlide).Shapes(shpNumber).Delete
                Else
                    shpNumber = shpNumber + 1
                End If
            Next shpCount
            
            ' ============================================================
            ' ==                                                        ==
            ' ==                grab the notes from the slide           ==
            ' ==                                                        ==
            ' ============================================================
            
            strNotes = ActivePresentation.Slides(intSlide).NotesPage.Shapes.Placeholders(2).TextFrame.TextRange.Text
            
            ' ============================================================
            ' ==                                                        ==
            ' ==              save the text as a wave file              ==
            ' ==                                                        ==
            ' ============================================================
            
            strTrack = "c:\temp\myFile.wav"         ' this is just a temporary file we use.. if you don't have c:\temp, put this anywhere you like
            
            Const SAFT48kHz16BitStereo = 39
            Const SSFMCreateForWrite = 3 ' Creates file even if file exists and so destroys or overwrites the existing file
            
            Dim oFileStream, oVoice
            
            Set oFileStream = CreateObject("SAPI.SpFileStream")
            oFileStream.Format.Type = SAFT48kHz16BitStereo
            oFileStream.Open strTrack, SSFMCreateForWrite
            
            Set oVoice = CreateObject("SAPI.SpVoice")
            Set oVoice.AudioOutputStream = oFileStream
            oVoice.Speak strNotes
            
            oFileStream.Close

            ' ============================================================
            ' ==                                                        ==
            ' ==                   determine the file length            ==
            ' ==                                                        ==
            ' ============================================================
            secs = FileLen(strTrack) / 213714   ' this is roughly how many bytes we have in 1 second
            
            ' ============================================================
            ' ==                                                        ==
            ' ==            embed the wav on the slide                  ==
            ' ==                                                        ==
            ' ============================================================
                        
            Set oShp = .Slides(intSlide).Shapes.AddMediaObject2(strTrack, False, True, 10, 10)
            Set oEffect = .Slides(intSlide).TimeLine.MainSequence.AddEffect(oShp, msoAnimEffectMediaPlay, , msoAnimTriggerWithPrevious)
            oEffect.MoveTo 1
            oEffect.EffectInformation.PlaySettings.HideWhileNotPlaying = True
             
             
            ' ============================================================
            ' ==                                                        ==
            ' ==             Transition after "secs" seconds            ==
            ' ==                                                        ==
            ' ============================================================
             With .Slides(intSlide).SlideShowTransition
                .AdvanceOnClick = msoTrue
                .AdvanceOnTime = msoTrue
                .AdvanceTime = secs

            End With
        
        Next intSlide
        
    End With

End Sub
