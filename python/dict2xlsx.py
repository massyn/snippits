from io import BytesIO
import xlsxwriter

def dict2xls(d,header2 = []):
    def add_sheet(workbook,title,d):
        worksheet = workbook.add_worksheet(title)
        heading = workbook.add_format({'bold': True,    'font_color' : 'white',     'bg_color' : '#44546A', 'align' : 'center'  })
        heading2 = workbook.add_format({'bold': True,    'font_color' : 'white',     'bg_color' : '#C00000', 'align' : 'center'  })

        # == write the headers
        heads = []
        row = 0
        col = 0
        maxcol = 0
        for h in d[0]:
            heads.append(h)
            if h in header2:
                worksheet.write(row,maxcol,h,heading2)
            else:
                worksheet.write(row,maxcol,h,heading)

            maxcol += 1
        
        # = do each of the data rows
        for r in d:
            row += 1
            col = 0
            for h in heads:
                worksheet.write(row,col,r[h])
                col += 1

        # == add some filters, just to make it look pretty
        worksheet.autofilter(0,0,row,maxcol-1)
        worksheet.freeze_panes(1, 1)

    # == create the book
    output = BytesIO()
    workbook = xlsxwriter.Workbook(output)
    if type(d) == list:
        add_sheet(workbook,None,d)
    else:
        for sheet in d:
            add_sheet(workbook,sheet,d[sheet])
    
    workbook.close()

    return output.getvalue()
    
if __name__ == '__main__':
    
    # Use a key'ed list to generate multiple sheets
    data = {
        'Alpha' : [ 
            { 'Heading 1' : 'Data 1' , 'Heading 2' : 'Data 2', 'Heading 3' : 'Data 3'},
            { 'Heading 1' : 'Data 4' , 'Heading 2' : 'Data 5', 'Heading 3' : 'Data 6'}
        ],
        'Bravo' : [ 
            { 'Heading A' : 'Data 1' , 'Heading B' : 'Data 2', 'Heading C' : 'Data 3'},
            { 'Heading A' : 'Data 4' , 'Heading B' : 'Data 5', 'Heading C' : 'Data 6'}
        ]
    }
    
    with open('c:/temp/keyed list.xlsx','wb') as f:
        # specify the dictionary to use, and the headings to highlight
        f.write(dict2xls(data, ['Heading 1','Heading C']))  
    
    # Option 2 - just dump a list
    data = [ 
        { 'Heading 1' : 'Data 1' , 'Heading 2' : 'Data 2', 'Heading 3' : 'Data 3'},
        { 'Heading 1' : 'Data 4' , 'Heading 2' : 'Data 5', 'Heading 3' : 'Data 6'}
    ]
    with open('c:/temp/list.xlsx','wb') as f:
        # specify the list to use, and the heading to highlight
        f.write(dict2xls(data, ['Heading 1']))
