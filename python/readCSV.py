import chardet
import csv,codecs

def readCSV(file):
    output = []
    # -- detect the file encoding first
    with open(file, 'rb') as f:
        result = chardet.detect(f.read())  

    with open(file, 'rb') as csvfile:		
        # = read the file line by line
        reader = csv.DictReader(codecs.iterdecode(csvfile, result['encoding']))
        for row in reader:
            output.append(row)

    return output
    
if __name__ == '__main__':
    for x in readCSV('c:/temp/test.csv'):
        print(x)
